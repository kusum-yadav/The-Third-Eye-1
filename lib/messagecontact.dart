import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:intent/intent.dart' as android_intent;
import 'package:intent/action.dart' as android_action;
import 'package:quiver/async.dart';
import 'package:the_third_eye/callingmenu.dart';
import 'package:the_third_eye/message.dart';
import 'callingmenu.dart';
import 'message.dart';
import 'package:sms_maintained/sms.dart';
import 'package:vibration/vibration.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
class messagecontact extends StatefulWidget {
  var a;
  messagecontact(this.a);
  @override
  _messagecontactState createState() => _messagecontactState();
}

class _messagecontactState extends State<messagecontact> {
  FlutterTts flutterTts=FlutterTts();
  bool _hasSpeech = false;
  String lastWords = "";
  final SpeechToText speech = SpeechToText();
  void sendsms(){
     SmsSender sender = new SmsSender();
  //String address = "9654058740";
  List<String> x = ["9654014558","9654058740"];
  String address;
  //sender.sendSms(new SmsMessage("9654014558", widget.a));
  for(var i in x){
    address=i;
  sender.sendSms(new SmsMessage(address, widget.a));
  }
  }
  @override
  void vibrate()
  {
    Vibration.vibrate(pattern: [200,100,200,100]);
  }
  Future _speakup() async{
   await flutterTts.speak(lastWords);
    }
  Future _speakdown() async{
    await flutterTts.speak(widget.a);
  }
  Future _speakleft() async{
    await flutterTts.speak("messaging menu");
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
      setState(() {
        _current = _start - duration.elapsed.inSeconds;
      });
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
            alignment: Alignment.bottomCenter,
            child: new Text(
              "$lastWords",
              style: TextStyle(
                fontSize: 20,
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
            _speakup();
            setState(() {
              // _swipeDirection = "Swipe Up";
            });
          },
          onSwipeDown: () {
            vibrate();
            _speakdown();
            startTimer();
            sendsms();
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
            startListening();
            setState(() {
              // _swipeDirection = "Swipe Right";
            });
          },
          swipeConfiguration: SwipeConfiguration(
              verticalSwipeMinVelocity: 100.0,
              verticalSwipeMinDisplacement: 50.0,
              verticalSwipeMaxWidthThreshold: 100.0,
              horizontalSwipeMaxHeightThreshold: 50.0,
              horizontalSwipeMinDisplacement: 50.0,
              horizontalSwipeMinVelocity: 200.0),
        ),
      ),
    );
  }

  void startListening() {
    lastWords = "";
    speech.listen(onResult: resultListener);
  }

  void resultListener(SpeechRecognitionResult result) {
    setState(() {
      lastWords = "${result.recognizedWords} "; //- ${result.finalResult}
    });
  }

  _launchURL() async {}
}
