import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'camera.dart';
import 'package:vibration/vibration.dart';
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
   await flutterTts.speak("today's date");
    }
  Future _speakdown() async{
    await flutterTts.speak("Current time");
  }
  Future _speakleft() async{
    await flutterTts.speak("home menu");
  }
  Future _speakright() async{
    await flutterTts.speak("battery percentage");
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
                Navigator.push(context, MaterialPageRoute(builder: (context) =>camera()));
                // _swipeDirection = "Swipe Up";
              });
            },
            onSwipeDown: () {
              vibrate();
              _speakdown();
              setState(() {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>camera()));
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
                Navigator.push(context, MaterialPageRoute(builder: (context) =>camera()));
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