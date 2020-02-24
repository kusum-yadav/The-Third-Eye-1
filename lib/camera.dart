import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_tts/flutter_tts.dart';
//import 'package:camera/camera.dart';

class opencamera extends StatefulWidget {
List<CameraDescription> cameras;
opencamera(this.cameras);

  @override
  _opencameraState createState() => _opencameraState();
}

class _opencameraState extends State<opencamera> {

  CameraController controller;
 
  FlutterTts flutterTts=FlutterTts();
 
  @override
  void initState() {
    super.initState();
    controller=new CameraController(widget.cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_){
      if(!mounted){
        return;
      }
      setState(() { });
    });  
  }
  @override
  void dispose() {
     controller?.dispose();
    super.dispose();
  }

  @override
  void vibrate()
  {
     Vibration.vibrate(pattern: [200, 100, 200, 100]);
  }
  Future _speakleft() async{
    await flutterTts.speak("home menu");
  }
  Widget build(BuildContext context) {
    if(!controller.value.isInitialized){
      return new Container();
    }
    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: SwipeDetector( 
      
            child: new CameraPreview(controller) ,

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