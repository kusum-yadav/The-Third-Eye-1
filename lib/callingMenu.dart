import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'contactList.dart';
import 'dialer.dart';
class callingmenu extends StatefulWidget {
  @override
  _callingmenuState createState() => _callingmenuState();
}

class _callingmenuState extends State<callingmenu> {
  FlutterTts flutterTts=FlutterTts();
  @override
  void vibrate()
  {
     Vibration.vibrate(pattern: [200, 100, 200, 100]);
  }
  Future _speakleft() async{
    await flutterTts.speak("Calling and messaging menu");
  }
  Future _speakup() async{
    await flutterTts.speak("Contact list");
  }
  Future _speakdown() async{
    await flutterTts.speak("Dialer");
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: SwipeDetector( 
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/Calling.jpg"),
                  fit: BoxFit.cover,
          ),
        ),
        ),
            // child: Image.asset('assets/images/Home.jpg'),
            onSwipeUp: () {
              _speakup();
              vibrate();
              setState(() {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>contactList()));
                // _swipeDirection = "Swipe Up";
              });
            },
            onSwipeDown: () {
              _speakdown();
              vibrate();
              setState(() {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>dialer()));
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
        );
  }
}