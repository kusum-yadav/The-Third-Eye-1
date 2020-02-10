import 'dart:async';

import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_tts/flutter_tts.dart';
//import 'package:camera/camera.dart';

class opencamera extends StatefulWidget {

  //final CameraDescription camera;
  // WidgetsFlutterBinding.ensureInitialized();
  // final cameras = await availableCameras();
  // final firstCamera=cameras.first;

  // const opencamera({
  //   Key key,
  //    @required this.camera,
  // }) : super(key: key);

  @override
  _opencameraState createState() => _opencameraState();
}

class _opencameraState extends State<opencamera> {
  // CameraController _controller;
  // Future<void> _initializeControllerFuture;
  FlutterTts flutterTts=FlutterTts();
 
  // @override
  // void initState() {
  //   super.initState();
  //   // To display the current output from the Camera,
  //   // create a CameraController.
  //   _controller = CameraController(
  //     // Get a specific camera from the list of available cameras.
  //     widget.camera,
  //     // Define the resolution to use.
  //     ResolutionPreset.medium,
  //   );

  //   // Next, initialize the controller. This returns a Future.
  //   _initializeControllerFuture = _controller.initialize();
  // }

  // @override
  // void dispose() {
  //   // Dispose of the controller when the widget is disposed.
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  void vibrate()
  {
     Vibration.vibrate(pattern: [200, 100, 200, 100]);
  }
  Future _speakleft() async{
    await flutterTts.speak("home menu");
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: SwipeDetector( 
        //  child: FutureBuilder<void>(
        //   future: _initializeControllerFuture,
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.done) {
        //       // If the Future is complete, display the preview.
        //       return CameraPreview(_controller);
        //     } else {
        //       // Otherwise, display a loading indicator.
        //       return Center(child: CircularProgressIndicator());
        //     }
        //   },
        // ),
         child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/comingsoon.jpg"),
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