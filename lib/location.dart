import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import 'camera.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:vibration/vibration.dart';
class location extends StatefulWidget {
  @override
  _locationState createState() => _locationState();
}

class _locationState extends State<location> {
  FlutterTts flutterTts=FlutterTts();
  @override
  void vibrate()
  {
     Vibration.vibrate(pattern: [200, 100, 200, 100]);
  }
  Future _speakleft() async{
    await flutterTts.speak("home menu");
  }
  Future _speakright() async{
    await flutterTts.speak("emergency location sent");
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: SwipeDetector( 
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/location.jpg"),
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