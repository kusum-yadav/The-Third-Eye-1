import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

import 'camera.dart';
import 'bndbox.dart';
import 'models.dart';

class CamHome extends StatefulWidget {
  final List<CameraDescription> cameras;

  CamHome(this.cameras);

  @override
  _CamHomeState createState() => new _CamHomeState();
}

class _CamHomeState extends State<CamHome> {
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = ssd;

 
  void vibrate()
  {
     Vibration.vibrate(pattern: [200, 100, 200, 100]);
  }
  FlutterTts flutterTts=FlutterTts();
  Future _speakleft() async{
    await flutterTts.speak("home menu");
  }
  
  @override
  void initState() {
    super.initState();
    loadModel();
  }

  loadModel() async {
    String res;
     res = await Tflite.loadModel(
            model: "assets/models/ssd_mobilenet.tflite",
            labels: "assets/models/ssd_mobilenet.txt");
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: SwipeDetector(
                child: Stack(
                  children: [
                    Camera(
                      widget.cameras,
                      _model,
                      setRecognitions,
                    ),
                    BndBox(
                        _recognitions == null ? [] : _recognitions,
                        math.max(_imageHeight, _imageWidth),
                        math.min(_imageHeight, _imageWidth),
                        screen.height,
                        screen.width,
                        _model),
                  ],
                ),
                onSwipeLeft: () {
                  vibrate();
                  _speakleft();
                  setState(() {
                     Navigator.pop(context);
                  });
                },
        ),
      ),
    );
  }
}
