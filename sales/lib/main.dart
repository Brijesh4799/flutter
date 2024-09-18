import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salescrm/Darts/Expense.dart';
import 'package:salescrm/Darts/addcall.dart';
import 'package:salescrm/Darts/call.dart';
import 'package:salescrm/Darts/dashboard.dart';
import 'package:salescrm/Darts/days.dart';
import 'package:salescrm/Darts/latlocation.dart';
import 'package:salescrm/Darts/login.dart';
import 'package:salescrm/Darts/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Darts/addnew.dart';
import 'Darts/meeting.dart';

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
      //  backgroundColor: Color(0xff263238),

      body: Padding(
        padding: EdgeInsets.all(0),
        child:   Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("image/splash.png"),
              fit: BoxFit.cover,
            ),
          ),

          /*child: Center(
              child: Container(
                child: Image.asset("image/travcrmlogo.png",height: 200, width: 200,), ),
            ),*/
        ),
      ),
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

    //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> DaysST()));

    // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Login()));
  }
}


class MyBottomNavigationBar extends  StatefulWidget {
  @override
  State createState() => new MainBottomNav();
}

class MainBottomNav extends State<MyBottomNavigationBar> {

  int _currentIndex=0;

  final List tabs=[DashBoardST(),CallST(),MeetingST(),TaskST()];


  @override
  Widget build(BuildContext context) {


    return Scaffold(


      body: tabs[_currentIndex],

      bottomNavigationBar: Container(
      //  padding: EdgeInsets.only(bottom: 0,left: 5,right: 5),
        decoration: BoxDecoration(
          /*image: DecorationImage(
            image: AssetImage("image/apparelhomebg.png"),
            fit: BoxFit.cover,
          ),*/
          color: Colors.black54
        ),
        child: Container(
        //  margin: EdgeInsets.only(bottom: 5),
          padding: EdgeInsets.only(bottom: 7,top: 7),
          decoration: BoxDecoration(
          //  borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight:Radius.circular(10),),
            gradient: LinearGradient(
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              colors: [
                Colors.black.withOpacity(0.5),
                Colors.black.withOpacity(0.5),
              ],
              //  stops: [0.0,1.0]
            ),
            /*image: DecorationImage(
              image: AssetImage("image/homebgnav.png"),
              fit: BoxFit.cover,
            ),*/
          ),
          child: BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.lightBlue,
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,

            items: [
              BottomNavigationBarItem(

                icon: Image.asset("image/homenavbw.png",height: 22, width: 22,),
                activeIcon: Image.asset("image/homenavcolor.png",height: 22, width: 22,),
                label: "DashBoard",

                //  backgroundColor: Colors.transparent,
              ),

              BottomNavigationBarItem(
                label: "Call",
                icon: Image.asset("image/callnavbw.png",height: 22, width: 22,),
                activeIcon: Image.asset("image/callnavcolor.png",height: 22, width: 22,),
                //  backgroundColor: Colors.blue,
              ),

              BottomNavigationBarItem(
                icon: Image.asset("image/meetingnavbw.png",height: 22, width: 22,),
                activeIcon: Image.asset("image/meetingnavcolor.png",height: 22, width: 22,),
                label: "Meeting",
                //  backgroundColor: Colors.white,
              ),

              BottomNavigationBarItem(
                icon: Image.asset("image/tasknavbw.png",height: 22, width: 22,),
                activeIcon: Image.asset("image/tasknavcolor.png",height: 22, width: 22,),
                label: "Task",
                // backgroundColor: Colors.blue
              )
            ],

            onTap: (index){
              setState(() {
                _currentIndex=index;
              });
            },

          ),
        ),
      ),
    );


  }
}


class MyCallBottomNavigationBar extends  StatefulWidget {
  @override
  State createState() => new MainCallBottomNav();
}

class MainCallBottomNav extends State<MyCallBottomNavigationBar> {

  int _currentIndex=1;

  final List tabs=[DashBoardST(),CallST(),MeetingST(),TaskST()];


  @override
  Widget build(BuildContext context) {


    return Scaffold(


      body: tabs[_currentIndex],

      bottomNavigationBar: Container(
        //  padding: EdgeInsets.only(bottom: 0,left: 5,right: 5),
        decoration: BoxDecoration(
          /*image: DecorationImage(
            image: AssetImage("image/apparelhomebg.png"),
            fit: BoxFit.cover,
          ),*/
            color: Colors.black54
        ),
        child: Container(
          //  margin: EdgeInsets.only(bottom: 5),
          padding: EdgeInsets.only(bottom: 7,top: 7),
          decoration: BoxDecoration(
            //  borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight:Radius.circular(10),),
            gradient: LinearGradient(
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              colors: [
                Colors.black.withOpacity(0.5),
                Colors.black.withOpacity(0.5),
              ],
              //  stops: [0.0,1.0]
            ),
            /*image: DecorationImage(
              image: AssetImage("image/homebgnav.png"),
              fit: BoxFit.cover,
            ),*/
          ),
          child: BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.lightBlue,
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,

            items: [
              BottomNavigationBarItem(

                icon: Image.asset("image/homenavbw.png",height: 22, width: 22,),
                activeIcon: Image.asset("image/homenavcolor.png",height: 22, width: 22,),
                label: "DashBoard",

                //  backgroundColor: Colors.transparent,
              ),

              BottomNavigationBarItem(
                label: "Call",
                icon: Image.asset("image/callnavbw.png",height: 22, width: 22,),
                activeIcon: Image.asset("image/callnavcolor.png",height: 22, width: 22,),
                //  backgroundColor: Colors.blue,
              ),

              BottomNavigationBarItem(
                icon: Image.asset("image/meetingnavbw.png",height: 22, width: 22,),
                activeIcon: Image.asset("image/meetingnavcolor.png",height: 22, width: 22,),
                label: "Meeting",
                //  backgroundColor: Colors.white,
              ),

              BottomNavigationBarItem(
                icon: Image.asset("image/tasknavbw.png",height: 22, width: 22,),
                activeIcon: Image.asset("image/tasknavcolor.png",height: 22, width: 22,),
                label: "Task",
                // backgroundColor: Colors.blue
              )
            ],

            onTap: (index){
              setState(() {
                _currentIndex=index;
              });
            },

          ),
        ),
      ),
    );


  }
}

class MyMeetBottomNavigationBar extends  StatefulWidget {
  @override
  State createState() => new MainMeetBottomNav();
}

class MainMeetBottomNav extends State<MyMeetBottomNavigationBar> {

  int _currentIndex=2;

  final List tabs=[DashBoardST(),CallST(),MeetingST(),TaskST()];


  @override
  Widget build(BuildContext context) {


    return Scaffold(


      body: tabs[_currentIndex],

      bottomNavigationBar: Container(
        //  padding: EdgeInsets.only(bottom: 0,left: 5,right: 5),
        decoration: BoxDecoration(
          /*image: DecorationImage(
            image: AssetImage("image/apparelhomebg.png"),
            fit: BoxFit.cover,
          ),*/
            color: Colors.black54
        ),
        child: Container(
          //  margin: EdgeInsets.only(bottom: 5),
          padding: EdgeInsets.only(bottom: 7,top: 7),
          decoration: BoxDecoration(
            //  borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight:Radius.circular(10),),
            gradient: LinearGradient(
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              colors: [
                Colors.black.withOpacity(0.5),
                Colors.black.withOpacity(0.5),
              ],
              //  stops: [0.0,1.0]
            ),
            /*image: DecorationImage(
              image: AssetImage("image/homebgnav.png"),
              fit: BoxFit.cover,
            ),*/
          ),
          child: BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.lightBlue,
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,

            items: [
              BottomNavigationBarItem(

                icon: Image.asset("image/homenavbw.png",height: 22, width: 22,),
                activeIcon: Image.asset("image/homenavcolor.png",height: 22, width: 22,),
                label: "DashBoard",

                //  backgroundColor: Colors.transparent,
              ),

              BottomNavigationBarItem(
                label: "Call",
                icon: Image.asset("image/callnavbw.png",height: 22, width: 22,),
                activeIcon: Image.asset("image/callnavcolor.png",height: 22, width: 22,),
                //  backgroundColor: Colors.blue,
              ),

              BottomNavigationBarItem(
                icon: Image.asset("image/meetingnavbw.png",height: 22, width: 22,),
                activeIcon: Image.asset("image/meetingnavcolor.png",height: 22, width: 22,),
                label: "Meeting",
                //  backgroundColor: Colors.white,
              ),

              BottomNavigationBarItem(
                icon: Image.asset("image/tasknavbw.png",height: 22, width: 22,),
                activeIcon: Image.asset("image/tasknavcolor.png",height: 22, width: 22,),
                label: "Task",
                // backgroundColor: Colors.blue
              )
            ],

            onTap: (index){
              setState(() {
                _currentIndex=index;
              });
            },

          ),
        ),
      ),
    );


  }
}

class MyTaskBottomNavigationBar extends  StatefulWidget {
  @override
  State createState() => new MainTaskBottomNav();
}

class MainTaskBottomNav extends State<MyTaskBottomNavigationBar> {

  int _currentIndex=3;

  final List tabs=[DashBoardST(),CallST(),MeetingST(),TaskST()];


  @override
  Widget build(BuildContext context) {


    return Scaffold(


      body: tabs[_currentIndex],

      bottomNavigationBar: Container(
        //  padding: EdgeInsets.only(bottom: 0,left: 5,right: 5),
        decoration: BoxDecoration(
          /*image: DecorationImage(
            image: AssetImage("image/apparelhomebg.png"),
            fit: BoxFit.cover,
          ),*/
            color: Colors.black54
        ),
        child: Container(
          //  margin: EdgeInsets.only(bottom: 5),
          padding: EdgeInsets.only(bottom: 7,top: 7),
          decoration: BoxDecoration(
            //  borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10),bottomRight:Radius.circular(10),),
            gradient: LinearGradient(
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              colors: [
                Colors.black.withOpacity(0.5),
                Colors.black.withOpacity(0.5),
              ],
              //  stops: [0.0,1.0]
            ),
            /*image: DecorationImage(
              image: AssetImage("image/homebgnav.png"),
              fit: BoxFit.cover,
            ),*/
          ),
          child: BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.lightBlue,
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,

            items: [
              BottomNavigationBarItem(

                icon: Image.asset("image/homenavbw.png",height: 22, width: 22,),
                activeIcon: Image.asset("image/homenavcolor.png",height: 22, width: 22,),
                label: "DashBoard",

                //  backgroundColor: Colors.transparent,
              ),

              BottomNavigationBarItem(
                label: "Call",
                icon: Image.asset("image/callnavbw.png",height: 22, width: 22,),
                activeIcon: Image.asset("image/callnavcolor.png",height: 22, width: 22,),
                //  backgroundColor: Colors.blue,
              ),

              BottomNavigationBarItem(
                icon: Image.asset("image/meetingnavbw.png",height: 22, width: 22,),
                activeIcon: Image.asset("image/meetingnavcolor.png",height: 22, width: 22,),
                label: "Meeting",
                //  backgroundColor: Colors.white,
              ),

              BottomNavigationBarItem(
                icon: Image.asset("image/tasknavbw.png",height: 22, width: 22,),
                activeIcon: Image.asset("image/tasknavcolor.png",height: 22, width: 22,),
                label: "Task",
                // backgroundColor: Colors.blue
              )
            ],

            onTap: (index){
              setState(() {
                _currentIndex=index;
              });
            },

          ),
        ),
      ),
    );


  }
}
