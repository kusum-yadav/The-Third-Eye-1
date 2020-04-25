import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:sms_maintained/sms.dart';
import 'package:vibration/vibration.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:contacts_service/contacts_service.dart';
import 'dart:async';

class messagecontact extends StatefulWidget {
  var a;
  messagecontact(this.a);
  @override
  _messagecontactState createState() => _messagecontactState();
}

class _messagecontactState extends State<messagecontact> {
  FlutterTts flutterTts = FlutterTts();
  // startListening();
  @override
  void vibrate() {
    Vibration.vibrate(pattern: [200, 100, 200, 100]);
  }
Future _speakup() async {
    await flutterTts.speak("$Name");
  }

  Future _speakleft() async {
    await flutterTts.speak("Calling menu");
  }

  Future _speakdown() async {
    await flutterTts.speak("message sent to $Name");
  }

  bool _hasSpeech = false;
  List<Contact> _contacts;
  final SpeechToText speech = SpeechToText();
  String Name = "";
  List a;
  int number;

  Retrive() async {
    Iterable<Contact> Contacts =
        (await ContactsService.getContacts(query: Name)).toList();
    setState(() {
      for (var i in Contacts) {
        print(i.phones.map((f) => f.value).toList());
      }
      _contacts = Contacts;
    });
    Contact x = _contacts.elementAt(0);
    a = x.phones.map((f) => f.value).toList();
    SmsSender sender = new SmsSender();
    sender.sendSms(new SmsMessage(a[0], widget.a));
  }

  void startListening() {
    Name = "";
    speech.listen(onResult: resultListener);
  }

  void resultListener(SpeechRecognitionResult result) {
    setState(() {
      Name = "${result.recognizedWords}";
    });
  }

  @override
  void initState() {
    initSpeechState();
    super.initState();
  }

  Future<void> initSpeechState() async {
    bool hasSpeech = await speech.initialize();
    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        child: SwipeDetector(
          child: Container(
            alignment: Alignment.bottomCenter,
            child: new Text(
              "\n\n$Name",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/Calling2.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          onSwipeUp: () {
            vibrate();
            _speakup();
            setState(() {
              
            });
          },
          onSwipeDown: () {
            vibrate();
            _speakdown();
            Timer(Duration(seconds: 4), () {
              Retrive();
              // _launchURL();
            });
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
            // startTimer();

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
}
