import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {

  dynamic sportsItem;
  dynamic button;
  bool gender;

  ScheduleScreen(this.sportsItem, this.button, this.gender) {

  }

  @override
  State<StatefulWidget> createState() {
    return _ScheduleScreenState(sportsItem, button, gender);
  }
}

class _ScheduleScreenState extends State<ScheduleScreen>{

  dynamic sportsItem;
  dynamic button;
  bool gender;

  _ScheduleScreenState(this.sportsItem, this.button, this.gender) {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Schedule"),
        ),
        body: Center(
        child: Text("Schedule" + sportsItem.toString()),
    ));
  }

}