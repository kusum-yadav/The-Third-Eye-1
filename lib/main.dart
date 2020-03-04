import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'callingnmessageMenu.dart';
import 'camera.dart';
import 'more.dart';
import 'location.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;

Future<void> main() async{
   WidgetsFlutterBinding.ensureInitialized();
   cameras = await availableCameras();
  // final firstCamera = cameras.first;
  runApp(MyApp());
  }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      home: new MyHomePage(cameras),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  var cameras;
  MyHomePage(this.cameras);
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
    await flutterTts.speak("Calling And Messaging menu");
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
            Navigator.push(context, MaterialPageRoute(builder: (context)=>callingnmessageMenu()));
          });
        },
        onSwipeDown: () {
              vibrate();
               _speakdown();
              setState(() {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>opencamera(widget.cameras)));
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
