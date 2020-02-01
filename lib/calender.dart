import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:intl/intl.dart';
class calender extends StatefulWidget {
  @override
  _calenderState createState() => _calenderState();
}

class _calenderState extends State<calender> {
  FlutterTts flutterTts=FlutterTts();

  @override
  
  void vibrate()
  {
     Vibration.vibrate(pattern: [200, 100, 200, 100]);
  }
  Future _speakleft() async{

    await flutterTts.speak("more menu");
  }
  Widget build(BuildContext context) {
      
    return Scaffold(
      body: SwipeDetector( 
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/comingsoon.jpg"),
                  fit: BoxFit.cover,
          ),
        ),
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     Text("hello",
        //     style: TextStyle(
        //       fontFamily: 'Lobster',
        //     ),
        //     )
        //   ],
        // ),

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
        
        );
        
  }
}
//kk:mm:ss \n 