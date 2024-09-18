import 'dart:async';
import 'dart:convert';


import 'package:driverapp/Dart/BottomNavHome.dart';
import 'package:driverapp/Dart/currentlocation.dart';
import 'package:driverapp/Dart/profile.dart';
import 'package:driverapp/Dart/voucherwv.dart';
import 'package:driverapp/Models/AcceptBookModel.dart';
import 'package:driverapp/Models/AcceptedListModel.dart';
import 'package:driverapp/Models/AssignListModel.dart';
import 'package:driverapp/Models/RejectBookModel.dart';
import 'package:driverapp/Models/RejectedListModel.dart';
import 'package:driverapp/Models/ToggleModel.dart';
import 'package:driverapp/Models/ToggleNotifyModel.dart';
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
import 'BottomNavAlert.dart';
import 'BottomNavComplete.dart';
import 'BottomNavList.dart';
import 'BottomNavPending.dart';
import 'package:http/http.dart' as http;
import 'login.dart';




class MyListSL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: MyList(),
    );
  }
}

class MyList extends StatefulWidget {

  @override
  State createState() => MyMyList();
}

class MyMyList extends State<MyList> {

 // late SharedPreferences preflog_in_out, prefprofile, prefId, prefRefid ;

  MainBottomNav mainBottomNav = new MainBottomNav();

  bool loadCircle = false;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

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

  var reasonup = "";
  var m_reasoncontroller = TextEditingController();

  String? reasonValidate(String? value) {
    if (value == null || value.isEmpty)
      return 'Please Enter Reason';
    else
      reasonup = value;
    print("Reason  is : " + reasonup);
    return null;
  }

  late SharedPreferences prefsotp, prefmobno, prefroleid, preflog_in_out,prefuserid,preffullname,prefstatus,prefrolename,prefstatusvar,
      prefnotification;

  String destination="";

  String? UserId="12";
  String? roleId="2";
  String? fullname="1";
  String? status="1";
  String? rolenamefirst="";
  String? rolenamesecond="";

  String? queryId="1";
  String? transferQuoteId="1";
  String? quationId="1";

  String? notifcation="";

  String? m_pickuptime="0";
  String? m_droptime="0";
  String? m_pickupaddress="0";
  String? m_dropaddress="0";
  String? m_servicetype="0";

  String? pickupAddress="0";
  String? dropAddress="0";
  String? breefsheeturl="0";

  String callassign="123456789";
  String callaccepted="123456789";
  String callrejected="123456789";

  bool isCall=true;
  bool isCallNot=false;

  List<NotificationsList>? notificatiomodel;

  bool isShow=false;
  bool isNotShow=true;

  DateTime fromselectedDate = DateTime.now();
  static String fromtime= DateFormat('dd-MMM-yyyy').format(DateTime.now());
  GlobalKey<ScaffoldState> _drawerkey= GlobalKey<ScaffoldState>();

  String select="Assigned";
  Color selectcolorassign= Colors.blue;
  Color selectcoloraccepted= Colors.transparent;
  Color selectcolorrejected= Colors.transparent;

  Color selectcolorassigntext= Colors.white;
  Color selectcoloracceptedtext= Color(0xff4155b8);
  Color selectcolorrejectedtext= Color(0xff4155b8);


  getSelectionColor(){
    if(select=="Assigned"){
     setState(() {
        selectcolorassign= Colors.blue;
        selectcoloraccepted= Colors.transparent;
        selectcolorrejected= Colors.transparent;

        selectcolorassigntext= Colors.white;
        selectcoloracceptedtext= Color(0xff4155b8);
        selectcolorrejectedtext= Color(0xff4155b8);
     });
    }else if(select=="Accepted"){
      setState(() {
        selectcolorassign= Colors.transparent;
        selectcoloraccepted= Colors.lightGreen;
        selectcolorrejected= Colors.transparent;

        selectcolorassigntext= Color(0xff4155b8);
        selectcoloracceptedtext= Colors.white;
        selectcolorrejectedtext= Color(0xff4155b8);
      });
    }
    else{
      setState(() {
        selectcolorassign= Colors.transparent;
        selectcoloraccepted= Colors.transparent;
        selectcolorrejected= Color(0xffd32f2f);

        selectcolorassigntext= Color(0xff4155b8);
        selectcoloracceptedtext= Color(0xff4155b8);
        selectcolorrejectedtext= Colors.white;
      });
    }
  }

  getDataHide(){
    if(m_pickuptime==null){
      m_pickuptime="1";
      print("pickup time is : $m_pickuptime");

    }else if(m_droptime==null){
      m_droptime="1";

    }else if(m_pickupaddress==null){
      m_pickupaddress="1";
    }else if(m_dropaddress==null){
      m_dropaddress="1";
    }else if(m_servicetype==null) {
      m_servicetype = "1";
    }
  }

  bool isAssignedClicked=true;
  bool isAccepteddClicked=false;
  bool isRejectedClicked=false;

  bool isDateAssignedClicked=true;
  bool isDateAccepteddClicked=false;
  bool isDateRejectedClicked=false;

  getDateAssignedClick(){
    setState(() {
      isDateAssignedClicked=true;
      isDateAccepteddClicked=false;
      isDateRejectedClicked=false;
    });
  }

  getDateAcceptedClick(){
    setState(() {
      isDateAssignedClicked=false;
      isDateAccepteddClicked=true;
      isDateRejectedClicked=false;
    });
  }

  getDateRejectedClick(){
    setState(() {
      isDateAssignedClicked=false;
      isDateAccepteddClicked=false;
      isDateRejectedClicked=true;
    });
  }

   getAssignedClick(){
     setState(() {
       isAssignedClicked=true;
       isAccepteddClicked=false;
       isRejectedClicked=false;
     });
   }

  getAcceptedClick(){
     setState(() {
       isAssignedClicked=false;
       isAccepteddClicked=true;
       isRejectedClicked=false;
     });
  }

  getRejectedClick(){
     setState(() {
       isAssignedClicked=false;
       isAccepteddClicked=false;
       isRejectedClicked=true;
     });
  }

  List<PendingAssignList>? pendingassignmodel;

  List<PendingAcceptedList>? pendingacceptedmodel;

  List<PendingRejectedList>? pendingrejectedmodel;

  @override
  void initState() {
    super.initState();
    getUpdate();
    getSelectionColor();
    getPref();
    getToogleNotify();
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

      /*notifcation = prefnotification.getString("count");
      print("my Recieved  Count is : $notifcation");*/

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
                   // width: 1.0,
                  ),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
                ),
                child: Column(children: [

                  Container(
                    margin:EdgeInsets.only(top: 20,right: 0,left: 15),
                    child: Row(children: [

                      InkWell(
                        onTap: (){
                          select="Assigned";
                          getSelectionColor();
                          getDateAssignedClick();
                          getAssignedClick();
                          getAssign();
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 10,top: 10, bottom: 12.5,right: 10),
                          decoration: BoxDecoration(
                            color: selectcolorassign,
                            border: Border.all(
                              color: selectcolorassign,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                          ),
                          child: Center(
                            child: Text("Assigned", style: TextStyle(color: selectcolorassigntext, fontSize: 16, fontFamily: 'BebesNeue',
                                fontWeight: FontWeight.w700),),
                          ),
                        ),
                      ),

                      Spacer(),

                      InkWell(
                        onTap: (){
                          select="Accepted";
                          getSelectionColor();
                          getDateAcceptedClick();
                          getAcceptedClick();
                          getAccepted();
                        },
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.only(left: 10,top: 10, bottom: 12.5,right: 10),
                            decoration: BoxDecoration(
                              color: selectcoloraccepted,
                              border: Border.all(
                                color: selectcoloraccepted,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                            ),

                            child: Center(
                              child: Text("Accepted", style: TextStyle(color: selectcoloracceptedtext, fontSize: 16, fontFamily: 'BebesNeue',
                                  fontWeight: FontWeight.w700),),
                            ),
                          ),
                        ),
                      ),

                      Spacer(),

                      InkWell(
                        onTap: (){
                          select="Rejected";
                          getSelectionColor();
                          getDateRejectedClick();
                          getRejectedClick();
                          getRejected();
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 15),
                          padding: EdgeInsets.only(left: 10,top: 10, bottom: 12.5,right: 10),
                          decoration: BoxDecoration(
                            color: selectcolorrejected,
                            border: Border.all(
                              color: selectcolorrejected,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                          ),
                          child: Center(
                            child: Text("Rejected", style: TextStyle(color: selectcolorrejectedtext, fontSize: 16, fontFamily: 'BebesNeue',
                                fontWeight: FontWeight.w700),),
                          ),
                        ),
                      ),

                    ],),
                  ),

                  SizedBox(height: 10,),

                  Container(
                    margin: EdgeInsets.only(left: 5,right: 5),
                    width: MediaQuery.of(context).size.width,
                    height: 4,
                    color: Colors.indigo,
                  ),

                  SizedBox(height: 15,),

                  Visibility(
                    visible: isDateAssignedClicked,
                    child:  Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight:Radius.circular(30),),
                      ),

                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 12.5,bottom: 12.5),
                      margin: EdgeInsets.only(top: 20,left: 15,right: 15),


                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              selectFromDateAssign(context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 5,left: 0),
                              child: Text("Date : "+fromtime,
                                  style: TextStyle(color: Colors.white,fontSize: 13,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                            ),
                          ),
                        ],
                      ),



                    ),
                  ),

                  Visibility(
                    visible: isDateAccepteddClicked,
                    child: Container(
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
                  ),

                  Visibility(
                    visible: isDateRejectedClicked,
                    child: Container(
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
                                selectFromDateRejected(context);
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
                  ),

                  Visibility(
                    visible: isAssignedClicked,
                    child: FutureBuilder(
                        future: getAssign(),
                        builder:(context, snapshot) {

                          if(snapshot.hasData) {
                             pendingassignmodel= snapshot.data as List<PendingAssignList>;

                             if(pendingassignmodel!.length==0) {
                               Fluttertoast.showToast(
                                   msg: "No Assigned Duty",
                                   toastLength: Toast.LENGTH_SHORT,
                                   gravity: ToastGravity.BOTTOM,
                                   timeInSecForIosWeb: 3,
                                   backgroundColor: Colors.black,
                                   textColor: Colors.white,
                                   fontSize: 12.0
                               );
                             }

                            return getBodyWidgetAssign();

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
                  ),

                  Visibility(
                    visible: isAccepteddClicked,
                    child: FutureBuilder(
                        future: getAccepted(),
                        builder:(context, snapshot) {

                          if(snapshot.hasData) {
                            pendingacceptedmodel= snapshot.data as List<PendingAcceptedList>;

                            if(pendingacceptedmodel!.length==0) {
                              Fluttertoast.showToast(
                                  msg: "No Accepted Duty",
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
                  ),

                  Visibility(
                    visible: isRejectedClicked,
                    child: FutureBuilder(
                        future: getRejected(),
                        builder:(context, snapshot) {

                          if(snapshot.hasData) {
                            pendingrejectedmodel= snapshot.data as List<PendingRejectedList>;

                            if(pendingrejectedmodel!.length==0) {
                              Fluttertoast.showToast(
                                  msg: "No Rejected Duty",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 12.0
                              );
                            }

                            return getBodyWidgetRejected();

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
                  ),

                ]),
              ),
            )

          ]),

        ),
      ),
    );
  }


  Widget  getBodyWidgetAssign() {

    return Expanded(
      child: Stack(
        clipBehavior: Clip.none,
        children: [


          ListView.builder(
              padding: EdgeInsets.only(top: 5,bottom: 5),
              itemCount: pendingassignmodel!.length,
              itemBuilder: (context,index){
                PendingAssignList itemslists = pendingassignmodel![index];

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
                                border: Border.all(color: Colors.lightBlue,width: 1),
                                borderRadius: BorderRadius.only(topLeft:Radius.circular(2.5),topRight:Radius.circular(2.5),
                                  bottomLeft:Radius.circular(2.5),bottomRight:Radius.circular(2.5),), ),
                              margin: EdgeInsets.only(left: 6),
                              child:  Text(itemslists.guest!,
                                maxLines: 1,
                                style: TextStyle(color: Colors.lightBlue,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
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
                                style: TextStyle(color: Colors.lightBlue,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                            ),


                            Container(
                              margin: EdgeInsets.only(left: 6),
                              child:  Text(itemslists.guestname!,
                                maxLines: 1,
                                style: TextStyle(color: Colors.lightBlue,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
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
                                style: TextStyle(color: Colors.lightBlue,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                            ),


                            Column(
                              children:[

                                Visibility(
                                  visible: isCall,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child:  Text("+91"+itemslists.guestphone!,
                                      maxLines: 1,
                                      style: TextStyle(color: Colors.lightBlue,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
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
                                      callassign="+91"+itemslists.guestphone.toString();
                                      print("Callasign is : $callassign");
                                      _makingPhoneCallAssign();
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 20),
                                      child:  Image.asset("image/calllaticon.png", width: 27.5, height: 30,),
                                    ),
                                  ),

                                  InkWell(
                                    onTap:(){
                                      // whatsappnumber="+91-9910924485";
                                      callassign="+91"+itemslists.guestphone.toString();
                                      print("Callasign whats app is : $callassign");
                                      _makingWhatsappAssign();
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

                      /* // drop address
                      Row(
                          children: [

                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child:  Text("Drop Address : ",
                                style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                            ),


                            Container(
                              width: 160,
                              margin: EdgeInsets.only(left: 5),
                              child:  Text(itemslists.dropAddress!,
                                maxLines: 1,
                                style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,),
                            ),


                            Spacer(),

                            InkWell(
                              onTap: (){
                                dropAddress=itemslists.dropAddress!;
                                print("send Address is : $dropAddress");

                                if(dropAddress==""){
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
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CurrentLocation(newaddress: dropAddress!)));
                                  print("is pressed");
                                }

                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 10),
                                child:  Image.asset("image/location.png", width: 20, height: 20,),
                              ),
                            ),

                          ]
                      ),*/

                      // buttons

                      Row(
                          children: [

                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  queryId=itemslists.queryId;
                                  transferQuoteId=itemslists.transferQuotId;
                                  quationId=itemslists.quotationId;

                                  print("Quation Id is : $quationId");
                                  print("Query Id is : $queryId");
                                  print("TransferQuoteId is : $transferQuoteId");

                                  acceptDialog(context);
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
                                  margin: EdgeInsets.only(left: 35,right: 35),
                                  child: Center(
                                    child: Text("Accept",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontFamily: 'BebesNeue',
                                            fontWeight: FontWeight.w700)),
                                  ),),
                              ),
                            ),

                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  queryId=itemslists.queryId;
                                  transferQuoteId=itemslists.transferQuotId;
                                  quationId=itemslists.quotationId;

                                  print("Quation Id is : $quationId");
                                  print("Query Id is : $queryId");
                                  print("TransferQuoteId is : $transferQuoteId");
                                  rejectDialog(context);
                                },
                                child: Container(
                                  height: 40,
                                  padding: EdgeInsets.only(top: 3.5, bottom: 3.5),
                                  decoration: BoxDecoration(
                                    color: Color(0xffd32f2f),
                                    border: Border.all(
                                      color: Color(0xffd32f2f),
                                      //                   <--- border color
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  margin: EdgeInsets.only(left:35,right: 35),
                                  child: Center(
                                    child: Text("Reject",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontFamily: 'BebesNeue',
                                            fontWeight: FontWeight.w700)),
                                  ),),
                              ),
                            ),


                          ]
                      ),

                      SizedBox(height: 15,),
                    ],


                  ),
                );
              }
          ),
        ],
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

                /* m_pickuptime=itemslists.pickupTime;
                m_droptime=itemslists.dropTime;
                m_pickupaddress=itemslists.pickupAddress;
                m_dropaddress=itemslists.dropAddress;
                m_servicetype=itemslists.serviceType;*/

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

                      Row(children: [

                        InkWell(
                          onTap: (){
                            breefsheeturl=itemslists.url!;
                            print("send BreefSheet is : $breefsheeturl");
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Voucherwv(pdf: breefsheeturl!,)));
                            print("is pressed");
                          },
                          child: Container(
                            height: 35,
                            width: 120,
                            padding: EdgeInsets.only(top: 3.5, bottom: 3.5),
                            decoration: BoxDecoration(
                              color: Colors.lightGreen,
                              border: Border.all(
                                color: Colors.lightGreen,
                                //                   <--- border color
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(2.5),
                            ),
                            margin: EdgeInsets.only(left: 15),
                            child: Center(
                              child: Text("Breefing Sheet",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: 'BebesNeue',
                                      fontWeight: FontWeight.w700)),
                            ),),
                        ),
                      ],

                      ),

                      SizedBox(height: 15,),
                    ],


                  ),
                );
              }
          ),
        ],

      ),
    );

  }

  Widget  getBodyWidgetRejected() {

    return Expanded(
      child: Stack(
        clipBehavior: Clip.none,
        children: [

         /* FutureBuilder(
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

                    top: -215.5,
                    right: 5,
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
              padding: EdgeInsets.only(top: 5,bottom: 5),
              itemCount: pendingrejectedmodel!.length,
              itemBuilder: (context,index){
                PendingRejectedList itemslists = pendingrejectedmodel![index];

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
                                border: Border.all(color: Colors.red,width: 1),
                                borderRadius: BorderRadius.only(topLeft:Radius.circular(2.5),topRight:Radius.circular(2.5),
                                  bottomLeft:Radius.circular(2.5),bottomRight:Radius.circular(2.5),), ),
                              margin: EdgeInsets.only(left: 6),
                              child:  Text(itemslists.guest!,
                                maxLines: 1,
                                style: TextStyle(color: Colors.red,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
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
                                style: TextStyle(color: Colors.red,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                            ),


                            Container(
                              margin: EdgeInsets.only(left: 6),
                              child:  Text(itemslists.guestname!,
                                maxLines: 1,
                                style: TextStyle(color: Colors.red,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
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
                                style: TextStyle(color: Colors.red,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                            ),


                            Column(
                              children:[

                                Visibility(
                                  visible: isCall,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child:  Text("+91"+itemslists.guestphone!,
                                      maxLines: 1,
                                      style: TextStyle(color: Colors.red,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                                  ),
                                ),

                                Visibility(
                                  visible:isCallNot,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child:  Text("",
                                      maxLines: 1,
                                      style: TextStyle(color:Colors.red,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
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
                                      callrejected="+91"+itemslists.guestphone.toString();
                                      print("Callrejected is : $callrejected");
                                      _makingPhoneCallRejected();
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 20),
                                      child:  Image.asset("image/calllaticon.png", width: 27.5, height: 30,),
                                    ),
                                  ),

                                  InkWell(
                                    onTap:(){
                                      // whatsappnumber="+91-9910924485";
                                      callrejected="+91"+itemslists.guestphone.toString();
                                      print("Callrejected whats app is : $callrejected");
                                      _makingWhatsappRejected();
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

  Future<List<PendingAssignList>> getAssign() async {

   /* setState(() {
      loadCircle = true;
    });*/

    String newurl = AppNetworkConstants.MYLIST+ "driverId="+ UserId! +"&roleId="+roleId!+"&startDate="+fromtime;

    print("Assign url is : " + newurl);

    var url = Uri.parse(newurl);

    http.Response res = await http.get(url);

    print("Notification from assign MyList");

    mainBottomNav.getNotificationfromHome();

    var datas = jsonDecode(res.body)['pending'] as List;


    /*setState(() {
      loadCircle = false;
    });*/

    List<PendingAssignList> pendingAssignData = datas.map((data) =>
        PendingAssignList.fromJson(data)).toList();

   /* if(pendingAssignData.length==0) {
      Fluttertoast.showToast(
          msg: "No Duty For Today",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 12.0
      );
    }*/




    return pendingAssignData;
  }

  Future<List<PendingAcceptedList>> getAccepted() async {

    String newurl = AppNetworkConstants.ACCEPTEDORDER+ "driverId="+ UserId! +"&roleId="+roleId!+"&startDate="+fromtime;

    print("Accepted url is : " + newurl);

    var url = Uri.parse(newurl);


    http.Response res = await http.get(url);

    print("Notification from accepted MyList");

    mainBottomNav.getNotificationfromHome();

    //  List datas= jsonDecode(res.body);

    var datas = jsonDecode(res.body)['pending'] as List;

    /*setState(() {
      loadCircle = false;
    });*/

    List<PendingAcceptedList> pendingAcceptedData = datas.map((data) =>
        PendingAcceptedList.fromJson(data)).toList();

  //  getDataHide();

    return pendingAcceptedData;
  }

  Future<List<PendingRejectedList>> getRejected() async {

    String newurl = AppNetworkConstants.REJECTEDORDER+ "driverId="+ UserId! +"&roleId="+roleId!+"&startDate="+fromtime;

    print("Rejected url is : " + newurl);

    var url = Uri.parse(newurl);

    http.Response res = await http.get(url);

    print("Notification from Rejected MyList");
    mainBottomNav.getNotificationfromHome();

    //  List datas= jsonDecode(res.body);

    var datas = jsonDecode(res.body)['pending'] as List;


    List<PendingRejectedList> pendingRejectedData = datas.map((data) =>
        PendingRejectedList.fromJson(data)).toList();


    return pendingRejectedData;
  }

  selectFromDateAssign(BuildContext context,) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: fromselectedDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2025));

    if (picked != null && picked != fromselectedDate) {
      setState(() {
        fromtime = DateFormat('dd-MM-yyyy').format(picked);
        print("from time prickers : " +fromtime );
        getAssign();
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

  selectFromDateRejected(BuildContext context,) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: fromselectedDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2025));

    if (picked != null && picked != fromselectedDate) {
      setState(() {
        fromtime = DateFormat('dd-MMM-yyyy').format(picked);
        print("from time prickers : " +fromtime );
        getRejected();
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

  _makingPhoneCallAssign() async {
    String url = 'tel:'+callassign;
    if (await launch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
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

  _makingPhoneCallRejected() async {
    String url = 'tel:'+callrejected;
    if (await launch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _makingWhatsappAssign() async {
    // String url = '+919910910910';

    //  await launch('https://wa.me/$url?text=Welcome');

    String url = "91"+callassign;

    await launch("whatsapp://send?phone="+url+"&text=hello");
  }

  _makingWhatsappAccepted() async {
    // String url = '+919910910910';

    //  await launch('https://wa.me/$url?text=Welcome');

    String url = "91"+callaccepted;

    await launch("whatsapp://send?phone="+url+"&text=hello");
  }

  _makingWhatsappRejected() async {
    // String url = '+919910910910';

    //  await launch('https://wa.me/$url?text=Welcome');

    String url = "91"+callrejected;

    await launch("whatsapp://send?phone="+url+"&text=hello");
  }

  void validate() {
    if (formkey.currentState!.validate()) {
      print("OK");
    //  Navigator.of(context).pop(m_reasoncontroller.text);
     // getLogin();

    } else {
      print("Error");
    }
  }

  Future<List<AcceptBookingAccept>> getAcceptBook() async {

    String newurl = AppNetworkConstants.ACCEPTORDER + "driverId=" +UserId!+ "&roleId=" +roleId!+ "&queryId=" +queryId!+ "&transferQuotId=" +transferQuoteId!+ "&quotationId=" +quationId!;

    print("Accept Book URL : "+newurl);

    var url = Uri.parse(newurl);


    http.Response res = await http.get(url);

     if(res.statusCode==200){
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {return BottomNavPending();}));
       print("Go to Pending UI");
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
     print("Accept Book Response : "+res.body);

    /*setState(() {
      getAssign();
    });*/

    //  List datas= jsonDecode(res.body);

    var datas = jsonDecode(res.body)['acceptBooking'] as List;


    List<AcceptBookingAccept> acceptBookdata = datas.map((data) =>
        AcceptBookingAccept.fromJson(data)).toList();

    String Message = acceptBookdata[0].message!;

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

    return acceptBookdata;
  }

  Future<List<RejectBookingReject>> getRejectBook() async {

    String newurl = AppNetworkConstants.REJECTORDER + "driverId=" +UserId!+ "&roleId=" +roleId!+ "&queryId=" +queryId!+ "&transferQuotId=" +transferQuoteId!+ "&quotationId=" +quationId! + "&rejectReason=" +m_reasoncontroller.text.trim();

    print("Reject Book URL : "+newurl);

    var res = await http.post(Uri.parse(newurl),
        body: ({'rejectReason': m_reasoncontroller.text.trim()})
    );

    print("Reject Book Response : "+res.body);

    setState(() {
      getAssign();
    });


    //  List datas= jsonDecode(res.body);

    var datas = jsonDecode(res.body)['rejectBooking'] as List;


    List<RejectBookingReject> rejectBookdata = datas.map((data) =>
        RejectBookingReject.fromJson(data)).toList();

    String Message = rejectBookdata[0].message!;

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

    return rejectBookdata;
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


  acceptDialog(BuildContext context){
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
                      child: Text("Are You Sure You Want to Accept ?",
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
                            getAcceptBook();
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

  rejectDialog(BuildContext context){
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
                      child: Text("Enter Cancellation Reason",
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
                            controller: m_reasoncontroller,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                            //  hintText: "Please Enter Your Reason",

                            ),
                            validator: reasonValidate,
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

                              getRejectBook();

                              Navigator.of(context).pop(m_reasoncontroller);
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
