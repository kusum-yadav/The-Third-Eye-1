import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:intent/intent.dart' as android_intent;
import 'package:intent/action.dart' as android_action;
import 'package:quiver/async.dart';
class contactList extends StatefulWidget {
  @override
  _contactListState createState() => _contactListState();
}

class _contactListState extends State<contactList> {
  FlutterTts flutterTts=FlutterTts();
  @override
  void vibrate()
  {
     Vibration.vibrate(pattern: [200, 100, 200, 100]);
  }
  Future _speakleft() async{
    await flutterTts.speak("Calling menu");
  }
  bool _hasSpeech = false;
  List<Contact> _contacts;
  final SpeechToText speech = SpeechToText();
  String Name="";
  // Retrive() async{
  //   Iterable<Contact> Contacts=(await ContactsService.getContacts(query: Name)).toList();
  //   setState(() {
  //     _contacts=Contacts;
  //   });  
  // }
  void startListening() {
    Name = "";
    speech.listen(onResult: resultListener );
  }
  void resultListener(SpeechRecognitionResult result){
    setState(() async{
      Iterable<Contact> Contacts=(await ContactsService.getContacts(query: "${result.recognizedWords} ")).toList();
      _contacts=Contacts;
      // Name = "${result.recognizedWords} ";//- ${result.finalResult}
    });
  }
  
  @override
  void initState(){
    initSpeechState();
    super.initState();
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
    // _launchURL();
    sub.cancel();
  });
}


//   _launchURL() async {
//   android_intent.Intent()
//     ..setAction(android_action.Action.ACTION_CALL)
//     ..setData(Uri(scheme: "tel", path: "$Number"))  
//     ..startActivity().catchError((e) => print(e));
// }

// Contact c= _contacts ?.elementAt(0);

  Widget build(BuildContext context) {
    return Scaffold(
      body: SwipeDetector( 
        child: Container(
          child: _contacts!=null
                ?ListView.builder(
                  itemCount: _contacts?.length ?? 0,
                  itemBuilder: (BuildContext context,int index){
                    Contact c=_contacts ?.elementAt(index);
                    Iterable<Item> x=c.phones;
                    return ListTile(
                        title:Text(c.displayName ?? ""),
                    );
                  }
                  )
                :Center(child:CircularProgressIndicator()),
          color: Colors.yellow,
        //   decoration: BoxDecoration(
        //       image: DecorationImage(
        //           image: AssetImage("assets/images/comingsoon.jpg"),
        //           fit: BoxFit.cover,
        //   ),
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
        );
  }
}