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
  var _formatedDate;
  Future _speakleft() async{
    await flutterTts.speak("more menu");
  }
  
  Future<String> _dateandtime() async{
    DateTime now = DateTime.now();
   String formatedDate = DateFormat(' EEEE\n d MMMM\n  y').format(now);
    // var battery = Battery();
    // final int percent =await battery.batteryLevel;
    return formatedDate;
  }
  Future _speakup() async{

  await flutterTts.speak("Today is "+_formatedDate);
    }

   _calenderState(){
   _dateandtime().then((date) {
            // If we need to rebuild the widget with the resulting data,
            // make sure to use `setState`
            setState(() {
                _formatedDate = date;
            });
        });
 }
  Widget build(BuildContext context) {return Scaffold(
          body:new Container(
        child: SwipeDetector( 
          child: Container(
            alignment: Alignment.center,
            child: new Text("$_formatedDate",style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,

            ),textAlign: TextAlign.center,),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/date.jpg"),
                    fit: BoxFit.cover,
            ),
          ),
          ),
              // child: Image.asset('assets/images/Home.jpg'),
              onSwipeUp: () {
                _speakup();
                vibrate();
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