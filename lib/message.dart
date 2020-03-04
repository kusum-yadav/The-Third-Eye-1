import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'commingsoon.dart';
import 'dart:async';
import 'package:quiver/async.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
class message extends StatefulWidget {
  @override
  _messageState createState() => _messageState();
}

class _messageState extends State<message> {
 FlutterTts flutterTts=FlutterTts();
 bool _hasSpeech = false;
  String lastWords = "";
  final SpeechToText speech = SpeechToText();
  @override
  
  void vibrate()
  {
     Vibration.vibrate(pattern: [200, 100, 200, 100]);
  }
  var _formatedDate;
  Future _speakleft() async{
    await flutterTts.speak("calling and messaging menu");
  }
  Future _speaknumber() async{
    await flutterTts.speak(lastWords);
  }
    Future _speakdown() async{
    await flutterTts.speak("message sent");
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
  Widget build(BuildContext context) {return Scaffold(
      body: new Container(
      child: SwipeDetector(
        child: Container(
            alignment: Alignment.bottomCenter,
            child: new Text("$lastWords",style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            ),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/message.jpg"),
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
                setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>commingsoon()));
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
                startListening();
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
}
}