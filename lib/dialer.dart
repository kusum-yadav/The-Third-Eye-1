import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';
import 'package:quiver/async.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:intent/intent.dart' as android_intent;
import 'package:intent/action.dart' as android_action;
class dialer extends StatefulWidget {
  @override
  _dialerState createState() => _dialerState();
}

class _dialerState extends State<dialer> {
  FlutterTts flutterTts=FlutterTts();
  bool _hasSpeech = false;
  String lastWords = "";
  final SpeechToText speech = SpeechToText();
  @override
  void vibrate()
  {
     Vibration.vibrate(pattern: [200, 100, 200, 100]);
  }
  Future _speakleft() async{
    await flutterTts.speak("Calling menu");
  }
   Future _speaknumber() async{
    await flutterTts.speak(lastWords);
  }
  Future _speakdown() async{
    await flutterTts.speak("calling $lastWords");
  }
    @override
    void initState() {
    super.initState();
    initSpeechState();
  }
  
  Future<void> initSpeechState() async {
    bool hasSpeech = await speech.initialize();
    setState(() {
      _hasSpeech = hasSpeech;
    });
  }
  int _start = 4;
int _current = 4;

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
      body: new Container(
      child: SwipeDetector(
        child: Container(
            alignment: Alignment.center,
            child: new Text("$lastWords",style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
            ),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/blank.jpg"),
                  fit: BoxFit.cover,
          ),
        ),
        ),
            // child: Image.asset('assets/images/Home.jpg'),
            onSwipeUp: () {
              vibrate();
              _speaknumber();
              setState(() {
                // _swipeDirection = "Swipe Up";
              });
            },
            onSwipeDown: () {
              vibrate();

                _speakdown();

              startTimer();
              // _launchURL();
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
              startListening();//:print("speech recognition not available");
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
    void startListening() {
    lastWords = "";
    speech.listen(onResult: resultListener );
  }
  void resultListener(SpeechRecognitionResult result) {
    setState(() {
      lastWords = "${result.recognizedWords} ";//- ${result.finalResult}
    });
  }
  _launchURL() async {
  android_intent.Intent()
    ..setAction(android_action.Action.ACTION_CALL)
    ..setData(Uri(scheme: "tel", path: "$lastWords"))  
    ..startActivity().catchError((e) => print(e));
}
}