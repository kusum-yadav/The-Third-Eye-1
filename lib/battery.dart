import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:battery/battery.dart';

class battery extends StatefulWidget {
  @override
  _batteryState createState() => _batteryState();
}

class _batteryState extends State<battery> {
  FlutterTts flutterTts=FlutterTts();
  @override
  void vibrate()
  {
     Vibration.vibrate(pattern: [200, 100, 200, 100]);
  }
  var _percent;
  Future _speakleft() async{
    await flutterTts.speak("more menu");
  }
  Future<int> _batterypercentage() async{
    var battery = Battery();
    final int percent =await battery.batteryLevel;
    return percent;
  }

   _batteryState(){
   _batterypercentage().then((percent) {
            setState(() {
                _percent = percent;
            });
        });
 }

  Widget build(BuildContext context) {
    return Scaffold(
          body:new Container(
        child: SwipeDetector( 
          child: Container(
            alignment: Alignment.center,
            child: new Text("$_percent%",style: TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.bold,
            ),),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/battery.jpg"),
                    fit: BoxFit.cover,
            ),
          ),
          ),
              // child: Image.asset('assets/images/Home.jpg'),
              onSwipeUp: () {
                setState(() {
                  // _swipeDirection = "Swipe Up";
                });
              },
              onSwipeDown: () {
                setState(() {
                  // _swipeDirection = "Swipe Down";
                });
              },
              onSwipeLeft: () {
                vibrate();
                _speakleft();
                setState(() {
                   Navigator.pop(context);
                });
              },
              onSwipeRight: () {
                setState(() {
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
          ),
    );
  }
}