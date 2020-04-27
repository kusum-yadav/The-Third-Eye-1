// import 'package:flutter/material.dart';
// import 'package:swipedetector/swipedetector.dart';
// import 'package:vibration/vibration.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// class commingsoon extends StatefulWidget {
//   @override
//   _commingsoonState createState() => _commingsoonState();
// }

// class _commingsoonState extends State<commingsoon> {
//  FlutterTts flutterTts=FlutterTts();

//   @override
  
//   void vibrate()
//   {
//      Vibration.vibrate(pattern: [200, 100, 200, 100]);
//   }
//   var _formatedDate;
//   Future _speakleft() async{
//     await flutterTts.speak("messaging menu");
//   }
//   Widget build(BuildContext context) {return Scaffold(
//           body:new Container(
//         child: SwipeDetector( 
//           child: Container(
//             decoration: BoxDecoration(
//                 image: DecorationImage(
//                     image: AssetImage("assets/images/comingsoon.jpg"),
//                     fit: BoxFit.cover,
//             ),
//           ),
//           ),
//               // child: Image.asset('assets/images/Home.jpg'),
//               onSwipeUp: () {
//                 setState(() {
//                   // _swipeDirection = "Swipe Up";
//                 });
//               },
//               onSwipeDown: () {
//                 setState(() {
//                   // _swipeDirection = "Swipe Down";
//                 });
//               },
//               onSwipeLeft: () {
//                 vibrate();
//                 _speakleft();
//                 setState(() {
//                    Navigator.pop(context);
//                 });
//               },
//               onSwipeRight: () {
//                 setState(() {
//                   // _swipeDirection = "Swipe Right";
//                 });
//               },
//               swipeConfiguration: SwipeConfiguration(
//           verticalSwipeMinVelocity: 100.0,
//           verticalSwipeMinDisplacement: 50.0,
//           verticalSwipeMaxWidthThreshold:100.0,
//           horizontalSwipeMaxHeightThreshold: 50.0,
//           horizontalSwipeMinDisplacement:50.0,
//           horizontalSwipeMinVelocity: 200.0),
//             ),
//           ),
//     );
//   }
// }