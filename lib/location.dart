import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:vibration/vibration.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:sms_maintained/sms.dart';
import 'dart:async';
class location extends StatefulWidget {
  @override
  _locationState createState() => _locationState();
}
class _locationState extends State<location> {
  FlutterTts flutterTts=FlutterTts();
  Map<String,double> currentLocation=new Map();
  StreamSubscription<Map<String,double>> locationSubscription;
  Location location=new Location();
  var addresses;
  var first;
  String finalAdd;
  String hno;
  String area;
  String city;
  String state1;
  void initState(){
    super.initState();
    currentLocation['latitude'] = 0.0;
    currentLocation['longitude'] = 0.0;
    
    initPlatformState();
    locationSubscription=location.onLocationChanged().listen((Map<String,double>result){
      setState(() async{
        currentLocation=result;
        addresses = await Geocoder.local.findAddressesFromCoordinates(new Coordinates(currentLocation["latitude"], currentLocation["longitude"]));
        first=addresses.first;
        finalAdd=first.addressLine;
        hno=first.featureName;
        area=first.subLocality;
        city=first.subAdminArea;
        state1=first.adminArea;
        print("------------ $hno $area $city $state1");
        print(first.addressLine);

      });
    }); 
      }
  
      void sendsms(){
     SmsSender sender = new SmsSender();
  List<String> x = ["9654014558","9654058740"];
  String address;
  for(var i in x){
    address=i;
  sender.sendSms(new SmsMessage(address, 'I NEED HELP\nI am here:\nHouse No.- $hno\nArea- $area\nCity- $city\nState- $state1 '));
  sender.sendSms(new SmsMessage(address, 'Please track me- https://www.google.com/maps/place/${currentLocation['latitude']},${currentLocation['longitude']}'));
  
  }}
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
    await flutterTts.speak("emergency location sent");
  }
  Future _speakUp() async{
    await flutterTts.speak("you are at, $hno, $area, $city, $state1, India");
  }
  Widget build(BuildContext context) {return Scaffold(
          body:new Container(
        child: SwipeDetector( 
          child: Container(
            alignment: Alignment.topCenter,
            child: new Text('\n\nYou are at\n$hno, $area,\n$city, $state1,\nIndia',style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),textAlign: TextAlign.center,
            ),
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
                  _speakUp();
                  vibrate();
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
                sendsms();
                _speakright();
                setState(() {
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>location()));
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