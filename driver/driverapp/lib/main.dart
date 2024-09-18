import 'dart:async';

import 'package:driverapp/Dart/BottomNavHome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'Dart/login.dart';

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

      home: Splash()
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

      body:Stack(children: [
        Container(
         // color: Color(0x62ffffff),
          child: Padding(
            padding: EdgeInsets.only(bottom: 0),
            child: Align(
             // alignment: Alignment.bottomCenter,
              child:Container(
                child: Image.asset("image/splashlat.jpg", ),
              )

              /*Row(
                    children: [

                      Expanded(
                        //   flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: 105, top: 5),
                          child: Text("Powered by",
                              style: TextStyle(color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'BebesNeue',
                                  fontWeight: FontWeight.w700)),),),

                      Expanded(
                        //  flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(right: 105),
                            child: Image.asset(
                              "image/deboxicon.png", height: 35, width: 40,),
                          ))
                    ],
                  )*/,
            ),
          ),

        ),

        /*Padding(
                padding: EdgeInsets.all(0),
                child:   Container(
                  *//* decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("image/forwheeler.png"),
                    fit: BoxFit.cover,
                  ),
                ),*//*

                  child: Center(
                    child: Container(
                      child: Image.asset("image/splashlat.jpg",height: 200, width: 200,), ),
                  ),
                )
            )*/
      ],),

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
  //final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ClipRect(
        child: PersistentTabView(
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

      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
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
  } 
}*/





