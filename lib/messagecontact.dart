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
  bool _hasSpeech = false;
  List Name;
  Contact x;
  String _name;
  String lastWords = "";
  final SpeechToText speech = SpeechToText();

  @override
  void vibrate() {
    Vibration.vibrate(pattern: [200, 100, 200, 100]);
  }

  Future _speakup() async {
    await flutterTts.speak("$_name");
  }

  Future _speakdown() async {
    await flutterTts.speak("Messsage sent to ");
  }

  Future _speakleft() async {
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

  List<Contact> _contacts;

  Retrive() async {
    Iterable<Contact> Contacts =(await ContactsService.getContacts(query: "mayank")).toList();
    setState(() {
      _contacts = Contacts;
      print(_contacts);
    });
    x = _contacts.elementAt(0);
    _name=x.displayName;
    Name = x.phones.map((f) => f.value).toList();
    // print(Name);
    SmsSender sender = new SmsSender();
    sender.sendSms(new SmsMessage(Name[0], widget.a));
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

            });

            setState(() {

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

}
