import 'dart:async';
import 'dart:convert';


import 'package:driverapp/Dart/BottomNavHome.dart';
import 'package:driverapp/Dart/alertdetail.dart';
import 'package:driverapp/Dart/profile.dart';
import 'package:driverapp/Models/ToggleModel.dart';
import 'package:driverapp/Models/ToggleNotifyModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Apis/apis.dart';
import '../Models/AlertModel.dart';
import '../Models/NotificationModel.dart';
import '../Models/ProfileModel.dart';
import '../Providers/pickeralert.dart';
import 'BottomNavAlert.dart';
import 'BottomNavComplete.dart';
import 'BottomNavList.dart';
import 'BottomNavPending.dart';
import 'login.dart';
import 'package:http/http.dart' as http;



class AlertSL extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Alert(),
    );
  }

}

class Alert extends StatefulWidget {

  @override
  State createState() => MyAlert();
}

class MyAlert extends State<Alert> {

  MainBottomNav mainBottomNav = new MainBottomNav();

  bool loadCircle = false;

  late SharedPreferences prefsotp, prefmobno, prefroleid, preflog_in_out,prefuserid,preffullname,prefstatus,prefrolename,prefid,prefnotification,
      prefstatusvar;

  GlobalKey<ScaffoldState> _drawerkey= GlobalKey<ScaffoldState>();

  Color selecttogglecolor= Colors.lightGreen;
  bool statusclock = false;
  String clock="Off Duty";
  String clocktime="";
  bool isSwitched = false;
  bool isClockfont=true;
  bool isClockedfont=false;
  String statusvar="";
  String duty="";
  List<ResultsToggleNotify>? togglenotifymodel;

  String currenttime = DateFormat("hh:mm a").format(DateTime.now());
  String hour="";

  List<AlertDetailsAlert>? alertdmodel;
  List<NotificationsList>? notificatiomodel;


  String? UserId="1";
  String? roleId="0";
  String? fullname="1";
  String? status="1";
  String? rolenamefirst="";
  String? rolenamesecond="";
  String? id="1";
  String? notifcation="0";

  bool isBlue=true;
  bool isWhite=false;

  bool isShow=false;
  bool isNotShow=true;

  var onPendingClick= new MainBottomNav();

  bool isSelectpos=false;

  getColor(){
    setState(() {
      PickerAlert.colorList=Color(0xff80deea);
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
    getToogleNotify();
    getColor();
  }


  Future getPref() async {
    prefroleid = await SharedPreferences.getInstance();
    prefid = await SharedPreferences.getInstance();
    prefuserid = await SharedPreferences.getInstance();
    prefmobno = await SharedPreferences.getInstance();
    prefsotp = await SharedPreferences.getInstance();
    preffullname = await SharedPreferences.getInstance();
    prefstatus = await SharedPreferences.getInstance();
    prefrolename = await SharedPreferences.getInstance();
    preflog_in_out = await SharedPreferences.getInstance();
    prefnotification = await SharedPreferences.getInstance();
    prefstatusvar = await SharedPreferences.getInstance();

    setState(() {

      notifcation = prefnotification.getString("count");
      print("my Recieved  Count is : $notifcation");

      UserId = prefuserid.getString("userid")!;
      print("my Recieved OTP is : $UserId");

      roleId = prefroleid.getString("roleid")!;
      print("my Recieved Role Id in Home is : $roleId");

      fullname = preffullname.getString("fullname");
      print("my Recieved  Full Name is : $fullname");

      status = prefstatus.getString("status");
      print("my Recieved  Status is : $status");

      statusvar = prefstatusvar.getString("statusvar")!;
      print("sharedpreference status var from home is : "+statusvar);

      //rolename = prefrolename.getString("rolename");
      // print("my Recieved  rolename is : $rolename");

      if(fullname==null){
        fullname="User Name";
      }

      if(statusvar=="true") {
        statusvar="true";
        statusclock=true;
        isClockedfont=true;
        isClockfont=false;
        clock="On Duty";
        //  getToogle();
        print("switch on from main method");
      }
      else {
        statusvar="false";
        statusclock=false;
        isClockedfont=false;
        isClockfont=true;
        clock="Off Duty";
        //  getToogle();
        print("switch off from main method");

      }

      getChangedName();

    });
  }

  getChangedName(){

    if(roleId=="1"){
      rolenamefirst="TOUR";
      rolenamesecond="MANAGER";
      print("Get name change is 1 : $roleId");

    }
    else if(roleId=="2") {
      rolenamefirst="DRIVER";
      rolenamesecond="ASSISTANT";
      print("Get name change is 2 : $roleId");
    } else {
      rolenamefirst = "GUIDE";
      rolenamesecond = "ASSISTANT";
      print("Get name change is 3 : $roleId");
    }

    setState(() {

    });
  }

  createDialog(BuildContext context){
    return showDialog(
        context: context,
        builder: (context){
          return  AlertDialog(

            content: Text('Are Your Sure You want to Logout?',style: TextStyle(color: Colors.black,fontSize: 14,
                fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),

            actions: [
              Container(
                margin: EdgeInsets.only(left: 50,right: 50),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        //  textColor: Colors.black,
                        onTap: () {
                          prefsotp.clear();
                          prefmobno.clear();
                          prefroleid.clear();
                          preflog_in_out.clear();
                          prefuserid.clear();
                          prefstatus.clear();

                          Navigator.of(context).pop();
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {return Login();}));
                          print("is pressed");
                        },
                        child: Container(
                          width: 60,
                          height:30,
                          child: Center(child: Text("Yes",style: TextStyle(color: Colors.white, fontSize: 14,
                              fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,)),
                          decoration: BoxDecoration(color: Colors.blue,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),

                      Spacer(),

                      InkWell(
                        //  textColor: Colors.black,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: 60,
                          height:30,
                          child: Center(child: Text("No",style: TextStyle(color: Colors.white, fontSize: 14,
                              fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,)),
                          decoration: BoxDecoration(color: Colors.blue,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ]),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        key: _drawerkey,

        drawer: Drawer(

          backgroundColor: Colors.white,

          child: ListView(
            children: [

              Container(
                height: 180,
                child: DrawerHeader(
                  decoration: BoxDecoration(

                    /* borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0),bottomRight: Radius.circular(15.0)
                          ,topLeft: Radius.circular(15.0),topRight: Radius.circular(15.0),),*/
                    image: DecorationImage(
                      image: AssetImage("image/topmenu.png"),
                      fit: BoxFit.cover,
                    ),

                    //  color: Colors.blue,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                            border: Border.all(
                                color: Colors.white,
                                width: 2.0
                            )
                        ),
                        margin: EdgeInsets.only(left: 15,top: 10),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child:Image.asset("image/profilemenulat.jpg",height: 80, width: 80,)),
                      ),

                      SizedBox(height: 2.5,),

                      Container(
                        margin: EdgeInsets.only(top:0,right: 0),


                        child: Row(
                          children: [

                            FutureBuilder(
                                future: getProfile(),
                                builder:(context, snapshot) {

                                  if(snapshot.hasData) {

                                    List<ProfileData> logindata= snapshot.data as List<ProfileData>;

                                    fullname= logindata[0].fullName;

                                    // print("Notification is : $notifcation");

                                    return   Container(
                                      margin: EdgeInsets.only(left: 12,top: 37.5),
                                      child: Text(fullname!,
                                        style: TextStyle(color: Colors.white,
                                            fontSize: 12,
                                            fontFamily: 'BebesNeue',
                                            fontWeight: FontWeight.w700),),
                                    );

                                  }

                                  return Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(top: 0),
                                    child: Text(""),
                                  );
                                }

                            ),

                            Spacer(),

                            Container(

                              child: Column(
                                children: [

                                  Visibility(
                                    visible: isClockfont,
                                    child: Container(
                                      margin: EdgeInsets.only( top: 30),
                                      child: Text(clock,
                                        style: TextStyle(color: Colors.white,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                                    ),
                                  ),

                                  Visibility(
                                    visible: isClockedfont,
                                    child: Container(
                                      margin: EdgeInsets.only( top: 30),
                                      child: Text(clock,
                                        style: TextStyle(color: Colors.white,fontSize: 12,),),
                                    ),
                                  ),
                                ],

                              ),
                            ),

                            Container(

                              child: Column(
                                children: [

                                  Container(
                                    margin: EdgeInsets.only( left: 10,top: 27.5),
                                    child: FlutterSwitch(
                                      width: 60.0,
                                      height: 25,
                                      valueFontSize: 12.0,
                                      toggleSize: 20.0,
                                      value: statusclock,
                                      borderRadius: 20.0,
                                      padding: 6.0,
                                      //  showOnOff: true,
                                      inactiveColor: Colors.white,
                                      activeColor: Colors.green,
                                      inactiveToggleColor: Colors.green,
                                      activeToggleColor: Colors.white,
                                      onToggle: (val) {

                                        setState(() {
                                          statusclock=val;


                                          if(statusclock==true) {
                                            setState(() {

                                              loadCircle=true;

                                              statusvar="true";
                                              //  statusclock=true;
                                              isClockedfont=true;
                                              isClockfont=false;
                                              // statusclock = val;
                                              clock="On Duty";
                                              print("is click");
                                              getToogle();
                                              print('Switch Button is ON');

                                              Future.delayed(Duration(seconds: 2),(){
                                                setState(() {
                                                  loadCircle=false;
                                                });
                                              });

                                            });
                                          }
                                          else {
                                            setState(() {
                                              loadCircle=true;
                                              statusvar="false";
                                              //   statusclock=false;
                                              isClockedfont=false;
                                              isClockfont=true;
                                              //  statusclock = val;
                                              clock="Off Duty";
                                              print("is click");
                                              getToogle();
                                              print('Switch Button is OFF');
                                              Future.delayed(Duration(seconds: 2),(){
                                                setState(() {
                                                  loadCircle=false;
                                                });
                                              });
                                            });
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ],

                              ),
                            ),

                          ],
                        ),
                      )
                    ],
                  ),

                ),
              ),

              /* DrawerHeader(
                    decoration: BoxDecoration(
                         color: Color(0xffb2dfdb),
                      image: DecorationImage(
                        image: AssetImage("image/menubg.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [

                        Container(
                          //   margin: EdgeInsets.only(left: 55),
                          child: Image.asset("image/driver_ass_user_icon.png", width: 60, height: 60,),
                        ),

                        SizedBox(height: 10,),

                        FutureBuilder(
                            future: getProfile(),
                            builder:(context, snapshot) {

                              if(snapshot.hasData) {

                                List<ProfileData> logindata= snapshot.data as List<ProfileData>;

                                fullname= logindata[0].fullName;

                                // print("Notification is : $notifcation");

                                return   Container(
                                  child: Center(
                                    child: Text(fullname!,
                                      style: TextStyle(color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'BebesNeue',
                                          fontWeight: FontWeight.w700),),
                                  ),
                                );

                              }

                              return Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(top: 20),
                                child: Text(""),
                              );
                            }

                        ),



                      ],),

                  ),*/

              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height,

                child: Column(
                  children: [

                    InkWell(
                      onTap:  (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Profile()));
                        print("is pressed");
                      },

                      child: Container(
                        margin: EdgeInsets.only(top: 25),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Image.asset("image/profilemenu.png",height: 22, width: 22,),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 25),
                              child : Text("Profile",
                                  style: TextStyle(color: Colors.black,fontSize: 13,
                                      fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                            )
                          ],
                        ),
                      ),
                    ),

                    InkWell(
                      onTap:  (){
                        //    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home()));
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {return MyBottomNavigationBar();}));
                        print("is pressed");
                      },

                      child: Container(
                        margin: EdgeInsets.only(top: 25),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Image.asset("image/homemenu.png",height: 22, width: 22,),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 25),
                              child : Text("Home",
                                  style: TextStyle(color: Colors.black,fontSize: 13,
                                      fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                            )
                          ],
                        ),
                      ),
                    ),

                    InkWell(
                      onTap:  (){
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyList()));
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {return BottomNavList();}));
                        print("is pressed");
                      },

                      child: Container(
                        margin: EdgeInsets.only(top: 25),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Image.asset("image/documentmenu.png",height: 22, width: 22,),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 25),
                              child : Text("My List",
                                  style: TextStyle(color: Colors.black,fontSize: 13,
                                      fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                            )
                          ],
                        ),
                      ),
                    ),

                    InkWell(
                      onTap:  (){
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PendingDuties()));
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {return BottomNavPending();}));
                        print("is pressed");
                      },

                      child: Container(
                        margin: EdgeInsets.only(top: 25),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Image.asset("image/pendingnew.png",height: 22, width: 22,),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 25),
                              child : Text("Pending Duties",
                                  style: TextStyle(color: Colors.black,fontSize: 13,
                                      fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                            )
                          ],
                        ),
                      ),
                    ),

                    InkWell(
                      onTap:  (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {return BottomNavComplete();}));
                        //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CompleteDuties()));
                        print("is pressed");
                      },

                      child: Container(
                        margin: EdgeInsets.only(top: 25),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Image.asset("image/completenew.png",height: 22, width: 22,),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 25),
                              child : Text("Completed Duties",
                                  style: TextStyle(color: Colors.black,fontSize: 13,
                                      fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                            )
                          ],
                        ),
                      ),
                    ),

                    InkWell(
                      onTap:  (){
                        //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Alert()));
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {return BottomNavAlert();}));
                        print("is pressed");
                      },

                      child: Container(
                        margin: EdgeInsets.only(top: 25),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Image.asset("image/alertmenu.png",height: 22, width: 22,),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 25),
                              child : Text("Alerts",
                                  style: TextStyle(color: Colors.black,fontSize: 13,
                                      fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                            )
                          ],
                        ),
                      ),
                    ),

                    InkWell(
                      onTap:  (){
                        createDialog(context);
                        print("is pressed");
                      },

                      child: Container(
                        margin: EdgeInsets.only(top: 25),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Image.asset("image/logoutnew.png",height: 22, width: 27,),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child : Text("Logout",
                                  style: TextStyle(color: Colors.black,fontSize: 13,
                                      fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                            )
                          ],
                        ),
                      ),
                    ),

                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.only(top: 15,bottom: 15),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Container(
                            child:  Image.asset("image/pwdnew.png",height: 50, width: 100,),
                          )

                          /*Expanded(
                                //   flex: 1,
                                child: Container(
                                  margin: EdgeInsets.only(left: 95,top: 10),
                                  child:Text("Powered by",
                                      style: TextStyle(color: Colors.black,fontSize: 9,
                                          fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),),),

                              Expanded(
                                //  flex: 1,
                                  child: Container(
                                    margin: EdgeInsets.only( right: 75),
                                    child:  Image.asset("image/deboxicon.png",height: 30, width: 35,),
                                  ))*/
                        ],
                      ),

                    ),
                  ],
                ),
              )
            ],
          ),


        ),

        body: Stack(children: [

          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  InkWell(
                    onTap: (){
                      _drawerkey.currentState?.openDrawer();
                      print("drawer is pressed");
                    },
                    child: Container(
                      width: 25,
                      height: 22,
                      margin: EdgeInsets.only(top:25,left: 15),
                      child: Image.asset("image/roundednavigation.png",height: 22, width: 25,),
                    ),
                  ),

                  Spacer(),

                  Container(
                    margin: EdgeInsets.only(top:10,left: 10),
                    child: Image.asset("image/dalogolat.png",height: 50, width: 140,),
                  ),

                  Spacer(),

                  Container(
                    height: 40,
                    width: 27.5,
                    margin: EdgeInsets.only(top:10,right: 10),
                    child: Text(""),
                  ),

                ],

              ),
            ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 80),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Color(0xffb2ebf2),
                border: Border.all(
                  color: Color(0xffb2ebf2),
                  //                   <--- border color
                  width: 1.0,
                ),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
              ),
              child: Column(children: [

                Container(
                  child: Center(
                    child:Image.asset("image/alertrearicon.png", width: 180, height: 65,),
                  ),
                ),

                SizedBox(height: 12.5,),


                FutureBuilder(
                    future: getAlert(),
                    builder:(context, snapshot) {

                      if(snapshot.hasData) {
                        alertdmodel= snapshot.data as List<AlertDetailsAlert>;

                        return getBodyWidget();

                      }

                      else if(snapshot.hasError){
                        print(snapshot.error);
                      }

                      return Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 20),
                          child: CircularProgressIndicator(
                            value: 0.8,
                          )
                      );
                    }

                ),

              ]),
            ),
          )

        ]),


      ),
    );
  }

  Widget  getBodyWidget() {

    return Expanded(
      child: Stack(
        clipBehavior: Clip.none,
        children: [

        /*  FutureBuilder(
              future: getNotification(),
              builder:(context, snapshot) {

                if(snapshot.hasData) {

                  notificatiomodel= snapshot.data as List<NotificationsList>?;

                  notifcation= notificatiomodel![0].countorders;

                  if(notifcation==""){
                    isNotShow=true;
                    isShow=false;
                    print("is Not show ");
                  }else{
                    isNotShow=false;
                    isShow=true;
                    print("is show ");
                  }

                  print("Notification is : $notifcation");

                  return  Positioned(

                    top: -152,
                    right: 5,
                    child:Column(children: [
                      Visibility(
                        visible: isShow,
                        child: Container(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            width: 22.5,
                            height: 22.5,
                            padding: EdgeInsets.only(top: 2,bottom: 2,left: 2,right: 2),
                            decoration: BoxDecoration(
                              color: Colors.lightBlueAccent,
                              border: Border.all(
                                color: Colors.lightBlueAccent,
                                //                   <--- border color
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(notifcation.toString(),
                                  style: TextStyle(color: Colors.white,
                                      fontSize:10,
                                      fontFamily: 'BebesNeue',
                                      fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ),
                      ),

                      Visibility(
                        visible: isNotShow,
                        child: Container(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            width: 22.5,
                            height: 22.5,
                            padding: EdgeInsets.only(top: 2,bottom: 2,left: 2,right: 2),
                            child: Center(
                              child: Text("",
                                  style: TextStyle(color: Colors.white,
                                      fontSize:10,
                                      fontFamily: 'BebesNeue',
                                      fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ),
                      ),
                    ],
                    ),
                  );

                }

                return Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 20),
                  child: Text(""),
                );
              }

          ),*/

          ListView.builder(
              padding: EdgeInsets.only(top: 5,bottom:5),
              itemCount: alertdmodel!.length,
              itemBuilder: (context,pos){
                AlertDetailsAlert itemslists = alertdmodel![pos];

                String show =itemslists.show!;

                if(show=="0"){
                  isBlue=true;
                  isWhite=false;
                }else{
                  isBlue=false;
                  isWhite=true;
                }

                return Container(
                  child: Column(
                    children: [

                    Visibility(
                    visible: isBlue,
                    child: InkWell(
                      onTap: () async {

                        prefid = await SharedPreferences.getInstance();
                        prefid.setString("alertid", itemslists.id!);
                        print("send alert id :  ${itemslists.id}");

                       // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AlertDetail()));

                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AlertDetail()),).then((value) =>{ getUpdate()});

                        print("white is pressed");

                         print("Blue is pressed ");
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(bottom: 5,left: 10,right: 10),
                        decoration: BoxDecoration(
                          color:Color(0xff80deea),

                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 7.5,),

                            Container(
                              padding: EdgeInsets.only(top: 10,bottom: 10),
                              child: Row(
                                  children: [

                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child:  Text(itemslists.message!,
                                        style: TextStyle(color: Colors.black,fontSize: 14,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                                    ),

                                    Spacer(),

                                    Container(
                                      padding: EdgeInsets.only(top: 6.5,bottom: 6.5,left: 5,right: 5),
                                      margin: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        color: Color(0xffeceff1),
                                        border: Border.all(
                                          color: Colors.blue,
                                          //                   <--- border color
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child:  Text(itemslists.dutystatus!,
                                        style: TextStyle(color: Colors.blue,fontSize: 13,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                                    ),

                                  ]
                              ),
                            ),

                            SizedBox(height: 7.5,),
                          ],


                        ),
                      ),
                    ),
                   ),

                      Visibility(
                        visible: isWhite,
                        child: InkWell(
                          onTap: () async {

                            prefid = await SharedPreferences.getInstance();
                            prefid.setString("alertid", itemslists.id!);
                            print("send alert id :  ${itemslists.id}");
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AlertDetail()),).then((value) =>{ getUpdate()});

                             print("white is pressed");
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(bottom: 5,left: 10,right: 10),
                            decoration: BoxDecoration(color:Colors.white,

                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 7.5,),

                                Container(
                                  padding: EdgeInsets.only(top: 10,bottom: 10),
                                  child: Row(
                                      children: [

                                        Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child:  Text(itemslists.message!,
                                            style: TextStyle(color: Colors.black,fontSize: 14,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                                        ),

                                        Spacer(),

                                        Container(
                                          padding: EdgeInsets.only(top: 6.5,bottom: 6.5,left: 5,right: 5),
                                          margin: EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                            color: Color(0xffeceff1),
                                            border: Border.all(
                                              color: Colors.blue,
                                              //                   <--- border color
                                              width: 1.0,
                                            ),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child:  Text(itemslists.dutystatus!,
                                            style: TextStyle(color: Colors.blue,fontSize: 13,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                                        ),

                                      ]
                                  ),
                                ),

                                SizedBox(height: 7.5,),
                              ],


                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                );

                /*ChangeNotifierProvider<PickerAlert>(
                  create: (context)=>PickerAlert(),
                  child: Consumer<PickerAlert>(
                      builder: (context, provider, child){
                        return
                      }
                  ),
                );*/

              }
          ),
        ],


      ),
    );




  }

  void getUpdate(){
    setState(() {

    });
  }

  Future<List<AlertDetailsAlert>> getAlert() async {

    String newurl = AppNetworkConstants.ALERT+ "driverId="+ UserId! +"&roleId="+roleId!;

    print("Alert url is : " + newurl);

    var url = Uri.parse(newurl);


    http.Response res = await http.get(url);
    print("Alert response is : " + res.body);


    //  List datas= jsonDecode(res.body);

    var datas = jsonDecode(res.body)['alertDetails'] as List;

    mainBottomNav.getNotificationfromHome();

    List<AlertDetailsAlert> alertDetailData = datas.map((data) =>
        AlertDetailsAlert.fromJson(data)).toList();


    return alertDetailData;
  }

  /*Future<List<NotificationsList>> getNotification() async {


    String newurl = AppNetworkConstants.NOTIFICATION + "driverId=" +UserId!+ "&roleId=" + roleId!;

    print("Notification url is : "+newurl);

    var url = Uri.parse(newurl);


    http.Response res = await http.get(url);
    //  List datas= jsonDecode(res.body);

    var datas = jsonDecode(res.body)['notifications'] as List;

    List<NotificationsList> notificationData = datas.map((data) =>
        NotificationsList.fromJson(data)).toList();

    return notificationData;
  }*/

  completeDialog(BuildContext context){
    return showDialog(
        context: context,
        builder: (context){
          return  StatefulBuilder(
            builder: (context, setState) => AlertDialog(

              actions: [

                Column(children: [

                  SizedBox(height: 10,),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left: 5,right: 5,top: 15),
                    child: Center(
                      child: Text("Are Your Sure You Want to Complete ?",
                          // textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'BebesNeue',
                            fontWeight: FontWeight.w700,)),
                    ),
                  ),

                  SizedBox(height: 5,),

                  Row(
                    children: [

                      Expanded(
                        child: InkWell(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.lightGreen,
                              borderRadius: BorderRadius.circular(2.5),
                              //   border: Border.all(color: Colors.lightBlue,width: 1.0)
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text("Yes",
                                  style: TextStyle(color: Colors.white,
                                    fontSize: 13,
                                    fontFamily: 'BebesNeue',
                                    fontWeight: FontWeight.w700,)),
                            ),
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            margin: EdgeInsets.only(left: 30,top: 25, right: 20,bottom: 15),
                          ),
                        ),
                      ),

                      Expanded(
                        child: InkWell(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xffd32f2f),
                              borderRadius: BorderRadius.circular(2.5),
                              //   border: Border.all(color: Colors.lightBlue,width: 1.0)
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text("No",
                                  style: TextStyle(color: Colors.white,
                                    fontSize: 13,
                                    fontFamily: 'BebesNeue',
                                    fontWeight: FontWeight.w700,)),
                            ),
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            margin: EdgeInsets.only(left: 20,top: 25, right: 30,bottom: 15),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 5,),


                ],),

              ],
            ),
          );
        });
  }

  Future<List<ProfileData>> getProfile() async {

    String newurl = AppNetworkConstants.PROFILE + "driverId=" +UserId!+ "&roleId=" + roleId!;

    var url = Uri.parse(newurl);

    http.Response res = await http.get(url);
    //  List datas= jsonDecode(res.body);

    var datas = jsonDecode(res.body)['profileData'] as List;

    List<ProfileData> logindata = datas.map((data) =>
        ProfileData.fromJson(data)).toList();

    return logindata;
  }

  Future<List<ResultsToggleNotify>> getToogleNotify() async {


    String newurl =  AppNetworkConstants.TOGGLENOTIFICATION;

    var url = Uri.parse(newurl);

    print("Toggle Notify api is : "+newurl);

    http.Response res = await http.get(url);

    print("Toggle Notify api Response is : "+res.body);
    //  List datas= jsonDecode(res.body);

    var datas = jsonDecode(res.body)['results'] as List;

    List<ResultsToggleNotify> logindata = datas.map((data) =>
        ResultsToggleNotify.fromJson(data)).toList();
    statusvar=logindata[0].statusclock!;
  //  togglecounter=logindata[0].counter!;
    duty=logindata[0].duty!;
    print("status clock for parameter is : "+statusvar);
  //  print("toggle counter for parameter is : "+togglecounter);
    print("duty for parameter is : "+duty);

    getToogle();

    return logindata;
  }

  Future<List<ResultsToggle>> getToogle() async {


    String newurl = AppNetworkConstants.TOGGLE+"status="+statusvar;

    var url = Uri.parse(newurl);

    print("Toggle api is : "+newurl);

    http.Response res = await http.get(url);

    print("Toggle api Response is : "+res.body);

    var datas = jsonDecode(res.body)['results'] as List;

    List<ResultsToggle> logindata = datas.map((data) =>
        ResultsToggle.fromJson(data)).toList();

    statusclock=logindata[0].statusclock!;
    print("Status clock from toggle api is : ${statusclock}");

    //   loadCircle=false;

    //   print("status clock form main method is : ${statusclock}");

    return logindata;
  }

}
