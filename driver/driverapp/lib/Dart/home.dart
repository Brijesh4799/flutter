import 'dart:async';
import 'dart:convert';


import 'package:driverapp/Dart/BottomNavAlert.dart';
import 'package:driverapp/Dart/BottomNavComplete.dart';
import 'package:driverapp/Dart/BottomNavHome.dart';
import 'package:driverapp/Dart/BottomNavList.dart';
import 'package:driverapp/Dart/BottomNavPending.dart';
import 'package:driverapp/Dart/currentlocation.dart';
import 'package:driverapp/Models/AcceptedListModel.dart';
import 'package:driverapp/Models/AlertReminderModel.dart';
import 'package:driverapp/Models/ReminderBellModel.dart';
import 'package:driverapp/Models/ToggleModel.dart';
import 'package:driverapp/Models/ToggleNotifyModel.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:driverapp/Dart/profile.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pie_chart/pie_chart.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Apis/apis.dart';
import '../Models/AlertUpdateModel.dart';
import '../Models/DutyModel.dart';
import 'package:http/http.dart' as http;
import '../Models/NotificationModel.dart';
import '../Models/ProfileModel.dart';
import 'login.dart';
//import 'package:charts_flutter/flutter.dart' as charts;




class HomeSL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Home(),
    );
  }
}

class Home extends StatefulWidget {

  @override
  State createState() => MyHome();
}

class MyHome extends State<Home>{

 // NotificationIf notificationIf =new NotificationIf();

 // var onPendingClick= new MainBottomNav();

  MainBottomNav mainBottomNav = new MainBottomNav();

  bool loadCircle = false;

  late SharedPreferences prefsotp, prefmobno, prefroleid, preflog_in_out,prefuserid,prefstatus,prefrolename,prefnotification,prefstatusvar;

  Color selecttogglecolor= Colors.lightGreen;

  Timer? timer;
  String? UserId="12";
  String? roleId="2";
  String? fullname="1";
  String? status="1";
  String? rolenamefirst="1";
  String? rolenamesecond="1";

  String pendingDuties="0";
  String assignDuties="0";
  String completeDuties="0";

  String togglecounter="";
  String alertmessage="";
  String pickuptimebell="";
  String pickupdatebell="";
  String pickupaddressbell="";
  String guestnamebell="";
  String reminderbell="";
  String phonebell="";
  bool isReminder=true;
  bool isnotReminder=false;

  List<CircleList>? circlemodel;
  List<NotificationsList>? notificatiomodel;
  List<PendingAcceptedList>? pendingacceptedmodel;
  List<ResultsToggleNotify>? togglenotifymodel;
  List<ResultsToggle>? togglemodel;
  List<ResultAlertReminder>? alertremindermodel;
  List<ResultReminderBell>? reminderbellmodel;

  bool isCall=true;
  bool isCallNot=false;
  bool isActual= false;
  String destination="";

  String? notifcation="";
  bool isShow=false;
  bool isNotShow=true;
  String callassign="123456789";
  String callaccepted="123456789";
  String? pickupAddress="0";
  String? dropAddress="0";

  GlobalKey<ScaffoldState> _drawerkey= GlobalKey<ScaffoldState>();

  bool statusclock = false;
  String clock="Off Duty";
  String clocktime="";
  bool isSwitched = false;
  bool isClockfont=true;
  bool isClockedfont=false;
  String statusvar="";
  String duty="";
  String pickuptime="";
  String pickuptimefull="";
  String pickupdate="";
  String tranferquoteid="";

  String currenttime = DateFormat("hh:mm a").format(DateTime.now());
  String hour="";

   String fromtime= DateFormat('dd-MMM-yyyy').format(DateTime.now());




  DateTime fromselectedDate = DateTime.now();

  Map<String, double> dataMap = {
    "pending": 0,
    "assign": 0,
    "complete": 0,
  };

  List<Color> colorList = [Color(0xFF07407b),Color(0xFFfe9a21),Color(0xFF34acd8)];


  Future getPref() async {
    prefroleid = await SharedPreferences.getInstance();
    prefmobno = await SharedPreferences.getInstance();
    prefsotp = await SharedPreferences.getInstance();
    prefuserid = await SharedPreferences.getInstance();
    prefstatus = await SharedPreferences.getInstance();
    prefrolename = await SharedPreferences.getInstance();
    prefstatusvar = await SharedPreferences.getInstance();

    setState(() {
      UserId = prefuserid.getString("userid")!;
      print("my Recieved OTP is : $UserId");

      roleId = prefroleid.getString("roleid")!;
      print("my Recieved Role Id in Home is : $roleId");

      status = prefstatus.getString("status");
      print("my Recieved  Status is : $status");

      statusvar = prefstatusvar.getString("statusvar")!;
      print("sharedpreference status var from home is : "+statusvar);

      if(fullname==null){
        fullname="User Name";
      }

      getChangedName();

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

    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
    getToogleNotify();
    getMyLoginValue();
    getUpdate();

    timer = Timer.periodic(Duration(seconds: 1),(Timer t) {

      //   currenttime= DateFormat("hh:mm:ss a").format(DateTime.now());


      currenttime= DateFormat("hh:mm").format(DateTime.now().add(Duration(hours: 1)));

      if(pickuptime==currenttime && fromtime==pickupdate){
        getAlertReminder();
        timer!.cancel();
       print("dialog is opened");
      }else
      {
        print("My pickup time stamp is : " + pickuptime);
        print("My pickup Date stamp is : " + pickupdate);
        print("My tranferquoteid stamp is : " + tranferquoteid);
        print("current time is : " + currenttime);
        print("current date is : " + fromtime);
      }

    });
  }


  getMyLoginValue() async {
    preflog_in_out = await SharedPreferences.getInstance();
    preflog_in_out.setBool("ID",true);
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

    return ModalProgressHUD(
      progressIndicator: const CircularProgressIndicator(color: Color(0xff1a237e),strokeWidth: 5),
      inAsyncCall: loadCircle,
      child: SafeArea(
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
                              )

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

          body:Stack(
            clipBehavior: Clip.none,

            children: [

              Container(
                /* decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("image/homegblat.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),*/
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

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

                        InkWell(
                          onTap: (){
                            remainderDialog(context);
                          },
                          child: Container(
                            margin: EdgeInsets.only(top:10,right: 10),
                            child: Image.asset("image/bell.png",height: 40, width: 27.5,),
                          ),
                        ),


                      ],

                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                   //   crossAxisAlignment: CrossAxisAlignment.center,
                      children: [


                        FutureBuilder(
                            future: getProfile(),
                            builder:(context, snapshot) {

                              if(snapshot.hasData) {

                                List<ProfileData> logindata= snapshot.data as List<ProfileData>;

                                fullname= logindata[0].fullName;

                                // print("Notification is : $notifcation");

                                return  Container(
                                  width: 320,
                                  margin: EdgeInsets.only(left: 0),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10,left: 0),
                                    child: Text(fullname!, style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: 'BebesNeue',
                                        fontWeight: FontWeight.w700),overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                                  ),

                                );

                              }

                              return Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(top: 20,),
                                child: Text(""),
                              );
                            }

                        ),

                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [

                        FutureBuilder(
                            future: getToogleNotify(),
                            builder:(context, snapshot) {

                              if(snapshot.hasData) {

                                togglenotifymodel = snapshot.data;

                                duty= togglenotifymodel![0].duty.toString();

                                if(duty=="On duty"){
                                  selecttogglecolor=Colors.lightGreen;
                                }else{
                                  selecttogglecolor=Colors.red;
                                }



                                print("duty is "+duty);

                                return   Container(
                                  padding: EdgeInsets.only(top: 5, bottom: 5,left: 10,right: 10),
                                  decoration: BoxDecoration(
                                    color: selecttogglecolor,
                                    border: Border.all(
                                      color: selecttogglecolor,
                                      //                   <--- border color
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  margin: EdgeInsets.only(right:10),
                                  child: Center(
                                    child: Text(duty,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontFamily: 'BebesNeue',
                                            fontWeight: FontWeight.w700)),
                                  ),);

                              }

                              return Text("",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontFamily: 'BebesNeue',
                                      fontWeight: FontWeight.w700));
                            }

                        ),

                      ],
                    ),

                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight:Radius.circular(30),),
                      ),

                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 12.5,bottom: 12.5),
                      margin: EdgeInsets.only(top: 20,left: 15,right: 15),


                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children:[

                            InkWell(
                              onTap: (){
                                selectFromDate(context);
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 5,left: 0),
                                child: Text("Date : "+fromtime,
                                    style: TextStyle(color: Colors.white,fontSize: 13,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                              ),
                            ),




                          ]
                      ),



                    ),

                    FutureBuilder(
                        future: getDuty(),
                        builder:(context, snapshot) {

                          if(snapshot.hasData) {

                            circlemodel= snapshot.data;

                            pendingDuties= circlemodel![0].pendingDuty.toString();
                            assignDuties= circlemodel![0].totalasign.toString();
                            completeDuties= circlemodel![0].totalcompletedduty.toString();

                            /*  pendingDuties= "3";
                                  assignDuties= "5";
                                  completeDuties= "7";
*/

                            dataMap = {
                              "complete": double.parse(completeDuties),
                              "pending": double.parse(pendingDuties),
                              "assign": double.parse(assignDuties),
                            };

                            if(pendingDuties=="0" && assignDuties=="0" && completeDuties=="0"){
                              //  colorList =  [Colors.black26];
                              colorList = [Color(0xFF07407b),Color(0xFFfe9a21),Color(0xFF34acd8)];
                              print("Color list is grey");
                            }else{
                              //  colorList =  [Colors.deepOrange];
                              colorList = [Color(0xFF07407b),Color(0xFFfe9a21),Color(0xFF34acd8)];
                              print("Color list is orange");
                            }

                            // getColor();

                            print("Pending duties is "+pendingDuties.toString());

                            return  Container(
                              /* decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("image/homegblat.jpg"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),*/
                              child: Column(children: [

                                Container(
                                    margin: EdgeInsets.only(top:25,),
                                    child: Row(
                                      children: [

                                        InkWell(
                                          onTap:(){
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {return BottomNavPending();}));
                                            print("is pressed");
                                          },
                                          child: Row(
                                            children: [


                                              Container(
                                                margin: EdgeInsets.only(left: 20),
                                                child: Text("Pending",
                                                    style: TextStyle(color: Colors.black54,fontSize: 13,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                                              ),

                                              Container(
                                                margin: EdgeInsets.only(left: 0),
                                                child: Text("#",
                                                    style: TextStyle(color: Color(0xFFfe9a21),fontSize: 14,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                                              ),

                                              Container(
                                                margin: EdgeInsets.only(left: 0),
                                                child: Text(pendingDuties.toString(),
                                                    style: TextStyle(color: Colors.black,fontSize: 14,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                                              ),

                                            ],
                                          ),
                                        ),


                                        Spacer(),

                                        InkWell(
                                          onTap:(){
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {return BottomNavList();}));
                                            print("is pressed");
                                          },
                                          child: Row(
                                            children: [

                                              Container(
                                                margin: EdgeInsets.only(left: 20),
                                                child: Text("Total Assigned",
                                                    style: TextStyle(color: Colors.black54,fontSize: 13,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                                              ),

                                              Container(
                                                margin: EdgeInsets.only(left: 0),
                                                child: Text("#",
                                                    style: TextStyle(color: Color(0xFF34acd8),fontSize: 14,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                                              ),

                                              Container(
                                                margin: EdgeInsets.only(right: 15),
                                                child: Text(assignDuties.toString(),
                                                    style: TextStyle(color: Colors.black,fontSize: 14,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                                              ),


                                            ],
                                          ),
                                        ),

                                      ],
                                    )
                                ),

                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("image/line.png"),
                                      //  fit: BoxFit.cover,
                                    ),
                                  ),
                                  width: 270,
                                  height: 210,
                                  padding: EdgeInsets.only(top: 5, bottom:0,left: 10,right: 10),
                                  child: PieChart(
                                    dataMap: dataMap,
                                    animationDuration: Duration(milliseconds: 1400),
                                    chartLegendSpacing: 22,
                                    // chartRadius: MediaQuery.of(context).size.width / 3.2,
                                    chartRadius: 130,
                                    colorList: colorList,
                                    initialAngleInDegree: 0,
                                    chartType: ChartType.ring,
                                    ringStrokeWidth: 35,
                                    centerText: "Duty Circle",
                                    centerTextStyle: TextStyle(fontSize: 13, color: Colors.lightBlueAccent, fontWeight: FontWeight.bold,),
                                    legendOptions: LegendOptions(
                                      showLegendsInRow: false,
                                      legendPosition: LegendPosition.right,
                                      showLegends: false,
                                      //   legendShape: _BoxShape.circle,
                                      legendTextStyle: TextStyle(
                                        fontSize: 15,
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    chartValuesOptions: ChartValuesOptions(
                                      showChartValueBackground: true,
                                      showChartValues: false,
                                      showChartValuesInPercentage: false,
                                      showChartValuesOutside: false,
                                      decimalPlaces: 1,
                                    ),
                                    // gradientList: ---To add gradient colors---
                                    // emptyColorGradient: ---Empty Color gradient---
                                  ),
                                ),



                                InkWell(
                                  onTap:(){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {return BottomNavComplete();}));
                                    print("is pressed");
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(top: 0,),
                                      child: Row(
                                        children: [

                                          Container(
                                            margin: EdgeInsets.only(left: 20),
                                            child: Text("Completed",
                                                style: TextStyle(color: Colors.black54,fontSize: 13,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                                          ),

                                          Container(
                                            margin: EdgeInsets.only(left: 0),
                                            child: Text("#",
                                                style: TextStyle(color: Color(0xFF07407b),fontSize: 14,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                                          ),

                                          Container(
                                            margin: EdgeInsets.only(right: 15),
                                            child: Text(completeDuties.toString(),
                                                style: TextStyle(color: Colors.black,fontSize: 14,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                                          ),


                                          Spacer(),

                                          Container(
                                            margin: EdgeInsets.only(right: 20),
                                            child:Image.asset("image/dotslat.png",height: 22.5, width: 30,),
                                          ),

                                        ],
                                      )
                                  ),
                                ),





                              ],),
                            );

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

                    FutureBuilder(
                        future: getAccepted(),
                        builder:(context, snapshot) {

                          if(snapshot.hasData) {
                            pendingacceptedmodel= snapshot.data as List<PendingAcceptedList>;

                            if(pendingacceptedmodel!.length==0) {
                              Fluttertoast.showToast(
                                  msg: "No Pending Duty",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 12.0
                              );
                            }

                            return getBodyWidgetList();

                          }

                          else if(snapshot.hasError){
                            print(snapshot.error);
                          }

                          return Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 20),
                            child: Text(""),
                          );
                        }

                    ),


                  ],),
              ),

              /*FutureBuilder(
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

                        bottom: -25.5,
                        right: 5.5,
                        child: Column(children: [
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
                                    color:Colors.lightBlueAccent,
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
                                width: 25,
                                height: 25,
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
            ],

          ),

        ),
      ),
    );
  }

  getBodyWidgetList() {

    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            padding: EdgeInsets.only(top: 5,bottom: 5),
            itemCount: pendingacceptedmodel!.length,
            itemBuilder: (context,index){
              PendingAcceptedList itemslists = pendingacceptedmodel![index];

              tranferquoteid = pendingacceptedmodel![0].transferQuotId!;

              print("My transferquoteid is  : " +tranferquoteid);

              if (pendingacceptedmodel![0].pickupTime!.length > 0) {

                pickuptimefull=pendingacceptedmodel![0].pickupTime!;

                pickuptime = pendingacceptedmodel![0].pickupTime!.substring(0,pendingacceptedmodel![0].pickupTime!.length - 3);

                //print("My pickuptime before is  from list: " +pickuptimelat);

                print("My pickuptime is  from list: " +pickuptime);


              } else {
                print('Empty string of pickup time, please check.');
              }

              if (pendingacceptedmodel![0].pickupDate!.length > 0) {


                pickupdate = pendingacceptedmodel![0].pickupDate!;

                print("My pickupdate is  : " +pickupdate);


              } else {
                print('Empty string of pickup date, please check.');
              }

              if (itemslists.destination!.length > 0) {
                destination = itemslists.destination!.substring(
                    0, itemslists.destination!.length - 2);
              }else{
                destination="";
              }

              if(itemslists.guestphone.toString()==""){
                isCallNot=false;
              }else{
                isCall=true;
              }

              if(itemslists.actualPickupTime!=""){
                isActual=true;
                //  isActualNot=true;
              }else{
                isActual=false;
                //  isActualNot=false;
              }

              return  Container(
                margin: EdgeInsets.only(bottom: 5,left: 15,right: 15,top:15),
                padding: EdgeInsets.only(bottom: 10),

                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(10),
                  /* gradient: LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            colors: [
              Colors.blue.withOpacity(0.18),
              Colors.blue.withOpacity(0.18),
            ],
            //  stops: [0.0,1.0]
          )*/
                ),
               // height: 220,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Container(
                        margin: EdgeInsets.only(left: 10,top: 10),
                        child: Text("Next Service on "+itemslists.tourDate!,
                            style: TextStyle(color: Colors.black,fontSize: 14,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                      ),

                      SizedBox(height: 7.5,),

                      // pickup time

                      Row(
                          children: [

                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child:  Text("Pickup Date : ",
                                style: TextStyle(color: Colors.black,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 0),
                              child:  Text(itemslists.pickupDate!,
                                style: TextStyle(color: Colors.black,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                            ),

                            Spacer(),

                            Container(
                              margin: EdgeInsets.only(left: 0),
                              child:  Text("Pickup Time : ",
                                style: TextStyle(color: Colors.black,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                            ),

                            Container(
                              width:60,
                              margin: EdgeInsets.only(left:0,right: 5),
                              child:  Text(itemslists.pickupTime!,
                                style: TextStyle(color: Colors.black,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                            ),

                          ]
                      ),

                      SizedBox(height: 10,),

                      // pickup address
                      Row(
                          children: [

                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child:  Text("Pickup Address : ",
                                style: TextStyle(color: Colors.black,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                            ),


                            Container(
                              width: 150,
                              margin: EdgeInsets.only(left: 5),
                              child:  Text(itemslists.pickupAddress!,
                                maxLines: 1,
                                style: TextStyle(color: Colors.black,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,),
                            ),

                            Spacer(),

                            InkWell(
                              onTap: (){
                                pickupAddress=itemslists.pickupAddress!;
                                print("send Address is : $pickupAddress");

                                if(pickupAddress==""){
                                  Fluttertoast.showToast(
                                      msg:  "No Location Available Now",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 4,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 14.0
                                  );
                                }
                                else{
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CurrentLocation(newaddress: pickupAddress!)));
                                  print("is pressed");
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 7.5),
                                child:  Image.asset("image/location.png", width: 20, height: 20,),
                              ),
                            ),
                          ]
                      ),

                      SizedBox(height: 10,),

                      // dot line
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 3,
                        margin: EdgeInsets.only(left:10,right: 10),
                        child:  Image.asset("image/dotline.png",),
                      ),

                      // Actual pickuptime
                      Visibility(
                        visible: isActual,
                        child: Row(
                            children: [

                              Container(
                                margin: EdgeInsets.only(left: 7.5,top: 10),
                                child:  Text("Actual Pickup Time : ",
                                  style: TextStyle(color: Colors.black,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                              ),

                              Container(
                                margin: EdgeInsets.only(left: 5,top: 10),
                                child:  Text(itemslists.actualPickupTime!,
                                  style: TextStyle(color: Colors.black,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                              ),

                            ]
                        ),
                      ),

                      // dot line
                      Visibility(
                        visible: isActual,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 3,
                          margin: EdgeInsets.only(left:10,right: 10,top: 10),
                          child:  Image.asset("image/dotline.png",),
                        ),
                      ),

                      SizedBox(height: 10,),

                      // no of guest

                      Row(
                          children: [

                            Container(
                              margin: EdgeInsets.only(left: 10,top:7.5),
                              child:  Text("No. of Guest : ",
                                style: TextStyle(color: Colors.brown,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                            ),


                            Container(
                              padding: EdgeInsets.only(left: 5,right: 5,top: 2.5,bottom: 2.5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.lightGreen,width: 1),
                                borderRadius: BorderRadius.only(topLeft:Radius.circular(2.5),topRight:Radius.circular(2.5),
                                  bottomLeft:Radius.circular(2.5),bottomRight:Radius.circular(2.5),), ),
                              margin: EdgeInsets.only(left: 6,top: 7.5),
                              child:  Text(itemslists.guest!,
                                maxLines: 1,
                                style: TextStyle(color: Colors.lightGreen,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                            ),

                          ]
                      ),

                      // Guest name

                      Row(
                          children: [

                            Container(
                              margin: EdgeInsets.only(left: 10,top: 7.5),
                              child:  Text("Guest Name : ",
                                style: TextStyle(color: Colors.lightGreen,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                            ),


                            Container(
                              margin: EdgeInsets.only(left: 6,top: 7.5),
                              child:  Text(itemslists.guestname!,
                                maxLines: 1,
                                style: TextStyle(color: Colors.lightGreen,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                            ),

                          ]
                      ),


                      // mobile no

                      Row(
                          children: [

                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child:  Text("Mobile No : ",
                                style: TextStyle(color: Colors.lightGreen,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                            ),


                            Column(
                              children:[

                                Visibility(
                                  visible: isCall,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child:  Text("+91"+itemslists.guestphone!,
                                      maxLines: 1,
                                      style: TextStyle(color: Colors.lightGreen,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                                  ),
                                ),

                                Visibility(
                                  visible:isCallNot,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child:  Text("",
                                      maxLines: 1,
                                      style: TextStyle(color:Colors.lightGreen,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                                  ),
                                ),
                              ],

                            ),

                            Spacer(),

                            Visibility(
                              visible: isCall,
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      callaccepted="+91"+itemslists.guestphone.toString();
                                      print("Callaccepted is : $callaccepted");
                                      _makingPhoneCallAccepted();
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 20),
                                      child:  Image.asset("image/calllaticon.png", width: 27.5, height: 30,),
                                    ),
                                  ),

                                  InkWell(
                                    onTap:(){
                                      // whatsappnumber="+91-9910924485";
                                      callaccepted="+91"+itemslists.guestphone.toString();
                                      print("Callaccepted whats app is : $callaccepted");
                                      _makingWhatsappAccepted();
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 20),
                                      child: Image.asset(
                                        "image/whatslaticon.png", height: 25,
                                        width: 25,),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Visibility(
                                visible:isCallNot,
                                child: Text(""))



                          ]
                      ),

                     /* Container(
                        margin: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                        color: Colors.grey,
                      ),*/

                      SizedBox(height: 10,),

                      // dot line
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 3,
                        margin: EdgeInsets.only(left:10,right: 10),
                        child:  Image.asset("image/dotline.png",),
                      ),



                      SizedBox(height: 10,),

                      // tour id

                      Row(
                          children: [

                            Container(
                              margin: EdgeInsets.only(left: 10,top: 7.5),
                              child:  Text("Tour Id : ",
                                style: TextStyle(color: Colors.brown,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 15,top: 7.5),
                              child:  Text(itemslists.tourId!,
                                style: TextStyle(color: Colors.black,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                            ),

                          ]
                      ),

                      // Destination


                      Container(
                          margin: EdgeInsets.only(left: 12,top: 7.5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 2,left: 2),
                                child: Image.asset("image/roundtrip.png",height: 10, width: 10,),
                              ),

                              Container(
                                margin: EdgeInsets.only(left: 12,top: 0),
                                child:  Text(destination,
                                  maxLines: 1,
                                  style: TextStyle(color: Colors.black,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                                  overflow: TextOverflow.ellipsis,),
                              ),

                            ],)),



                     /* Container(
                          margin: EdgeInsets.only(left: 12,top: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 2,left: 2),
                                child: Image.asset("image/addicon.png",height: 35, width: 10,),
                              ),

                              Container(
                                margin: EdgeInsets.only(left: 5),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 5),
                                        child: Text(itemslists.pickupAddress!,
                                            style: TextStyle(color: Colors.black54,fontSize: 10,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                                      ),

                                      Container(
                                        margin: EdgeInsets.only(left: 5,top: 14),
                                        child: Text(itemslists.dropAddress!,
                                            style: TextStyle(color: Colors.black54,fontSize: 10,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                                      ),


                                    ]),
                              ),

                            ],)),*/



                    ]),
              );
            }
        ),
      ),
    );
      
     

  }

  selectFromDate(BuildContext context,) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: fromselectedDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2025));

    if (picked != null && picked != fromselectedDate) {
      setState(() {
        fromtime = DateFormat('dd-MMM-yyyy').format(picked);
        print("from time prickers : " +fromtime );

        getDuty();



      });
    }
  }

  Future<List<CircleList>> getDuty() async {

    String newurl = AppNetworkConstants.DUTYCIRCLE + "driverId=" +UserId!+ "&roleId=" + roleId!+"&startDate="+fromtime;

    print("Duty Circle : "+newurl);

    var url = Uri.parse(newurl);

    http.Response res = await http.get(url);

    print("Duty Circle response is: "+res.body);

    mainBottomNav.getNotificationfromHome();


   /* Fluttertoast.showToast(
        msg: "Updated Now",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0
    );*/

    var datas = jsonDecode(res.body)['CircleList'] as List;

    List<CircleList> circledata = datas.map((data) => CircleList.fromJson(data)).toList();


    return circledata;
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

  Future<List<AlertDetailsUpdate>> getUpdate() async {

    String newurl = AppNetworkConstants.ALERTUPDATE + "roleId=" + roleId!;

    print("Alert Update url is : "+newurl);

    var url = Uri.parse(newurl);

    http.Response res = await http.get(url);
    //  List datas= jsonDecode(res.body);

    print("Alert Update Response is : " +res.body);

  //  onNotificationClickListener.onNotificationClick();

    var datas = jsonDecode(res.body)['alertDetails'] as List;

    List<AlertDetailsUpdate> alertDetailsUpdate = datas.map((data) =>
        AlertDetailsUpdate.fromJson(data)).toList();

    return alertDetailsUpdate;
  }

  Future<List<PendingAcceptedList>> getAccepted() async {

    String newurl = AppNetworkConstants.ACCEPTEDORDER+ "driverId="+ UserId! +"&roleId="+roleId!+"&startDate="+fromtime;

    print("Accepted url is : " + newurl);

    var url = Uri.parse(newurl);

    http.Response res = await http.get(url);

    print("Pending api Response is : "+res.body);

    //  List datas= jsonDecode(res.body);
    var datas = jsonDecode(res.body)['pending'] as List;

    mainBottomNav.getNotificationfromHome();

    List<PendingAcceptedList> pendingAcceptedData = datas.map((data) =>
        PendingAcceptedList.fromJson(data)).toList();

    return pendingAcceptedData;
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
    togglecounter=logindata[0].counter!;
    duty=logindata[0].duty!;
    print("status clock for parameter is : "+statusvar);
    print("toggle counter for parameter is : "+togglecounter);
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

  Future<List<ResultAlertReminder>> getAlertReminder() async {

    String newurl = AppNetworkConstants.ALERTREMINDER+"pickuptime="+pickuptimefull+"&pickupdate="+pickupdate+"&transferQuoteId="+tranferquoteid;

    var url = Uri.parse(newurl);

    print("Alert Reminder api is : "+newurl);

    http.Response res = await http.get(url);

    print("Alert api Response is : "+res.body);

    var datas = jsonDecode(res.body)['result'] as List;

    List<ResultAlertReminder> logindata = datas.map((data) =>
        ResultAlertReminder.fromJson(data)).toList();

      alertmessage= logindata[0].massege.toString();

      alertDialog(context);

    return logindata;
  }

  Future<List<ResultReminderBell>> getReminderBell() async {


    String newurl = AppNetworkConstants.REMINDERBELL+"pickuptime="+pickuptimefull+"&pickupdate="+pickupdate+"&transferQuoteId="+tranferquoteid;

    var url = Uri.parse(newurl);

    print("Reminder Bell api is : "+newurl);

    http.Response res = await http.get(url);

    print("Reminder Bell api Response is : "+res.body);

    var datas = jsonDecode(res.body)['result'] as List;

    List<ResultReminderBell> logindata = datas.map((data) =>
        ResultReminderBell.fromJson(data)).toList();

    //   loadCircle=false;

    //   print("status clock form main method is : ${statusclock}");

    return logindata;
  }

  _makingPhoneCallAccepted() async {
    String url = 'tel:'+callaccepted;
    if (await launch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _makingWhatsappAccepted() async {
    // String url = '+919910910910';

    //  await launch('https://wa.me/$url?text=Welcome');

    String url = "91"+callaccepted;

    await launch("whatsapp://send?phone="+url+"&text=hello");
  }

  _makingPhoneCalldialog() async {
    String url = 'tel:'+callassign;
    if (await launch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _makingWhatsappdialog() async {
    // String url = '+919910910910';

    //  await launch('https://wa.me/$url?text=Welcome');

    String url = "+91"+callassign;

    await launch("whatsapp://send?phone="+url+"&text=hello");
  }

  alertDialog(BuildContext context){
    return showDialog(
        context: context,
        builder: (context){
          return  StatefulBuilder(
            builder: (context, setState) => AlertDialog(
             insetPadding: EdgeInsets.only(bottom: 100),
              alignment: Alignment.bottomCenter,
              actions: [

                Column(children: [

                  Container(
                    width: 320,
                  //  height: 100,
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Container(
                          margin: EdgeInsets.only(top: 0,right: 5),
                          child: Image.asset("image/alerticon.png",height: 30, width: 40,),
                        ),

                        Container(
                          margin: EdgeInsets.only(top: 0,left: 5),
                          child: Text("Alert",
                              // textAlign: TextAlign.left,
                              style: TextStyle(color: Colors.red,
                                fontSize: 16,
                                fontFamily: 'BebesNeue',
                                fontWeight: FontWeight.w700,)),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10,),

                  Container(
                    margin: EdgeInsets.only(left: 10,right: 10),
                    child: Text(alertmessage,
                         textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black,
                          fontSize: 11,
                          fontFamily: 'BebesNeue',
                          fontWeight: FontWeight.w700,)),
                  ),

                  SizedBox(height: 5,),

                  InkWell(
                    onTap: (){
                      //   getAcceptBook();
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(2.5),
                        //   border: Border.all(color: Colors.lightBlue,width: 1.0)
                      ),
                      width: 60,
                      child: Center(
                        child: Text("OK",
                            style: TextStyle(color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'BebesNeue',
                              fontWeight: FontWeight.w700,)),
                      ),
                      padding: EdgeInsets.only(top: 7.5, bottom: 7.5),
                      margin: EdgeInsets.only(top: 10),
                    ),
                  ),

                  SizedBox(height: 5,),

                 /* FutureBuilder(
                      future: getAlertReminder(),
                      builder:(context, snapshot) {

                        if(snapshot.hasData) {

                          alertremindermodel = snapshot.data as List<ResultAlertReminder>?;



                          return    Column(children: [

                          ],);

                        }

                        return Text("",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontFamily: 'BebesNeue',
                                fontWeight: FontWeight.w700));
                      }

                  ),*/

                ],),

              ],
            ),
          );
        });
  }

  remainderDialog(BuildContext context){
    return showDialog(
        context: context,
        builder: (context){
          return  StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              insetPadding: EdgeInsets.only(top: 100),
              alignment: Alignment.topCenter,
              backgroundColor: Colors.transparent,
              actions: [

                Container(
                  width: 410,
                  child: Column(

                    children: [

                      // blue Container

                      Container(
                        height:50,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(
                            color: Colors.blue,
                            //                   <--- border color
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
                        ),
                        child: Row(children: [



                          Container(
                            margin: EdgeInsets.only(top: 0,left: 50),
                            child: Image.asset("image/yellowbell.png",height: 30, width: 35,),
                          ),

                          Spacer(),

                          Container(
                            margin: EdgeInsets.only(top: 0,right: 20),
                            child: Text("Reminder",
                                style: TextStyle(color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'BebesNeue',
                                  fontWeight: FontWeight.w700,)),
                          ),

                          Spacer(),

                          InkWell(
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 0,right: 15),
                              child: Image.asset("image/crossicon.png",height: 20, width: 20,),
                            ),
                          ),

                        ]),
                      ),

                      SizedBox(height: 5,),

                      FutureBuilder(
                          future: getReminderBell(),
                          builder:(context, snapshot) {

                            if(snapshot.hasData) {

                              reminderbellmodel = snapshot.data;

                              pickupdatebell = reminderbellmodel![0].pickupdate.toString();
                              pickuptimebell = reminderbellmodel![0].pickupTime.toString();
                              guestnamebell = reminderbellmodel![0].guestname.toString();
                              pickupaddressbell = reminderbellmodel![0].pickupadd.toString();
                              reminderbell = reminderbellmodel![0].reminder.toString();
                              phonebell = reminderbellmodel![0].phone.toString();

                              print("Remider bell is : " + reminderbell);

                              print("Guest Name bell is : " + guestnamebell);

                              if(pickuptimebell=="null" || guestnamebell=="null"){
                                isReminder=false;
                                isnotReminder=true;
                              }else {
                                isReminder=true;
                                isnotReminder=false;
                              }

                              /* if(reminderbell=="0" || reminderbell=="null"){
                                  isReminder=false;
                                  isnotReminder=true;
                                }else {
                                 isReminder=true;
                                 isnotReminder=false;
                                }*/

                              return  Container(
                                width: 410,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.white,
                                      //                   <--- border color
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                                  ),
                                  child:Column(children: [

                                    SizedBox(height: 15,),

                                    Visibility(
                                      visible: isReminder,
                                      child: Column(children: [


                                        // pickup date

                                        Row(
                                            children: [

                                              Container(
                                                margin: EdgeInsets.only(left: 5),
                                                child:  Text("Pickup Date : ",
                                                  style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                                              ),

                                              Container(
                                                margin: EdgeInsets.only(left: 1.5),
                                                child:  Text(pickupdatebell,
                                                  style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                                              ),

                                              Spacer(),

                                              Container(
                                                margin: EdgeInsets.only(left: 0),
                                                child:  Text("Pickup Time : ",
                                                  style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                                              ),

                                              Container(
                                                width: 60,
                                                margin: EdgeInsets.only(left:1, right: 5),
                                                child:  Text(pickuptimebell,
                                                  style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                                              ),

                                            ]
                                        ),

                                        SizedBox(height: 10,),

                                        // pickup address
                                        Row(
                                            children: [

                                              Container(
                                                margin: EdgeInsets.only(left: 5),
                                                child:  Text("Pickup Address : ",
                                                  style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                                              ),


                                              Container(
                                                width: 150,
                                                margin: EdgeInsets.only(left: 5),
                                                child:  Text(pickupaddressbell,
                                                  maxLines: 1,
                                                  style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.left,
                                                  overflow: TextOverflow.ellipsis,),
                                              ),

                                              Spacer(),

                                              InkWell(
                                                onTap: (){
                                                  pickupAddress=pickupaddressbell;
                                                  print("send Address is : $pickupAddress");

                                                  if(pickupAddress==""){
                                                    Fluttertoast.showToast(
                                                        msg:  "No Location Available Now",
                                                        toastLength: Toast.LENGTH_SHORT,
                                                        gravity: ToastGravity.BOTTOM,
                                                        timeInSecForIosWeb: 4,
                                                        backgroundColor: Colors.black,
                                                        textColor: Colors.white,
                                                        fontSize: 14.0
                                                    );
                                                  }
                                                  else{
                                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CurrentLocation(newaddress: pickupAddress!)));
                                                    print("is pressed");
                                                  }
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(right: 10),
                                                  child:  Image.asset("image/location.png", width: 20, height: 20,),
                                                ),
                                              ),

                                            ]
                                        ),

                                        SizedBox(height: 10,),

                                        // dotted line

                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: 6,
                                          margin: EdgeInsets.only(left:10,right: 10),
                                          child:  Image.asset("image/dotline.png",),
                                        ),

                                        SizedBox(height: 5,),

                                        // Guest name

                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [

                                              Container(
                                                margin: EdgeInsets.only(left: 5),
                                                child:  Text("Guest Name : ",
                                                  style: TextStyle(color: Colors.lightBlue,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                                              ),


                                              Container(
                                                margin: EdgeInsets.only(left: 5),
                                                child:  Text(guestnamebell,
                                                  maxLines: 1,
                                                  style: TextStyle(color: Colors.lightBlue,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                                              ),

                                            ]
                                        ),


                                        SizedBox(height: 5,),

                                        // mobile no

                                        Row(
                                            children: [

                                              Container(
                                                margin: EdgeInsets.only(left: 5),
                                                child:  Text("Mobile No : ",
                                                  style: TextStyle(color: Colors.lightBlue,fontSize: 13,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                                              ),


                                              Column(
                                                children:[

                                                  Visibility(
                                                    visible: isCall,
                                                    child: Container(
                                                      margin: EdgeInsets.only(left: 5),
                                                      child:  Text("+91"+phonebell,
                                                        maxLines: 1,
                                                        style: TextStyle(color: Colors.lightBlue,fontSize: 14,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                                                    ),
                                                  ),

                                                  Visibility(
                                                    visible:isCallNot,
                                                    child: Container(
                                                      margin: EdgeInsets.only(left: 5),
                                                      child:  Text("",
                                                        maxLines: 1,
                                                        style: TextStyle(color:Colors.lightBlue,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                                                    ),
                                                  ),
                                                ],

                                              ),

                                              Spacer(),

                                              Visibility(
                                                visible: isCall,
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: (){
                                                        callassign="+91"+phonebell;
                                                        print("Callasign is : $callassign");
                                                        _makingPhoneCalldialog();
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(right: 20),
                                                        child:  Image.asset("image/calllaticon.png", width: 27.5, height: 30,),
                                                      ),
                                                    ),

                                                    InkWell(
                                                      onTap:(){
                                                        // whatsappnumber="+91-9910924485";
                                                        callassign="+91"+phonebell;
                                                        print("Callasign whats app is : $callassign");
                                                        _makingWhatsappdialog();
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(right: 25),
                                                        child: Image.asset(
                                                          "image/whatslaticon.png", height: 25,
                                                          width: 25,),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              Visibility(
                                                  visible:isCallNot,
                                                  child: Text(""))



                                            ]
                                        ),

                                        SizedBox(height: 5,),

                                        // dotted line

                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: 6,
                                          margin: EdgeInsets.only(left:10,right: 10),
                                          child:  Image.asset("image/dotline.png",),
                                        ),

                                      ],),
                                    ),

                                    Visibility(
                                      visible: isnotReminder,
                                      child: Column(children: [

                                        SizedBox(height: 10,),

                                        Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child:  Text("No Reminder Now : ",
                                            style: TextStyle(color: Colors.lightBlue,fontSize: 16,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                                        ),

                                        SizedBox(height: 5,),

                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: 6,
                                          margin: EdgeInsets.only(left:5,right: 5),
                                          child:  Image.asset("image/dotline.png",),
                                        ),

                                      ],),
                                    ),

                                    SizedBox(height: 10,),
                                  ])
                              );


                            }

                            return Text("No Data",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11,
                                    fontFamily: 'BebesNeue',
                                    fontWeight: FontWeight.w700));
                          }

                      ),

                    ],),
                ),

              ],
            ),
          );
        });
  }


}
