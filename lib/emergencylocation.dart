import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:vibration/vibration.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'dart:async';
class emergencyLocation extends StatefulWidget {
  @override
  _emergencyLocationState createState() => _emergencyLocationState();
}
class _emergencyLocationState extends State<emergencyLocation> {
  FlutterTts flutterTts=FlutterTts();
  Map<String,double> currentLocation=new Map();
  StreamSubscription<Map<String,double>> locationSubscription;
  Location location=new Location();
  void initState(){
    super.initState();
    currentLocation['latitude'] = 0.0;
    currentLocation['longitude'] = 0.0;
    
    initPlatformState();
    locationSubscription=location.onLocationChanged().listen((Map<String,double>result){
      setState(() {
        currentLocation=result;
      });
    }); 
      }
      String error;
  @override
  void vibrate()
  {
     Vibration.vibrate(pattern: [200, 100, 200, 100]);
  }
  Future _speakleft() async{
    await flutterTts.speak("home menu");
  }
  Future _speakright() async{
    await flutterTts.speak("emergency location sent to Harshit Gupta");
  }
  Widget build(BuildContext context) {return Scaffold(
          body:new Container(
        child: SwipeDetector( 
          child: Container(
            alignment: Alignment.topCenter,
            child: new Text('\n${currentLocation['latitude']}/${currentLocation['longitude']}',style: TextStyle(
              fontSize: 70,
              fontWeight: FontWeight.bold,
            ),),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/location.jpg"),
                    fit: BoxFit.cover,
            ),
          ),
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
                _speakright();
                setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>emergencyLocation()));
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
  void initPlatformState() async {
        Map<String,double> my_location;
        try{
          my_location=await location.getLocation();
          error="";
        }on PlatformException catch(e){
          if(e.code == 'PERMISSION_DENIED')
          error= 'Permission Denied';
          else if(e.code== 'PERMISSION_DENIED_NEVER_ASK')
          error= 'permission denied by user';
          my_location=null;  
        }
        setState(() {
          currentLocation=my_location;
        });
      }
}