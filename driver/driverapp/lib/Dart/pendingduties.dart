import 'dart:async';
import 'dart:convert';

import 'package:driverapp/Dart/BottomNavHome.dart';
import 'package:driverapp/Dart/profile.dart';
import 'package:driverapp/Models/AcceptedListModel.dart';
import 'package:driverapp/Models/CompleteBookModel.dart';
import 'package:driverapp/Models/ToggleModel.dart';
import 'package:driverapp/Models/ToggleNotifyModel.dart';
import 'package:driverapp/Models/starttripModel.dart';
import 'package:driverapp/Providers/pickeralert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Apis/apis.dart';
import '../Models/AlertUpdateModel.dart';
import '../Models/NotificationModel.dart';
import '../Models/ProfileModel.dart';
import 'BottomNavAlert.dart';
import 'BottomNavComplete.dart';
import 'BottomNavList.dart';
import 'BottomNavPending.dart';
import 'package:http/http.dart' as http;
import 'currentlocation.dart';
import 'login.dart';

class PendingDutiesSL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: PendingDuties(),
    );
  }
}

class PendingDuties extends StatefulWidget {

  @override
  State createState() => MyPendingDuties();
}

class MyPendingDuties extends State<PendingDuties> {

  MainBottomNav mainBottomNav = new MainBottomNav();

  String destination="";

  bool loadCircle = false;

  Color selecttogglecolor= Colors.lightGreen;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  var startup = "";
  var endup = "";
  var m_startcontroller = TextEditingController();
  var m_endcontroller = TextEditingController();

  String? startValidate(String? value) {
    if (value == null || value.isEmpty)
      return 'Enter Start Reading';
    else
      startup = value;
    print("Start Reading  is : " + startup);
    return null;
  }

  String? endValidate(String? value) {
    if (value == null || value.isEmpty)
      return 'Enter End Reading';
    else
      endup = value;
    print("End Reading  is : " + startup);
    return null;
  }

  late SharedPreferences prefsotp, prefmobno, prefroleid, preflog_in_out,prefuserid,preffullname,prefstatus,prefrolename,prefnotification,
      prefstatusvar;

  String? UserId="12";
  String? roleId="2";
  String? fullname="1";
  String? status="1";
  String? rolenamefirst="";
  String? rolenamesecond="";

  String? queryId="1";
  String? transferQuoteId="1";
  String? quationId="1";

  String? pickupAddress="0";
  String? dropAddress="0";

  String? notifcation="";

  String callaccepted="123456789";
  String? starttrip="";

  bool isCall=true;
  bool isCallNot=false;
  bool isActual= false;
  bool isActualNot= true;

  DateTime fromselectedDate = DateTime.now();
  static String fromtime= DateFormat('dd-MMM-yyyy').format(DateTime.now());
  GlobalKey<ScaffoldState> _drawerkey= GlobalKey<ScaffoldState>();

  bool statusclock = false;
  String clock="Off Duty";
  String clocktime="";
  bool isSwitched = false;
  bool isClockfont=true;
  bool isClockedfont=false;
  String statusvar="";
  String duty="";
  List<ResultsToggleNotify>? togglenotifymodel;

  String currenttime="";
  String hour="";


  List<PendingAcceptedList>? pendingacceptedmodel;
  List<NotificationsList>? notificatiomodel;

  bool isCompleteNotClickable=true;
  bool isCompleteClickable=false;

  bool isStartTrip=true;
  bool isNotStartTrip=false;

  bool isShow=false;
  bool isNotShow=true;

  /*getCompleteClickable(){
    setState(() {
      isCompleteNotClickable=false;
      isCompleteClickable=true;
      print("its working now ");
    });

  }

  getCompleteNotClickable(){
    setState(() {
      isCompleteNotClickable=true;
      isCompleteClickable=false;
    });
  }*/

  @override
  void initState() {
    super.initState();
    getPref();
    getToogleNotify();
    getUpdate();
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
    prefstatusvar = await SharedPreferences.getInstance();

    setState(() {

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
                      child:Image.asset("image/pending_duties_rearicon.png", width: 180, height: 65,),
                    ),
                  ),

                  SizedBox(height: 12.5,),

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
                              selectFromDateAccepted(context);
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

                          return getBodyWidgetAccepted();

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


  Widget  getBodyWidgetAccepted() {

    return Expanded(
      child: Stack(
        clipBehavior: Clip.none,
        children: [

          ListView.builder(
              padding: EdgeInsets.only(top: 5,bottom: 5),
              itemCount: pendingacceptedmodel!.length,
              itemBuilder: (context,index){
                PendingAcceptedList itemslists = pendingacceptedmodel![index];

                starttrip = itemslists.starttrip;

                print("Start Trip from List " + starttrip!);

              /*  if(starttrip=="0"){
                  isStartTrip=true;
                  isNotStartTrip=false;

                  isCompleteNotClickable=true;
                  isCompleteClickable=false;
                  print("Gray Completed");
                }else{
                  isStartTrip=false;
                  isNotStartTrip=true;

                  isCompleteNotClickable=false;
                  isCompleteClickable=true;
                  print("Green Completed");
                }*/

                if(starttrip=="0"){
                  isStartTrip=true;
                  isCompleteClickable=false;
                  print("Gray Completed");
                }else{
                  isStartTrip=false;
                  isCompleteClickable=true;
                  print("Green Completed");
                }

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

                if(itemslists.actualPickupTime!=""){
                  isActual=true;
                //  isActualNot=true;
                }else{
                  isActual=false;
                //  isActualNot=false;
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
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),

                      // pickup time

                      Row(
                          children: [

                            Container(
                              margin: EdgeInsets.only(left: 7.5),
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
                              margin: EdgeInsets.only(left: 7.5),
                              child:  Text("Pickup Address : ",
                                style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                            ),


                            Container(
                              width: 150,
                              margin: EdgeInsets.only(left: 5),
                              child:  Text(itemslists.pickupAddress!,
                                maxLines: 1,
                                style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.left,
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
                                  style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                              ),

                              Container(
                                margin: EdgeInsets.only(left: 5,top: 10),
                                child:  Text(itemslists.actualPickupTime!,
                                  style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
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
                              margin: EdgeInsets.only(left: 7.5),
                              child:  Text("No. of Guest : ",
                                style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                            ),


                            Container(
                              padding: EdgeInsets.only(left: 5,right: 5,top: 2.5,bottom: 2.5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.lightGreen,width: 1),
                                borderRadius: BorderRadius.only(topLeft:Radius.circular(2.5),topRight:Radius.circular(2.5),
                                  bottomLeft:Radius.circular(2.5),bottomRight:Radius.circular(2.5),), ),
                              margin: EdgeInsets.only(left: 6),
                              child:  Text(itemslists.guest!,
                                maxLines: 1,
                                style: TextStyle(color: Colors.lightGreen,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
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
                                style: TextStyle(color: Colors.lightGreen,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                            ),


                            Container(
                              margin: EdgeInsets.only(left: 6),
                              child:  Text(itemslists.guestname!,
                                maxLines: 1,
                                style: TextStyle(color: Colors.lightGreen,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
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
                                style: TextStyle(color: Colors.lightGreen,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                            ),


                            Column(
                              children:[

                                Visibility(
                                  visible: isCall,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child:  Text("+91"+itemslists.guestphone!,
                                      maxLines: 1,
                                      style: TextStyle(color: Colors.lightGreen,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                                  ),
                                ),

                                Visibility(
                                  visible:isCallNot,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child:  Text("",
                                      maxLines: 1,
                                      style: TextStyle(color:Colors.lightGreen,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
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

                      SizedBox(height: 10,),

                      // dot line
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 3,
                        margin: EdgeInsets.only(left:15,right: 15),
                        child:  Image.asset("image/dotline.png",),
                      ),

                      SizedBox(height: 10,),

                      // tour id
                      Row(
                          children: [

                            Container(
                              margin: EdgeInsets.only(left: 7.5),
                              child:  Text("Tour Id : ",
                                style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 35),
                              child:  Text(itemslists.tourId!,
                                style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                            ),

                          ]
                      ),

                      SizedBox(height: 10,),

                      // tour date
                      Row(
                          children: [

                            Container(
                              margin: EdgeInsets.only(left: 7.5),
                              child:  Text("Tour Date : ",
                                style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child:  Text(itemslists.tourDate!,
                                style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                            ),

                          ]
                      ),

                      SizedBox(height: 10,),

                      // destination
                      Row(
                          children: [

                            Container(
                              margin: EdgeInsets.only(left: 7.5),
                              child:  Text("Destination : ",
                                style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                            ),

                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 12),
                                child:  Text(destination,
                                  maxLines: 1,
                                  style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                                  overflow: TextOverflow.ellipsis,),
                              ),
                            ),

                          ]
                      ),

                      SizedBox(height: 15,),



                     /* Row(children: [
                        InkWell(
                          onTap: () {
                            queryId=itemslists.queryId;
                            transferQuoteId=itemslists.transferQuotId;
                            quationId=itemslists.quotationId;

                            print("Query Id is : $queryId");
                            print("TransferQuoteId is : $transferQuoteId");
                            print("Quation Id is : $quationId");

                            completeDialog(context);
                          },
                          child: Container(
                            height: 40,
                            padding: EdgeInsets.only(left:10,right: 10, top: 3.5, bottom: 3.5),
                            decoration: BoxDecoration(
                              color: Colors.lightGreen,
                              border: Border.all(
                                color: Colors.lightGreen,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(2.5),
                            ),
                            margin: EdgeInsets.only(left:15,right: 15),
                            child: Center(
                              child: Text("Complete Trip",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: 'BebesNeue',
                                      fontWeight: FontWeight.w700)),
                            ),),
                        )
                      ],),*/

                     /* Row(children: [

                        Visibility(
                          visible: isStartTrip,
                          child:Expanded(
                            child: InkWell(
                              onTap: (){
                                starttrip=itemslists.starttrip;
                                queryId=itemslists.queryId;
                                transferQuoteId=itemslists.transferQuotId;
                                quationId=itemslists.quotationId;

                                print("my start trip is : "+starttrip!);
                                print("Query Id is : $queryId");
                                print("TransferQuoteId is : $transferQuoteId");
                                print("Quation Id is : $quationId");

                                startTripDialog(context);
                              },
                              child: Container(
                                height: 40,
                                padding: EdgeInsets.only(top: 3.5, bottom: 3.5),
                                decoration: BoxDecoration(
                                  color: Colors.lightGreen,
                                  border: Border.all(
                                    color: Colors.lightGreen,
                                    //                   <--- border color
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: EdgeInsets.only(left: 15,right: 30),
                                child: Center(
                                  child: Text("Start Trip",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: 'BebesNeue',
                                          fontWeight: FontWeight.w700)),
                                ),),
                            ),
                          ),
                        ),

                        Visibility(
                          visible: isNotStartTrip,
                          child:Expanded(
                            child: InkWell(
                              onTap: (){
                                Fluttertoast.showToast(
                                    msg: "Your Trip is Already Start",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 4,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 14.0
                                );
                              },
                              child: Container(
                                height: 40,
                                padding: EdgeInsets.only(top: 3.5, bottom: 3.5),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  border: Border.all(
                                    color: Colors.grey,
                                    //                   <--- border color
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: EdgeInsets.only(left: 15,right: 30),
                                child: Center(
                                  child: Text("Start Trip",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: 'BebesNeue',
                                          fontWeight: FontWeight.w700)),
                                ),),
                            ),
                          ),
                        ),

                        Visibility(
                          visible: isCompleteNotClickable,
                          child: Expanded(
                            child: InkWell(
                              onTap: () {
                                 Fluttertoast.showToast(
                                    msg: "Please Confirm on Start Trip...",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 4,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 14.0
                                );
                              },
                              child: Container(
                                height: 40,
                                padding: EdgeInsets.only(top: 3.5, bottom: 3.5),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: EdgeInsets.only(left:30,right: 15),
                                child: Center(
                                  child: Text("Complete Trip",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: 'BebesNeue',
                                          fontWeight: FontWeight.w700)),
                                ),),
                            ),
                          ),
                        ),

                        Visibility(
                          visible: isCompleteClickable,
                          child: Expanded(
                            child: InkWell(
                              onTap: () {
                                queryId=itemslists.queryId;
                                transferQuoteId=itemslists.transferQuotId;
                                quationId=itemslists.quotationId;

                                print("Query Id is : $queryId");
                                print("TransferQuoteId is : $transferQuoteId");
                                print("Quation Id is : $quationId");

                                endTripDialog(context);
                              },
                              child: Container(
                                height: 40,
                                padding: EdgeInsets.only(top: 3.5, bottom: 3.5),
                                decoration: BoxDecoration(
                                  color: Colors.lightGreen,
                                  border: Border.all(
                                    color: Colors.lightGreen,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: EdgeInsets.only(left:30,right: 15),
                                child: Center(
                                  child: Text("Complete Trip",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: 'BebesNeue',
                                          fontWeight: FontWeight.w700)),
                                ),),
                            ),
                          ),
                        ),

                      ],

                      ),*/


                      Row(children: [

                        Visibility(
                          visible: isStartTrip,
                          child:InkWell(
                            onTap: (){
                              starttrip=itemslists.starttrip;
                              queryId=itemslists.queryId;
                              transferQuoteId=itemslists.transferQuotId;
                              quationId=itemslists.quotationId;

                              print("my start trip is : "+starttrip!);
                              print("Query Id is : $queryId");
                              print("TransferQuoteId is : $transferQuoteId");
                              print("Quation Id is : $quationId");

                              startTripDialog(context);
                            },
                            child: Container(
                              width: 120,
                              height: 40,
                              padding: EdgeInsets.only(top: 3.5, bottom: 3.5,),
                              decoration: BoxDecoration(
                                color: Colors.lightGreen,
                                border: Border.all(
                                  color: Colors.lightGreen,
                                  //                   <--- border color
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.only(left: 20,right: 0),
                              child: Center(
                                child: Text("Start Trip",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: 'BebesNeue',
                                        fontWeight: FontWeight.w700)),
                              ),),
                          ),
                        ),

                        Spacer(),

                        Visibility(
                          visible: isCompleteClickable,
                          child:InkWell(
                            onTap: () {
                              queryId=itemslists.queryId;
                              transferQuoteId=itemslists.transferQuotId;
                              quationId=itemslists.quotationId;

                              print("Query Id is : $queryId");
                              print("TransferQuoteId is : $transferQuoteId");
                              print("Quation Id is : $quationId");

                              endTripDialog(context);
                            },
                            child: Container(
                              width: 120,
                              height: 40,
                              padding: EdgeInsets.only(top: 3.5, bottom: 3.5),
                              decoration: BoxDecoration(
                                color: Colors.lightGreen,
                                border: Border.all(
                                  color: Colors.lightGreen,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.only(right: 20),
                              child: Center(
                                child: Text("Complete Trip",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: 'BebesNeue',
                                        fontWeight: FontWeight.w700)),
                              ),),
                          ),
                        ),

                      ],

                      ),

                      SizedBox(height: 10,),
                    ],


                  ),
                );
              }
          ),
        ],

      ),
    );

  }

  selectFromDateAccepted(BuildContext context,) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: fromselectedDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2025));

    if (picked != null && picked != fromselectedDate) {
      setState(() {
        fromtime = DateFormat('dd-MMM-yyyy').format(picked);
        print("from time prickers : " +fromtime );
        getAccepted();
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

  Future<List<StartTripBooking>> getStartTripBook() async {

    String newurl = AppNetworkConstants.STARTTRIP + "driverId=" +UserId!+ "&roleId=" +roleId!+ "&queryId=" +queryId!+ "&transferQuotId=" +transferQuoteId!+ "&quotationId=" +quationId!+"&startreading="+m_startcontroller.text.trim();

    print("START TRIP URL : "+newurl);

    var url = Uri.parse(newurl);


    http.Response res = await http.get(url);

    print("Start Trip Response : "+res.body);

    setState(() {
      getAccepted();
    });

    //  List datas= jsonDecode(res.body);

    var datas = jsonDecode(res.body)['results'] as List;


    List<StartTripBooking> starttripdata = datas.map((data) =>
        StartTripBooking.fromJson(data)).toList();

    String Message = starttripdata[0].message!;

    print("Trip Message is : $Message");

    Fluttertoast.showToast(
        msg:  Message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0
    );

    return starttripdata;
  }

  Future<List<AcceptBookingComplete>> getCompleteBook() async {

    String newurl = AppNetworkConstants.DELIVERBOKKING + "driverId=" +UserId!+ "&roleId=" +roleId!+ "&queryId=" +queryId!+ "&transferQuotId=" +transferQuoteId!+ "&quotationId=" +quationId!+ "&endReading=" +m_endcontroller.text.trim();

    print("Complete Book URL : "+newurl);

    var url = Uri.parse(newurl);


    http.Response res = await http.get(url);

    if(res.statusCode==200){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {return BottomNavComplete();}));
      print("Go to Complete UI");
    }else{
      Fluttertoast.showToast(
          msg: "Some Issues from Backend",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 12.0
      );
    }

    print("Complete Book Response : "+res.body);

   /* setState(() {
      getAccepted();
    });*/



    //  List datas= jsonDecode(res.body);

    var datas = jsonDecode(res.body)['acceptBooking'] as List;


    List<AcceptBookingComplete> completeBookdata = datas.map((data) =>
        AcceptBookingComplete.fromJson(data)).toList();

    String Message = completeBookdata[0].message!;

    print("Accept Message is : $Message");

    Fluttertoast.showToast(
        msg:  Message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0
    );

    return completeBookdata;
  }

  Future<List<AlertDetailsUpdate>> getUpdate() async {

    String newurl = AppNetworkConstants.ALERTUPDATE + "roleId=" + roleId!;

    print("Alert Update url is : "+newurl);

    var url = Uri.parse(newurl);

    http.Response res = await http.get(url);
    //  List datas= jsonDecode(res.body);

    print("Alert Update Response is : " +res.body);

    mainBottomNav.getNotificationfromHome();

    var datas = jsonDecode(res.body)['alertDetails'] as List;

    List<AlertDetailsUpdate> alertDetailsUpdate = datas.map((data) =>
        AlertDetailsUpdate.fromJson(data)).toList();

    return alertDetailsUpdate;
  }

  startTripDialog(BuildContext context){
    return showDialog(
        context: context,
        builder: (context){
          return  StatefulBuilder(
            builder: (context, setState) => AlertDialog(

              actions: [

                Column(children: [

                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left: 5,right: 5,top: 15),
                    child: Center(
                      child: Text("Enter Start Reading",
                          // textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'BebesNeue',
                            fontWeight: FontWeight.w700,)),
                    ),
                  ),

                  SizedBox(height: 15,),

                  Form(
                    key: formkey,
                    child: Column(
                      children: [

                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          margin: EdgeInsets.only(left: 5, right: 5),

                          child: TextFormField(
                            textAlign: TextAlign.center,
                            controller: m_startcontroller,
                            keyboardType: TextInputType.number,

                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                            //  hintText: "Please Enter Your Start Reading",

                            ),
                            validator: startValidate,
                          ),

                        ),


                      ],
                    ),
                  ),

                  Row(
                    children: [

                      Expanded(
                        child: InkWell(
                          onTap: (){
                            if (formkey.currentState!.validate()) {
                              print("OK");
                              getStartTripBook();
                              Navigator.of(context).pop(m_startcontroller);
                             /*if(starttrip=="1"){
                               Navigator.of(context).pop(m_startcontroller);
                                getCompleteClickable();
                              }else{
                                getCompleteNotClickable();
                                Navigator.of(context).pop(m_startcontroller);
                                print("its not working now ");
                              }*/

                            } else {

                              print("Error");
                            }

                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.lightGreen,
                              borderRadius: BorderRadius.circular(2.5),
                              //   border: Border.all(color: Colors.lightBlue,width: 1.0)
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text("Submit",
                                  style: TextStyle(color: Colors.white,
                                    fontSize: 13,
                                    fontFamily: 'BebesNeue',
                                    fontWeight: FontWeight.w700,)),
                            ),
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            margin: EdgeInsets.only(left: 30,top: 25, right: 20,bottom: 5),
                          ),
                        ),
                      ),

                      Expanded(
                        child: ChangeNotifierProvider(
                          create: (context)=>PickerAlert(),

                          child: Consumer<PickerAlert>(
                          builder: (context, provider, child){
                           return InkWell(
                                 onTap: (){
                              //  getCompleteNotClickable();
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
                  child: Text("Cancel",
                      style: TextStyle(color: Colors.white,
                        fontSize: 13,
                        fontFamily: 'BebesNeue',
                        fontWeight: FontWeight.w700,)),
                ),
                padding: EdgeInsets.only(top: 10, bottom: 10),
                margin: EdgeInsets.only(left: 20,top: 25, right: 30,bottom: 5),
              ),
            );
                         }
                          )
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

  endTripDialog(BuildContext context){
    return showDialog(
        context: context,
        builder: (context){
          return  StatefulBuilder(
            builder: (context, setState) => AlertDialog(

              actions: [

                Column(children: [

                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left: 5,right: 5,top: 15),
                    child: Center(
                      child: Text("Enter End Reading",
                          // textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'BebesNeue',
                            fontWeight: FontWeight.w700,)),
                    ),
                  ),

                  SizedBox(height: 15,),

                  Form(
                    key: formkey,
                    child: Column(
                      children: [

                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          margin: EdgeInsets.only(left: 5, right: 5),

                          child: TextFormField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            controller: m_endcontroller,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                            //  hintText: "Please Enter Your End Reading",

                            ),
                            validator: endValidate,
                          ),

                        ),
                      ],
                    ),
                  ),

                  Row(
                    children: [

                      Expanded(
                        child: InkWell(
                          onTap: (){
                            if (formkey.currentState!.validate()) {
                              print("OK");
                              getCompleteBook();
                              Navigator.of(context).pop(m_endcontroller);
                            } else {
                              print("Error");
                            }

                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.lightGreen,
                              borderRadius: BorderRadius.circular(2.5),
                              //   border: Border.all(color: Colors.lightBlue,width: 1.0)
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text("Submit",
                                  style: TextStyle(color: Colors.white,
                                    fontSize: 13,
                                    fontFamily: 'BebesNeue',
                                    fontWeight: FontWeight.w700,)),
                            ),
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            margin: EdgeInsets.only(left: 30,top: 25, right: 20,bottom: 5),
                          ),
                        ),
                      ),



                      Expanded(
                        child: InkWell(
                          onTap: (){
                            Navigator.of(context).pop();
                          //  getCompleteClickable();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xffd32f2f),
                              borderRadius: BorderRadius.circular(2.5),
                              //   border: Border.all(color: Colors.lightBlue,width: 1.0)
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text("Cancel",
                                  style: TextStyle(color: Colors.white,
                                    fontSize: 13,
                                    fontFamily: 'BebesNeue',
                                    fontWeight: FontWeight.w700,)),
                            ),
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            margin: EdgeInsets.only(left: 20,top: 25, right: 30,bottom: 5),
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
