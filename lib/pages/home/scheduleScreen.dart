import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sgnj/utils/firebase_anon_auth.dart';

class ScheduleScreen extends StatefulWidget {

  final dynamic sportsItem;
  final dynamic category;
  final bool gender;
  
  
  ScheduleScreen(this.sportsItem, this.category, this.gender);

  @override
  State<StatefulWidget> createState() {
    return _ScheduleScreenState(sportsItem, category, gender);
  }
}

class _ScheduleScreenState extends State<ScheduleScreen>{

  final dynamic sportsItem;
  final dynamic category;
  final bool gender;
  String userId;

  final FirebaseAnonAuth firebaseAnonAuth = new FirebaseAnonAuth();

  
  _ScheduleScreenState(this.sportsItem, this.category, this.gender){
     firebaseAnonAuth.signInAnon().then((user) {
      this.userId = user.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
        child: scheduleList(context),
    ));
  }

  Widget scheduleList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("events")
                                .where("category", isEqualTo: category["name"])
                                .where("gender", isEqualTo: gender)
                                .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(!snapshot.hasData){
          return CircularProgressIndicator();
        } else {
          //return ListView(children: getExpenseItems(snapshot));
          return eventsList(snapshot);
        }
      },
    );
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .map((doc) => new ListTile(title: new Text(doc["category"]), subtitle: new Text(doc["gender"].toString())))
        .toList();
  }

  eventsList(AsyncSnapshot<QuerySnapshot> snapshot){
      return CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 100.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              //background: Image.network("https://i.ibb.co/zNQkbJZ/gameday.png"),
              centerTitle: true,
              title: Text('Schedule')
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Card(
                child: new Container(
                  padding: EdgeInsets.all(10.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            displayTeams(snapshot.data.documents[index]["teams"]),
                            displayLocation(snapshot.data.documents[index]["location"]),
                            displayStatus(snapshot.data.documents[index]["status"])
                          ],
                        )
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          displayTimeAndDate(snapshot.data.documents[index]["startTime"]),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          subscribeToEvent(snapshot.data.documents[index].documentID),
                        ],
                      )
                    ],
                  )
                ),
              );
            },
            childCount: snapshot.data.documents.length
            ),
          )
        ],
      );
  }

  displayTeams(teams) {
    if(teams != null && teams.length == 2){
      return Text(
        teams[0]["name"]+" vs "+teams[1]["name"],
        style: TextStyle(
            color: Colors.black,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            fontFamily: "WorkSansSemiBold"
          )
        );
    } else if(teams != null && teams.length == 1){
      return Text(teams[0]["name"]+" vs --");
    } else if(teams != null && teams.length >= 2){
      return Text("");
    } else {
      return Text("");
    }
                          
  }
  displayLocation(location) {
    if(location != null){
      return Text(
        location,
        textAlign: TextAlign.left);
    } else {
      return Text("");
    }
  }

  dynamic months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  displayTimeAndDate(Timestamp startTime){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        getTime(startTime),
        getDate(startTime),        
    ]);
  }
  getDate(Timestamp startTime){
    if(startTime != null){
      return Text(startTime.toDate().toUtc().day.toString()+" "+months[startTime.toDate().toUtc().month]);
    } else {
      return Text("");
    }
  }

  getTime(Timestamp startTime){
    print(startTime.toDate());
    if(startTime != null){
      String padding = startTime.toDate().toUtc().minute <= 9 ? "0": "";
      String hour = startTime.toDate().toUtc().hour.toString();
      String sufix = "AM";
      if(startTime.toDate().toUtc().hour >= 12){
        hour = (startTime.toDate().toUtc().hour-12).toString();
        sufix = "PM";
      }
      return Text(
        hour
        +":"
        +padding
        +startTime.toDate().toUtc().minute.toString()
        +" "
        +sufix,
        style: TextStyle(
          fontSize: 24.0    
        ));
    } else {
      return Text("");
    }
  }

  displayStatus(String status){
    return Text(status);
  }

  bool enabled = false;
  subscribeToEvent(documentID){
    //bool enabled = getData(documentID) == "false"?false:true;
    return Container(
      padding: EdgeInsets.all(10.0),
      child: InkWell(
            onTap: () {
              setState(() {
                enabled = !enabled;
              });
              print(enabled);
              print("subscribe to: "+documentID);
              getData(documentID);
              //updateData(documentID, true);
            },
            child: Image.asset(
                 enabled?"assets/images/bell-regular.png":"assets/images/bell-solid.png",
                width: 30,
              )));
  }

  updateData(key, value){
    
    
  }

  getData(key){
    Stream<DocumentSnapshot> preferences = Firestore.instance.collection("devices").document("preferences").collection(userId).document("subscriptions")
                                .snapshots();
    preferences.listen((data) {
      print(data);
    });   
  }
  
}