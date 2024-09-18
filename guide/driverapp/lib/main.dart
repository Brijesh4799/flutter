import 'dart:async';
import 'dart:convert';

import 'package:driverapp/Dart/BottomNavHome.dart';
import 'package:driverapp/Dart/alert.dart';
import 'package:driverapp/Dart/completeduties.dart';
import 'package:driverapp/Dart/googlemap.dart';
import 'package:driverapp/Dart/home.dart';
import 'package:driverapp/Dart/mylist.dart';
import 'package:driverapp/Dart/otp.dart';
import 'package:driverapp/Dart/pendingduties.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'Apis/apis.dart';
import 'Dart/currentlocation.dart';
import 'Dart/login.dart';
import 'Dart/profile.dart';
import 'Models/NotificationModel.dart';

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
              image: AssetImage("image/splashbg.png"),
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
    return new Timer(Duration(seconds: 1), onDoneLoading);
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

   //    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> MyBottomNavigationBar()));
  }
}

class NotificationIf{

  void onNotificationClick(){
    print("is called");
  }
}

/*class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}*/

/*class _MainPageState extends State<MainPage> {
  Color mainColor = const Color(0xFF2631C1);
  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: PersistentTabView(
        context,
        controller: _controller,
        screens:  [Home(), MyList(), PendingDuties(), CompleteDuties(), Alert()],
        items: _navBarsItems(),
        navBarStyle: NavBarStyle.style1,
        // navBarStyle: NavBarStyle.style9,
        // navBarStyle: NavBarStyle.style7,
        // navBarStyle: NavBarStyle.style10,
        // navBarStyle: NavBarStyle.style12,
        // navBarStyle: NavBarStyle.style13,
        // navBarStyle: NavBarStyle.style3,
        // navBarStyle: NavBarStyle.style6,

      ),
    );
  }

  *//*List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.search),
        title: ("Search"),
        activeColorPrimary: mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.chat_bubble),
        title: ("Chat"),
        activeColorPrimary: mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.bell),
        title: ("Notification"),
        activeColorPrimary: mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        title: ("Profile"),
        activeColorPrimary: mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }*//*
}*/


