import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:micetravel/Dart/tmitinerary.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Dart/home.dart';
import 'Dart/login.dart';
import 'Dart/utilities.dart';
import 'Dart/weather.dart';


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
              /*decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("image/splashfunbg.png"),
                  fit: BoxFit.cover,
                ),
              ),*/

              /*child: Center(
              child: Container(
                child: Image.asset("image/travcrmlogo.png",height: 200, width: 200,), ),
            ),*/
            )
        )
    );
  }

  Future<Timer> loadData() async{
    return new Timer(Duration(milliseconds: 1), onDoneLoading);
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

  final List tabs=[Home(),TMItinerary(),Utilies(),Weather()];

  @override
  Widget build(BuildContext context) {

    return Scaffold(


      body: tabs[_currentIndex],

      bottomNavigationBar: Stack(
        children: [

          Container(

            padding: EdgeInsets.only(bottom: 0),
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
                  label: "Travel Utilities",
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

          Container(
            // color: Color(0x62ffffff),
            child: Padding(
              padding: EdgeInsets.only(top: 60),
              child: Row(
                children: [

                  Expanded(
                    //   flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 110,top: 5),
                      child:Text("Powered by",maxLines: 1,
                          style: TextStyle(color: Colors.black,fontSize:11,
                              fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),),),

                  Expanded(
                    //  flex: 1,
                      child: Container(
                        margin: EdgeInsets.only( right: 110),
                        child:  Image.asset("image/deboxicon.png",height: 30, width: 35,),
                      ))
                ],
              ),
            ),

          ),
        ],

      ),
    );


  }
}
