import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:intent/intent.dart' as android_intent;
import 'package:intent/action.dart' as android_action;
import 'dart:async';

class contactList extends StatefulWidget {
  @override
  _contactListState createState() => _contactListState();
}

class _contactListState extends State<contactList> {
  FlutterTts flutterTts = FlutterTts();
  var _callnum;
  // startListening();
  @override
  void vibrate() {
    Vibration.vibrate(pattern: [200, 100, 200, 100]);
  }

  Future _speakleft() async {
    await flutterTts.speak("Calling menu");
  }
  Future _speakright() async {
    await flutterTts.speak("calling $Name");
  }
  bool _hasSpeech = false;
  List<Contact> _contacts;
  final SpeechToText speech = SpeechToText();
  String Name = "";
  List a;
  // int number;

  Retrive() async {
    
    Iterable<Contact> Contacts =
        (await ContactsService.getContacts(query: Name)).toList();
    setState(() {
      _contacts = Contacts;
    });
    Contact x = _contacts.elementAt(0);
    // a=x.displayName;
    a = x.phones.map((f) => f.value).toList();
    // _launchURL();
    _speakright();
    Timer(Duration(seconds:2),(){
         _callnum=a[0];
        _launchURL();
      });
    // startTimer();
    // number=int.parse(a[0]);
  }

  void startListening() {
    Name = "";
    speech.listen(onResult: resultListener);
  }

  void resultListener(SpeechRecognitionResult result) {
    setState(() {
      Name = "${result.recognizedWords}";

      // Name = "${result.recognizedWords} ";//- ${result.finalResult}
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

  _launchURL() async {
    android_intent.Intent()
      ..setAction(android_action.Action.ACTION_CALL)
      ..setData(Uri(scheme: "tel", path: "$_callnum"))
      ..startActivity().catchError((e) => print(e));
  }

// Contact c= _contacts ?.elementAt(0);

  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
      child: SwipeDetector(
        child: Container(
            alignment: Alignment.bottomCenter,
            child: new Text("\n\n$Name",style: TextStyle(
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
          vibrate();
          startListening();
          // startTimer();
          Timer(Duration(seconds:4),(){
          Retrive();
          // _launchURL();
          });

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
    ),);
  }
}
