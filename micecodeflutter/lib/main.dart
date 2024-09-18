import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micetravel/Dart/itinerarylat.dart';
import 'package:micetravel/localString.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Dart/document.dart';
import 'Dart/home.dart';
import 'Dart/itinerary.dart';
import 'Dart/login.dart';
import 'Dart/weather.dart';
import 'package:get/get.dart';


void main() {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xff37474f),
    //  statusBarIconBrightness: Brightness.dark,
  ));

  runApp(MyApp());

  /*runApp(DevicePreview(
      builder: (BuildContext context)  => MyApp(),
      enabled: !kReleaseMode,
    ));*/
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      /* theme: ThemeData(
        primaryColor: Color(0xff00B0FF),
      ),
      home: Home(),*/

      home: Splash(),
    );
  }
}



class Splash extends  StatefulWidget {
  @override
  State createState() => new MySplash();
}

class MySplash extends State<Splash> {

  late SharedPreferences preflog_in_out;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // backgroundColor: Color(0xff263238),

        body:Padding(
            padding: EdgeInsets.all(0),
            child:   Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("image/splashmice.jpg"),
                  fit: BoxFit.cover,
                ),
              ),

              /*child: Center(
              child: Container(
                child: Image.asset("image/travcrmlogo.png",height: 200, width: 200,), ),
            ),*/
            )
        )
    );
  }

  Future<Timer> loadData() async{
    return new Timer(Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() async{
    preflog_in_out = await SharedPreferences.getInstance();

    bool? alreadylogin= preflog_in_out.getBool("ID");

    if (alreadylogin==true) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> MyBottomNavigationBar()));
      print("Dash Board is done");

    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Login()));
      print("Login is done");
    }

    //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Login()));
  }
}



class MyBottomNavigationBar extends  StatefulWidget {
  @override
  State createState() => new MainBottomNav();
}

class MainBottomNav extends State<MyBottomNavigationBar> {

  int _currentIndex=0;

  final List tabs=[Home(),ItineraryLat(),Document(),Weather()];

  @override
  Widget build(BuildContext context) {

    return Scaffold(


      body: tabs[_currentIndex],

      bottomNavigationBar: Container(
        //  color: Color(0xfff5f5f5),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,

          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,


          items: [
            BottomNavigationBarItem(
              icon: Image.asset("image/homegraymenumice.png",height: 25, width: 25,),
              activeIcon:new Image.asset('image/homecolormenumice.png',height: 25, width: 25,),
              label: "Home",

              //   backgroundColor: Colors.transparent,
            ),

            BottomNavigationBarItem(
              icon: Image.asset("image/itigraymenumice.png",height: 25, width: 25,),
              activeIcon:new Image.asset('image/iticolormenumice.png',height: 25, width: 25,),
              label: "Itinerary",
              //  backgroundColor: Colors.blue,
            ),

            BottomNavigationBarItem(
              icon: Image.asset("image/docgraymenumice.png",height: 25, width: 25,),
              activeIcon:new Image.asset('image/doccolormenumice.png',height: 25, width: 25,),
              label: "Document",
              //  backgroundColor: Colors.blue,
            ),

            BottomNavigationBarItem(
              icon: Image.asset("image/weathergraymenumice.png",height: 25, width: 25,),
              activeIcon:new Image.asset('image/weathercolormenumice.png',height: 25, width: 25,),
              label: "Weather",
              // backgroundColor: Colors.blue
            ),
          ],

          onTap: (index){
            setState(() {
              _currentIndex=index;
            });
          },

        ),
      ),
    );


  }
}
