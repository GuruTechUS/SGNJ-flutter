import 'package:flutter/material.dart';
import 'package:sgnj/pages/home/scheduleScreen.dart';
import 'package:sgnj/style/themeColor.dart';
import 'package:sgnj/utils/tab_indication_painter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  
  bool _gender = false;
  Color left = Colors.black;
  Color right = Colors.white;

  String userId = "";

  @override
  void initState() {
    print("test");
    super.initState();
  }

  
    
  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(//SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height >= 775.0
            ? MediaQuery.of(context).size.height
            : 775.0,
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
              colors: [ThemeColors.pageStart, ThemeColors.pageEnd],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: _buildLogo(context)),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: _buildMenuBar(context),
              ),
            ],
          ),
          Container(
            child: _categoryList(context),
          )
          
        ]),
      ),
    );
  }

  Widget _categoryList(BuildContext context) {
    return Container(
        child: Column(
        children: <Widget>[
          Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.only(left: 35.0, top: 10.0),
            child: Text(
          "Girls",
          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24.0,
                            fontFamily: "WorkSansSemiBold"),
          ),
        ),
        ),
        _buildCards(context, false),
         Container(
          width: MediaQuery.of(context).size.width,
          child:
        Padding(
          padding: EdgeInsets.only(left: 35.0, top: 10.0),
          child: Text(
          "Boys",
          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24.0,
                            fontFamily: "WorkSansSemiBold"),
          ),
        )),
        _buildCards(context, true),
      ],
    ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          child: SpinKitRipple(
            color: Colors.white,
            size: 100.0,
          ),
        ),
        Positioned(
            left: 20.0,
            top: 20.0,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 40.0,
                        height: 40.0,
                      ),
                    ))))
      ],
    );
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
        width: 200.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: Color(0x552B2B2B),
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        child: Column(
          children: <Widget>[
            CustomPaint(
              painter: TabIndicationPainter(position: _gender),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: _onGilrsSelected,
                      child: Text(
                        "Girls",
                        style: TextStyle(
                            color: left,
                            fontSize: 16.0,
                            fontFamily: "WorkSansSemiBold"),
                      ),
                    ),
                  ),
                  //Container(height: 33.0, width: 1.0, color: Colors.white),
                  Expanded(
                    child: FlatButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: _onBoysSelected,
                      child: Text(
                        "Boys",
                        style: TextStyle(
                            color: right,
                            fontSize: 16.0,
                            fontFamily: "WorkSansSemiBold"),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  void _onGilrsSelected() {
    setState(() {
      this._gender = false;
      this.left = Colors.black;
      this.right = Colors.white;
    });
  }

  void _onBoysSelected() {
    setState(() {
      this._gender = true;
      this.right = Colors.black;
      this.left = Colors.white;
    });
  }

  Widget _buildCards(BuildContext context, bool gender) {
    final sportsList = [
      {"name": "soccer", "title": "Soccer"},
      {"name": "basketball", "title": "Basket Ball"},
      {"name": "volleyball", "title": "Volleyball"},
      {"name": "track", "title": "Track"}
    ];
    return Container(
        child: Padding(
            padding: EdgeInsets.only(left: 0.0, top: 10.0),
            child: SizedBox(
              height: 220.0,
              child: ListView.builder(
                itemCount: sportsList.length,
                padding: EdgeInsets.only(left: 30.0),
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return _buildSportCard(
                      context, index, sportsList[index], gender);
                },
              ),
            ))
      );
  }

  Widget _buildSportCard(
      BuildContext context, int index, dynamic sportsItem, bool gender) {
    final categoryList = [
      {"name": "u10", "desc": "Under 10"},
      {"name": "u14", "desc": "Under 14"},
      {"name": "u18", "desc": "Under 18"},
      {"name": "a18", "desc": "18 & Above"}
    ];
    return Container(
      width: 180.0,
      child: Card(
          elevation: 5.0,
          child: Wrap(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 5.0),
                  child: Center(
                      child: Text(
                    sportsItem["title"],
                    style: TextStyle(
                        color: gender ? Colors.blue : Colors.pink,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: "WorkSansSemiBold"),
                  ))),
              Container(
                width: 180.0,
                height: 180.0,
                child: GridView.builder(
                    itemCount: categoryList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int index) {
                      return _categoryItem(
                          context, index, sportsItem, categoryList[index], gender);
                    }),
              )
              /**/
            ],
          )),
    );
  }

  Widget _categoryItem(
      BuildContext context, int index, dynamic sportsItem, dynamic button, bool gender) {
    return Center(
        child: Stack(children: <Widget>[
      Positioned(
          top: 10.0,
          child: MaterialButton(
            shape: new CircleBorder(),
            elevation: 0.0,
            padding: const EdgeInsets.all(15.0),
            color: gender ? Colors.blue : Colors.pink,
            child: Transform.rotate(
                angle: -0.5,
                child: Text(
                  button['name'],
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "WorkSansSemiBold"),
                )),
            onPressed: () {
              print(sportsItem);
              print(button);
              print(gender?'boys':'girls');
              print("test");
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ScheduleScreen(sportsItem, button, gender);
              }));
            },
          )),
      Positioned(
          top: 60.0,
          child: Container(
              width: 88.0,
              child: Center(
                  child: Text(
                button['desc'],
                style: TextStyle(
                    color: gender ? Colors.blue : Colors.pink,
                    fontSize: 8.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "WorkSansSemiBold"),
              ))))
    ]));
  }
}
