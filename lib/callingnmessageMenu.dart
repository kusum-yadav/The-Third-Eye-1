import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:intent/intent.dart' as android_intent;
import 'package:intent/action.dart' as android_action;
//import 'camera.dart';
import 'package:quiver/async.dart';
import 'package:the_third_eye/callingmenu.dart';
import 'package:the_third_eye/message.dart';
import 'callingmenu.dart';
import 'message.dart';
//import 'emergencyCall.dart';
import 'package:vibration/vibration.dart';
class callingnmessageMenu extends StatefulWidget {
  @override
  _callingnmessageMenuState createState() => _callingnmessageMenuState();
}

class _callingnmessageMenuState extends State<callingnmessageMenu> {
  FlutterTts flutterTts=FlutterTts();
  @override
  void vibrate()
  {
    Vibration.vibrate(pattern: [200,100,200,100]);
  }
  Future _speakup() async{
   await flutterTts.speak("Calling Menu");
    }
  Future _speakdown() async{
    await flutterTts.speak("emergency number calling");
  }
  Future _speakleft() async{
    await flutterTts.speak("home menu");
  }
  Future _speakright() async{
    await flutterTts.speak("Messaging Menu");
  }
int _start = 1;
int _current = 1;

void startTimer() {
  CountdownTimer countDownTimer = new CountdownTimer(
    new Duration(seconds: _start),
    new Duration(seconds: 1),
  );

  var sub = countDownTimer.listen(null);
  sub.onData((duration) {
    setState(() { _current = _start - duration.elapsed.inSeconds; });
  });

  sub.onDone(() {
    _launchURL();
    sub.cancel();
  });
}
  Widget build(BuildContext context) {
    return Scaffold(
      body: SwipeDetector(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage("assets/images/callnmsg.jpg"),
            fit: BoxFit.cover,
            ),
          ),
        ),
        onSwipeUp: () {
              vibrate();
              _speakup();
              setState(() {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>callingmenu()));
                // _swipeDirection = "Swipe Up";
              });
            },
            onSwipeDown: () {
              vibrate();
            //Timer(Duration(seconds: 3), () {
            // print("Yeah, this line is printed after 3 seconds");
            // });
              for(int i=0;i<1;i++){
                _speakdown();
              }
              startTimer();
              // _launchURL();
              // setState(() {
              //   Navigator.push(context, MaterialPageRoute(builder: (context) =>));
              //   // _swipeDirection = "Swipe Down";
              // });
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
                Navigator.push(context, MaterialPageRoute(builder: (context) =>message()));
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
_launchURL() async {
  android_intent.Intent()
    ..setAction(android_action.Action.ACTION_CALL)
    ..setData(Uri(scheme: "tel", path: "9654058740"))  // Replace 12345678 with your tel. no.
    ..startActivity().catchError((e) => print(e));
}