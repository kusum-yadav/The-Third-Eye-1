import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:intl/intl.dart';
class time extends StatefulWidget {
  @override
  _timeState createState() => _timeState();
}

class _timeState extends State<time> {
  FlutterTts flutterTts=FlutterTts();
  @override
  void vibrate()
  {
     Vibration.vibrate(pattern: [200, 100, 200, 100]);
  }

  Future _speakleft() async{
    await flutterTts.speak("more menu");
  }
   var _formatedtime;
  Future<String> _dateandtime() async{
    DateTime now = DateTime.now();
   String formatedtime = DateFormat('jm').format(now);


  
    // var battery = Battery();
    // final int percent =await battery.batteryLevel;
    print(formatedtime);
    return formatedtime;
  }

   _timeState(){
   _dateandtime().then((date) {
            // If we need to rebuild the widget with the resulting data,
            // make sure to use `setState`
            setState(() {
                _formatedtime = date;
            });
        });
 }
  Widget build(BuildContext context) {
    return Scaffold(
          body:new Container(
        child: SwipeDetector( 
          child: Container(
            alignment: Alignment.center,
            child: new Text("$_formatedtime",style: TextStyle(
              fontSize: 70,
              fontWeight: FontWeight.bold,
            ),),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/time.jpg"),
                    fit: BoxFit.cover,
            ),
          ),
          ),
              // child: Image.asset('assets/images/Home.jpg'),
              onSwipeUp: () {
                flutterTts.speak('$_formatedtime');
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