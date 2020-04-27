import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:battery/battery.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'calender.dart';
import 'battery.dart';
import 'time.dart';
import 'package:vibration/vibration.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
class more extends StatefulWidget {
  @override
  _moreState createState() => _moreState();
}

class _moreState extends State<more> {
  FlutterTts flutterTts=FlutterTts();
  @override
  void vibrate()
  {
     Vibration.vibrate(pattern: [200, 100, 200, 100]);
  }
  Future _speakup() async{
  //  await flutterTts.speak("today's date");
   DateTime now = DateTime.now();
   String formattedDate = DateFormat('EEEE\n d MMMM\n y').format(now);
  await flutterTts.speak("Today is "+formattedDate);
    }
  Future _speakdown() async{
    //  await flutterTts.speak("Current time");
    DateTime now = DateTime.now();
   String formattedDate = DateFormat('jm').format(now);
  await flutterTts.speak("current time is "+formattedDate);
  }
  Future _speakleft() async{
    await flutterTts.speak("home menu");
  }
  Future<int> _speakright() async{
    var battery = Battery();
    final int percent =await battery.batteryLevel;
    // String bp= battery.batteryLevel.toString();
  //  print(percent);

  String batterystring=percent.toString();
  int batteryint=int.parse(batterystring);
   if(batteryint<=15){
     flutterTts.speak("$batteryint percent battery left, please! charge your phone");
   }
   else{
     flutterTts.speak("$batteryint percent battery left");
   }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: SwipeDetector( 
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/More.jpg"),
                  fit: BoxFit.cover,
          ),
        ),
        ),
            // child: Image.asset('assets/images/Home.jpg'),
            onSwipeUp: () {
              vibrate();
              _speakup();
              setState(() {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>calender()));
                // _swipeDirection = "Swipe Up";
              });
            },
            onSwipeDown: () {
              vibrate();
              _speakdown();
              setState(() {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>time()));
                // _swipeDirection = "Swipe Down";
              });
            },
            onSwipeLeft: () {
              vibrate();
              _speakleft();
              setState(() {
                Navigator.pop(context);
                // _swipeDirection = "Swipe Left";
              });
            },
            onSwipeRight: () {
              vibrate();
              _speakright();
              setState(() {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>battery()));
                // _swipeDirection = "Swipe Right";
              });
            },
            swipeConfiguration: SwipeConfiguration(
        verticalSwipeMinVelocity: 100.0,
        verticalSwipeMinDisplacement: 50.0,
        verticalSwipeMaxWidthThreshold:100.0,
        horizontalSwipeMaxHeightThreshold: 50.0,
        horizontalSwipeMinDisplacement:50.0,
        horizontalSwipeMinVelocity: 200.0),
          ),
        );
  }
}