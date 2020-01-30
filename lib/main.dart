import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'callingMenu.dart';
import 'camera.dart';
import 'more.dart';
import 'location.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      home: new MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() =>new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterTts flutterTts=FlutterTts();
  @override
  void vibrate()
  {
    Vibration.vibrate(pattern: [200, 100, 200, 100]);
  }
  Future _speakup() async{
    await flutterTts.speak("Calling menu");
  }
  Future _speakdown() async{
    await flutterTts.speak("camera");
  }
  Future _speakleft() async{
    await flutterTts.speak("more menu");
  }
  Future _speakright() async{
    await flutterTts.speak("Location");
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: SwipeDetector( 
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/Home.jpg"),
                fit: BoxFit.cover,
              ),
          ),
        ),
        onSwipeUp: (){
          vibrate();
          _speakup();
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>callingMenu()));
          });
        },
        onSwipeDown: () {
              vibrate();
               _speakdown();
              setState(() {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>camera()));
              });
            },
            onSwipeLeft: () {
              vibrate();
               _speakleft();
              setState(() {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>more()));
              });
            },
            onSwipeRight: () {
              vibrate();
               _speakright();
              setState(() {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>location()));
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
