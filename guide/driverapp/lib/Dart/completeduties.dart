import 'dart:async';
import 'dart:convert';

import 'package:driverapp/Dart/BottomNavHome.dart';
import 'package:driverapp/Dart/pendingduties.dart';
import 'package:driverapp/Dart/profile.dart';
import 'package:driverapp/Dart/voucherwv.dart';
import 'package:driverapp/Models/AcceptedListModel.dart';
import 'package:driverapp/Models/AssignListModel.dart';
import 'package:driverapp/Models/CompleteModel.dart';
import 'package:driverapp/Models/RejectedListModel.dart';
import 'package:driverapp/Models/ToggleModel.dart';
import 'package:driverapp/Models/ToggleNotifyModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Apis/apis.dart';
import '../Models/AlertUpdateModel.dart';
import '../Models/NotificationModel.dart';
import '../Models/ProfileModel.dart';
import '../main.dart';
import 'BottomNavAlert.dart';
import 'BottomNavComplete.dart';
import 'BottomNavList.dart';
import 'BottomNavPending.dart';
import 'alert.dart';
import 'completeduties.dart';
import 'package:http/http.dart' as http;
import 'currentlocation.dart';
import 'home.dart';
import 'login.dart';
import 'mylist.dart';


class CompleteDutiesSL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: CompleteDuties(),
    );
  }
}

class CompleteDuties extends StatefulWidget {

  @override
  State createState() => MyCompleteDuties();
}

class MyCompleteDuties extends State<CompleteDuties> {

  bool loadCircle = false;

  late SharedPreferences prefsotp, prefmobno, prefroleid, preflog_in_out,prefuserid,preffullname,prefstatus,prefrolename,prefnotification;

  String? UserId="45";
  String? roleId="3";
  String? fullname="1";
  String? status="1";
  String? rolenamefirst="";
  String? rolenamesecond="";

  String? call="123456789";
  String destination="";

  bool isCall=true;
  bool isCallNot=false;


  String? pickupAddress="0";
  String? dropAddress="0";


  DateTime fromselectedDate = DateTime.now();
  static String fromtime= DateFormat('dd-MMM-yyyy').format(DateTime.now());
  GlobalKey<ScaffoldState> _drawerkey= GlobalKey<ScaffoldState>();

  String statusvar="";
  String duty="";
  String togglecounter="";
  List<ResultsToggleNotify>? togglenotifymodel;
  List<ResultsToggle>? togglemodel;

  bool statusclock = false;
  String clock="Off Duty";
  String clocktime="";
  bool isSwitched = false;
  bool isClockfont=true;
  bool isClockedfont=false;
  Color selecttogglecolor= Colors.lightGreen;

  List<NotificationsList>? notificatiomodel;
  String? notifcation="";
  bool isShow=false;
  bool isNotShow=true;
  List<CompleteDutiesList>? completedutiesmodel;

  bool isCompleteNotClickable=true;
  bool isCompleteClickable=false;

  getCompleteClickable(){
    setState(() {
      isCompleteNotClickable=false;
      isCompleteClickable=true;
    });
  }

  getCompleteNotClickable(){
    setState(() {
      isCompleteNotClickable=true;
      isCompleteClickable=false;
    });
  }


  @override
  void initState() {
    super.initState();
    getUpdate();
    getPref();
  }

  Future getPref() async {
    prefroleid = await SharedPreferences.getInstance();
    prefmobno = await SharedPreferences.getInstance();
    prefsotp = await SharedPreferences.getInstance();
    prefuserid = await SharedPreferences.getInstance();
    preffullname = await SharedPreferences.getInstance();
    prefstatus = await SharedPreferences.getInstance();
    prefrolename = await SharedPreferences.getInstance();
    preflog_in_out = await SharedPreferences.getInstance();
    prefnotification = await SharedPreferences.getInstance();

    setState(() {

     /* notifcation = prefnotification.getString("count");
      print("my Recieved  Count is : $notifcation");*/

      UserId = prefuserid.getString("userid")!;
      print("my Recieved OTP is : $UserId");

      roleId = prefroleid.getString("roleid")!;
      print("my Recieved Role Id in Home is : $roleId");

      fullname = preffullname.getString("fullname");
      print("my Recieved  Full Name is : $fullname");

      status = prefstatus.getString("status");
      print("my Recieved  Status is : $status");

      //rolename = prefrolename.getString("rolename");
      // print("my Recieved  rolename is : $rolename");

      if(fullname==null){
        fullname="User Name";
      }

    //  getChangedName();

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
                margin: EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        prefsotp.clear();
                        prefmobno.clear();
                        prefroleid.clear();
                        preflog_in_out.clear();
                        preffullname.clear();
                        prefuserid.clear();
                        prefstatus.clear();

                        Navigator.of(context).pop();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {return Login();}));
                        print("is pressed");
                      },
                      child: Container(
                        width: 60,
                        height:30,
                        margin: EdgeInsets.only(right: 20),
                        child: Center(child: Text("Yes",style: TextStyle(color: Colors.white, fontSize: 14,
                            fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,)),
                        decoration: BoxDecoration(color: Colors.blue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: 60,
                        height:30,
                        margin: EdgeInsets.only(left: 20),
                        child: Center(child: Text("No",style: TextStyle(color: Colors.white, fontSize: 14,
                            fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,)),
                        decoration: BoxDecoration(color: Colors.blue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ],
                ),
              )
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
          resizeToAvoidBottomInset: false,
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
                        image: AssetImage("image/menuhbg.png"),
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
                            /* border: Border.all(
                                    color: Colors.white,
                                    width: 2.0
                                )*/
                          ),
                          margin: EdgeInsets.only(left: 15,top: 10),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child:Image.asset("image/profilepic.png",height: 80, width: 80,)),
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
                                child: Image.asset("image/profilemenu.png",height: 18, width: 22,),
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
                                child: Image.asset("image/listmenu.png",height: 22, width: 22,),
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
                                child: Image.asset("image/pendingmenu.png",height: 22, width: 22,),
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
                                child: Image.asset("image/completemenu.png",height: 22, width: 22,),
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
                                child: Image.asset("image/logoutmenu.png",height: 22, width: 22,),
                              ),

                              Container(
                                margin: EdgeInsets.only(left: 25),
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
              //  margin: EdgeInsets.only(top: 25),
              child: Column(children: [

                Row(
                  children: [

                    InkWell(
                      onTap: (){
                        _drawerkey.currentState?.openDrawer();
                        print("drawer is pressed");
                      },
                      child: Container(
                        width: 25,
                        height: 22,
                        margin: EdgeInsets.only(top:15,left: 15),
                        child: Image.asset("image/guidehamburg.png",height: 22, width: 25,),
                      ),
                    ),

                    Spacer(),

                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Image.asset("image/guidelogo.png", height: 50.0, width: 120),
                    ),

                    Spacer(),

                    Container(
                      height: 22.5,
                      width: 22.5,
                      margin: EdgeInsets.only(top:15,right: 15),
                      child: Text(""),
                    ),
                  ],

                ),
              ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 100),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("image/guidehomebglat.jpg"),
                    fit: BoxFit.cover,
                  ),

                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
                ),
                child: Column(children: [

                  Container(
                    margin:EdgeInsets.only(top: 20,right: 17.5,left: 17.5),
                    child: Container(
                      width: 180,
                      margin: EdgeInsets.only(right: 5,left: 5),
                      padding: EdgeInsets.only(left:10,right:10,top: 10, bottom: 12.5),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        border: Border.all(
                          color: Colors.orange,
                          //                   <--- border color
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                      ),
                      child: Center(child:Text("COMPLETED DUTIES", style: TextStyle(color: Colors.black54, fontSize: 15, fontFamily: 'BebesNeue',
                          fontWeight: FontWeight.w700),),),
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft:Radius.circular(17.5),topRight:Radius.circular(17.5),),
                    ),

                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 12.5,bottom: 12.5),
                    margin: EdgeInsets.only(top: 0,left: 15,right: 15),


                    child: InkWell(
                      onTap: (){
                        selectFromDate(context);
                      },
                      child: Container(
                        child: Center(
                          child: Text(fromtime,
                              style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                        ),
                      ),
                    ),

                  ),

                  Container(
                    margin: EdgeInsets.only(left: 15,right: 15),
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: Colors.grey,
                  ),

                  FutureBuilder(
                      future: getComplete(),
                      builder:(context, snapshot) {

                        if(snapshot.hasData) {
                          completedutiesmodel= snapshot.data as List<CompleteDutiesList>;

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
      ),
    );
  }


  Widget  getBodyWidget() {
    

    return Expanded(
      child: ListView.builder(
          padding: EdgeInsets.only(top: 0,bottom: 5),
          itemCount: completedutiesmodel!.length,
          itemBuilder: (context,index){
            CompleteDutiesList itemslists = completedutiesmodel![index];

            if (itemslists.destination!.length > 0) {
              destination = itemslists.destination!.substring(
                  0, itemslists.destination!.length - 2);
            }else{
              destination="";
            }

            if(itemslists.guestphone!=""){
              isCall=true;
            }else{
              isCallNot=false;
            }


            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: 5,left: 15,right: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.white,
                  //                   <--- border color
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  SizedBox(height: 17.5,),


                  // pickup time

                  Row(
                      children: [

                        Container(
                          margin: EdgeInsets.only(left: 7.5),
                          child:  Text("Planned Activity Time : ",
                            style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                        ),




                        Container(
                          margin: EdgeInsets.only(left: 0),
                          child:  Text(itemslists.pickupTime.toString(),
                            style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                        ),

                        /*Spacer(),

                        Container(
                          margin: EdgeInsets.only(left: 0),
                          child:  Text("End Activity Time : ",
                            style: TextStyle(color: Colors.black,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                        ),

                        Container(
                          width:60,
                          margin: EdgeInsets.only(left:0,right: 5),
                          child:  Text(itemslists.pickupTime.toString(),
                            style: TextStyle(color: Colors.black,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                        ),*/

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


                  SizedBox(height: 10,),

                  // actual pickup time
                  Row(
                      children: [

                        Container(
                          margin: EdgeInsets.only(left: 7.5),
                          child:  Text("Actual Start Time : ",
                            style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child:  Text(itemslists.actualPickupTime!,
                            style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                        ),

                      ]
                  ),

                  SizedBox(height: 10,),

                  // actual drop time
                  Row(
                      children: [

                        Container(
                          margin: EdgeInsets.only(left: 7.5),
                          child:  Text("Actual End Time : ",
                            style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child:  Text(itemslists.actualdropTime!,
                            style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
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

                  SizedBox(height: 10,),

                  // no of guest

                  Row(
                      children: [

                        Container(
                          margin: EdgeInsets.only(left: 7.5),
                          child:  Text("No. of Guest : ",
                            style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                        ),


                        Container(
                          padding: EdgeInsets.only(left: 5,right: 5,top: 2.5,bottom: 2.5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.orange,width: 1),
                            borderRadius: BorderRadius.only(topLeft:Radius.circular(2.5),topRight:Radius.circular(2.5),
                              bottomLeft:Radius.circular(2.5),bottomRight:Radius.circular(2.5),), ),
                          margin: EdgeInsets.only(left: 6),
                          child:  Text(itemslists.guest!,
                            maxLines: 1,
                            style: TextStyle(color: Colors.orange,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                        ),

                      ]
                  ),

                  SizedBox(height: 10,),

                  // guest name
                  Row(
                      children: [

                        Container(
                          margin: EdgeInsets.only(left: 7.5),
                          child:  Text("Guest Name : ",
                            style: TextStyle(color: Colors.orange,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                        ),


                        Container(
                          margin: EdgeInsets.only(left: 6),
                          child:  Text(itemslists.guestname!,
                            maxLines: 1,
                            style: TextStyle(color: Colors.orange,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                        ),

                      ]
                  ),

                  SizedBox(height: 10,),

                  // mobile no

                  Row(
                      children: [

                        Container(
                          margin: EdgeInsets.only(left: 7.5),
                          child:  Text("Mobile No : ",
                            style: TextStyle(color: Colors.orange,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                        ),


                        Column(
                          children:[

                            Visibility(
                              visible: isCall,
                              child: Container(
                                margin: EdgeInsets.only(left: 5),
                                child:  Text("+91"+itemslists.guestphone!,
                                  maxLines: 1,
                                  style: TextStyle(color: Colors.orange,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                              ),
                            ),

                            Visibility(
                              visible:isCallNot,
                              child: Container(
                                margin: EdgeInsets.only(left: 5),
                                child:  Text("",
                                  maxLines: 1,
                                  style: TextStyle(color:Colors.orange,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
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
                                  call="+91"+itemslists.guestphone.toString();
                                  print("call is : $call");
                                  _makingPhoneCall;
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 20),
                                  child:  Image.asset("image/calllaticon.png", width: 27.5, height: 30,),
                                ),
                              ),

                              InkWell(
                                onTap:(){
                                  // whatsappnumber="+91-9910924485";
                                  call="+91"+itemslists.guestphone.toString();
                                  print("callrejected whats app is : $call");
                                  _makingWhatsapp();
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

                  SizedBox(height: 10,),

                  // dot line
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 3,
                    margin: EdgeInsets.only(left:15,right: 15),
                    child:  Image.asset("image/dotline.png",),
                  ),

                  SizedBox(height: 10,),

                  // Start Activity time

                /*  Row(
                      children: [

                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child:  Text("Start Activity Time : ",
                            style: TextStyle(color: Colors.black,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child:  Text(itemslists.startReading!,
                            style: TextStyle(color: Colors.black,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                        ),

                      ]
                  ),

                  SizedBox(height: 10,),

                  Row(
                      children: [

                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child:  Text("End Activity Time : ",
                            style: TextStyle(color: Colors.black,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child:  Text(itemslists.endReading!,
                            style: TextStyle(color: Colors.black,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                        ),

                      ]
                  ),

                  SizedBox(height: 10,),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 3,
                    margin: EdgeInsets.only(left:15,right: 15),
                    child:  Image.asset("image/dotline.png",),
                  ),*/

                  SizedBox(height: 10,),

                  // Tour Id
                  Row(
                      children: [

                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child:  Text("Tour ID : ",
                            style: TextStyle(color: Colors.brown,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 30),
                          child:  Text(itemslists.tourId!,
                            style: TextStyle(color: Colors.black45,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                        ),

                      ]
                  ),

                  SizedBox(height: 7.5,),

                  // Tour Date

                  Row(
                      children: [

                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child:  Text("Tour Date : ",
                              style: TextStyle(color: Colors.brown,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 18),
                          child:  Text(itemslists.tourDate!,
                              style: TextStyle(color: Colors.black45,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                        ),

                      ]
                  ),

                  SizedBox(height: 7.5,),

                  // Destination

                  Row(
                      children: [

                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child:  Text("Destination : ",
                              style: TextStyle(color: Colors.brown,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                        ),

                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            child:  Text(itemslists.destination!,
                                maxLines: 1,
                                style: TextStyle(color: Colors.black45,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                          ),
                        ),

                      ]
                  ),




                  SizedBox(height: 20,),
                ],


              ),
            );
          }
      ),
    );

  }

  Future<List<CompleteDutiesList>> getComplete() async {

    /* setState(() {
      loadCircle = true;
    });*/

    String newurl = AppNetworkConstants.COMPLETEDUTIES+ "driverId="+ UserId! +"&roleId="+roleId!+"&startDate="+fromtime;

    print("Completed url is : " + newurl);

    var url = Uri.parse(newurl);



    http.Response res = await http.get(url);

    //  List datas= jsonDecode(res.body);

    var datas = jsonDecode(res.body)['completeDuties'] as List;

    /*setState(() {
      loadCircle = false;
    });*/

    List<CompleteDutiesList> completedutiesdata = datas.map((data) =>
        CompleteDutiesList.fromJson(data)).toList();

   // completedutiesdata[0].id;


    return completedutiesdata;
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
        getComplete();
        Fluttertoast.showToast(
            msg: "Updated Now",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 4,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 12.0
        );

      });
    }
  }

  _makingPhoneCall() async {
    String url = 'tel:'+call!;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _makingWhatsapp() async {

    String url = "91"+call!;

    await launch("whatsapp://send?phone="+url+"&text=hello");
  }

  Future<List<NotificationsList>> getNotification() async {

    String newurl = AppNetworkConstants.NOTIFICATION + "driverId=" +UserId!+ "&roleId=" + roleId!;

    print("Notification url is : "+newurl);

    var url = Uri.parse(newurl);

    http.Response res = await http.get(url);
    //  List datas= jsonDecode(res.body);

    var datas = jsonDecode(res.body)['notifications'] as List;

    List<NotificationsList> notificationData = datas.map((data) =>
        NotificationsList.fromJson(data)).toList();

    return notificationData;
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

  Future<List<AlertDetailsUpdate>> getUpdate() async {

    String newurl = AppNetworkConstants.ALERTUPDATE + "roleId=" + roleId!;

    print("Alert Update url is : "+newurl);

    var url = Uri.parse(newurl);

    http.Response res = await http.get(url);
    //  List datas= jsonDecode(res.body);

    print("Alert Update Response is : " +res.body);

    var datas = jsonDecode(res.body)['alertDetails'] as List;

    List<AlertDetailsUpdate> alertDetailsUpdate = datas.map((data) =>
        AlertDetailsUpdate.fromJson(data)).toList();

    return alertDetailsUpdate;
  }

  Future<List<ProfileData>> getProfile() async {

    String newurl = AppNetworkConstants.PROFILE + "driverId=" +UserId!+ "&roleId=" + roleId!;

    print("Profile Url is : "+newurl);

    var url = Uri.parse(newurl);

    http.Response res = await http.get(url);

    print("Profile Response is  : "+res.body);

    //  List datas= jsonDecode(res.body);

    var datas = jsonDecode(res.body)['profileData'] as List;

    List<ProfileData> logindata = datas.map((data) =>
        ProfileData.fromJson(data)).toList();

    return logindata;
  }

}
