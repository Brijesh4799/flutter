import 'dart:async';
import 'dart:convert';


import 'package:driverapp/Dart/BottomNavHome.dart';
import 'package:driverapp/Dart/currentlocation.dart';
import 'package:driverapp/Dart/pendingduties.dart';
import 'package:driverapp/Dart/profile.dart';
import 'package:driverapp/Dart/voucherwv.dart';
import 'package:driverapp/Models/AcceptBookModel.dart';
import 'package:driverapp/Models/AcceptedListModel.dart';
import 'package:driverapp/Models/AssignListModel.dart';
import 'package:driverapp/Models/RejectBookModel.dart';
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
import 'home.dart';
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

  bool loadCircle = false;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  var reasonup = "";
  var m_reasoncontroller = TextEditingController();

  String? reasonValidate(String? value) {
    if (value == null || value.isEmpty)
      return 'Enter Cancellation Reason';
    else
      reasonup = value;
    print("Reason  is : " + reasonup);
    return null;
  }

  late SharedPreferences prefsotp, prefmobno, prefroleid, preflog_in_out,prefuserid,preffullname,prefstatus,prefrolename,
      prefnotification;

  String? UserId="45";
  String? roleId="3";
  String? fullname="1";
  String? status="1";
  String? rolenamefirst="";
  String? rolenamesecond="";
  String destination="";

  String? queryId="1";
  String? transferQuoteId="1";
  String? quationId="1";

  String? m_pickuptime="0";
  String? m_droptime="0";
  String? m_pickupaddress="0";
  String? m_dropaddress="0";
  String? m_servicetype="0";

  String? pickupAddress="0";
  String? dropAddress="0";
  String? breefsheeturl="0";

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

  String callassign="123456789";
  String callaccepted="123456789";
  String callrejected="123456789";

  bool isCall=true;
  bool isCallNot=false;

  DateTime fromselectedDate = DateTime.now();
  static String fromtime= DateFormat('dd-MMM-yyyy').format(DateTime.now());
  GlobalKey<ScaffoldState> _drawerkey= GlobalKey<ScaffoldState>();

  String select="Assigned";
  Color selectcolorassign= Colors.orange;
  Color selectcoloraccepted= Colors.transparent;
  Color selectcolorrejected= Colors.transparent;

  getSelectionColor(){
    if(select=="Assigned"){
     setState(() {
        selectcolorassign= Colors.orange;
        selectcoloraccepted= Colors.transparent;
        selectcolorrejected= Colors.transparent;
     });
    }else if(select=="Accepted"){
      setState(() {
        selectcolorassign= Colors.transparent;
        selectcoloraccepted= Colors.orange;
        selectcolorrejected= Colors.transparent;
      });
    }
    else{
      setState(() {
        selectcolorassign= Colors.transparent;
        selectcoloraccepted= Colors.transparent;
        selectcolorrejected= Colors.orange;
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

  List<PendingReport>? pendingacceptedmodel;

  List<PendingRejectedList>? pendingrejectedmodel;

  @override
  void initState() {
    super.initState();
    getUpdate();
    getSelectionColor();
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
      UserId = prefuserid.getString("userid")!;
      print("my Recieved OTP is : $UserId");

      roleId = prefroleid.getString("roleid")!;
      print("my Recieved Role Id in Home is : $roleId");

      fullname = preffullname.getString("fullname");
      print("my Recieved  Full Name is : $fullname");

      status = prefstatus.getString("status");
      print("my Recieved  Status is : $status");

     /* notifcation = prefnotification.getString("count");
      print("my Recieved  Count is : $notifcation");*/

      if(fullname==null){
        fullname="User Name";
      }

      //getChangedName();

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
                    child: Row(children: [

                      Expanded(
                        child: InkWell(
                          onTap: (){
                            select="Assigned";
                            getSelectionColor();
                            getDateAssignedClick();
                            getAssignedClick();
                            getAssign();
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 5),
                            padding: EdgeInsets.only(top: 10, bottom: 12.5,),
                            decoration: BoxDecoration(
                              color: selectcolorassign,
                              border: Border.all(
                                color: selectcolorassign,
                                //                   <--- border color
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                            ),
                                child: Center(
                                  child: Text("ASSIGNED", style: TextStyle(color: Colors.black54, fontSize: 15, fontFamily: 'BebesNeue',
                                      fontWeight: FontWeight.w700),),
                                ),
                          ),
                        ),
                      ),


                      Expanded(
                        child: InkWell(
                          onTap: (){
                            select="Accepted";
                            getSelectionColor();
                            getDateAcceptedClick();
                            getAcceptedClick();
                            getAccepted();
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 5,left: 5),
                            padding: EdgeInsets.only(top: 10, bottom: 12.5),
                            decoration: BoxDecoration(
                              color: selectcoloraccepted,
                              border: Border.all(
                                color: selectcoloraccepted,
                                //                   <--- border color
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                            ),
                            child: Center(child:Text("ACCEPTED", style: TextStyle(color: Colors.black54, fontSize: 15, fontFamily: 'BebesNeue',
                                fontWeight: FontWeight.w700),),),
                          ),
                        ),
                      ),



                      Expanded(
                        child: InkWell(
                          onTap: (){
                            select="Rejected";
                            getSelectionColor();
                            getDateRejectedClick();
                            getRejectedClick();
                            getRejected();
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 5),
                            padding: EdgeInsets.only(top: 10, bottom: 12.5),
                            decoration: BoxDecoration(
                              color: selectcolorrejected,
                              border: Border.all(
                                color: selectcolorrejected,
                                //                   <--- border color
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                            ),
                            child: Center(
                              child: Text("REJECTED", style: TextStyle(color: Colors.black54, fontSize: 15, fontFamily: 'BebesNeue',
                                  fontWeight: FontWeight.w700),),
                            ),
                          ),
                        ),
                      ),

                    ],),
                  ),

                  Visibility(
                    visible: isDateAssignedClicked,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft:Radius.circular(17.5),topRight:Radius.circular(17.5),),
                      ),

                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 12.5,bottom: 12.5),
                      margin: EdgeInsets.only(top: 0,left: 15,right: 15,),


                      child: InkWell(
                        onTap: (){
                          selectFromDateAssign(context);
                        },
                        child: Container(
                          child: Center(
                            child: Text(fromtime,
                                style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                          ),
                        ),
                      ),

                    ),
                  ),

                  Visibility(
                    visible: isDateAccepteddClicked,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft:Radius.circular(17.5),topRight:Radius.circular(17.5),),
                      ),

                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 12.5,bottom: 12.5),
                      margin: EdgeInsets.only(top: 0,left: 15,right: 15),


                      child: InkWell(
                        onTap: (){
                          selectFromDateAccepted(context);
                        },
                        child: Container(
                          child: Center(
                            child: Text(fromtime,
                                style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                          ),
                        ),
                      ),

                    ),
                  ),

                  Visibility(
                    visible: isDateRejectedClicked,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft:Radius.circular(17.5),topRight:Radius.circular(17.5),),
                      ),

                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 12.5,bottom: 12.5),
                      margin: EdgeInsets.only(top: 0,left: 15,right: 15),


                      child: InkWell(
                        onTap: (){
                          selectFromDateRejected(context);
                        },
                        child: Container(
                          child: Center(
                            child: Text(fromtime,
                                style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                          ),
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

                  Visibility(
                    visible: isAssignedClicked,
                    child: FutureBuilder(
                        future: getAssign(),
                        builder:(context, snapshot) {

                          if(snapshot.hasData) {
                             pendingassignmodel= snapshot.data as List<PendingAssignList>;

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
                            pendingacceptedmodel= snapshot.data as List<PendingReport>;

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
      child: ListView.builder(
          padding: EdgeInsets.only(top: 0,bottom: 5),
          itemCount: pendingassignmodel!.length,
          itemBuilder: (context,index){
            PendingAssignList itemslists = pendingassignmodel![index];


           /* if (itemslists.destination!.length > 0) {
              destination = itemslists.destination!.substring(
                  0, itemslists.destination!.length - 2);
            }else{
              destination="";
            }*/

            if(itemslists.guestphone.toString()==""){
              isCallNot=false;
            }else{
              isCall=true;
            }

            /* queryId=itemslists.queryId;
                    transferQuoteId=itemslists.transferQuotId;
                    quationId=itemslists.quotationId;


                    print("Quation Id is : $quationId");
                    print("Query Id is : $queryId");
                    print("TransferQuoteId is : $transferQuoteId");*/


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

                       /* Spacer(),

                        Container(
                          margin: EdgeInsets.only(left: 0),
                          child:  Text("Activity Time : ",
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
                              height: 36,
                              padding: EdgeInsets.only(top: 3,left: 9,right: 9, bottom: 3),
                              decoration: BoxDecoration(
                                color: Colors.lightBlueAccent,
                                border: Border.all(
                                  color: Colors.lightBlueAccent,
                                  //                   <--- border color
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              margin: EdgeInsets.only(left: 25,right: 25),
                              child: Center(
                                child: Text("ACCEPT",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
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
                              height: 36,
                              padding: EdgeInsets.only(top: 3,left: 9,right: 9, bottom: 3),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                  color: Colors.black54,
                                  //                   <--- border color
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              margin: EdgeInsets.only(left:25,right: 25),
                              child: Center(
                                child: Text("REJECT",
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 12,
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
    );

  }

  Widget  getBodyWidgetAccepted() {

    return Expanded(

      child: ListView.builder(
          padding: EdgeInsets.only(top: 5,bottom: 5),
          itemCount: pendingacceptedmodel!.length,
          itemBuilder: (context,index){
            PendingReport itemslists = pendingacceptedmodel![index];

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
                          child:  Text("Activity Time : ",
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
                                  callaccepted="+91"+itemslists.guestphone.toString();
                                  print("callaccepted is : $callaccepted");
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
                                  print("callaccepted whats app is : $callaccepted");
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

                  Row(children: [

                    InkWell(
                      onTap: (){
                        breefsheeturl=itemslists.url!;
                        print("send BreefSheet is : $breefsheeturl");
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Voucherwv(pdf: breefsheeturl!,)));
                        print("is pressed");
                      },
                      child: Container(
                        height: 37.5,
                        width: 140,
                        padding: EdgeInsets.only(top: 3.5, bottom: 3.5),
                        decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          border: Border.all(
                            color: Colors.lightBlueAccent,
                            //                   <--- border color
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        margin: EdgeInsets.only(left: 15),
                        child: Center(
                          child: Text("BREEFING SHEET",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
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
    );

  }

  Widget  getBodyWidgetRejected() {

    return Expanded(
      child:  ListView.builder(
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

                       /* Spacer(),

                        Container(
                          margin: EdgeInsets.only(left: 0),
                          child:  Text("Activity Time : ",
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
                                  callrejected="+91"+itemslists.guestphone.toString();
                                  print("callrejected is : $callrejected");
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
                                  print("callrejected whats app is : $callrejected");
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

  Future<List<PendingAssignList>> getAssign() async {

   /* setState(() {
      loadCircle = true;
    });*/

    String newurl = AppNetworkConstants.MYLIST+ "driverId="+ UserId! +"&roleId="+roleId!+"&startDate="+fromtime;

    print("Assign url is : " + newurl);

    var url = Uri.parse(newurl);

    http.Response res = await http.get(url);

    var datas = jsonDecode(res.body)['pending'] as List;

    List<PendingAssignList> pendingAssignData = datas.map((data) =>
        PendingAssignList.fromJson(data)).toList();


    return pendingAssignData;
  }

  Future<List<PendingReport>> getAccepted() async {

    /* setState(() {
      loadCircle = true;
    });*/

    String newurl = AppNetworkConstants.ACCEPTEDORDER+ "driverId="+ UserId! +"&roleId="+roleId!+"&startDate="+fromtime;

    print("Accepted url is : " + newurl);

    var url = Uri.parse(newurl);


    http.Response res = await http.get(url);

    //  List datas= jsonDecode(res.body);

    var datas = jsonDecode(res.body)['pending'] as List;

    List<PendingReport> pendingAcceptedData = datas.map((data) =>
        PendingReport.fromJson(data)).toList();

  //  getDataHide();

    return pendingAcceptedData;
  }

  Future<List<PendingRejectedList>> getRejected() async {

    /* setState(() {
      loadCircle = true;
    });*/

    String newurl = AppNetworkConstants.REJECTEDORDER+ "driverId="+ UserId! +"&roleId="+roleId!+"&startDate="+fromtime;

    print("Rejected url is : " + newurl);

    var url = Uri.parse(newurl);

    http.Response res = await http.get(url);

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
        fromtime = DateFormat('dd-MMM-yyyy').format(picked);
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
    String url = 'tel:'+callassign!;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _makingPhoneCallAccepted() async {
    String url = 'tel:'+callaccepted!;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _makingPhoneCallRejected() async {
    String url = 'tel:'+callrejected!;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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

   /* setState(() {
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
                      child: Text("Are you sure want to accept ?",
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
                            setState(() {
                            });
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.lightBlueAccent,
                              borderRadius: BorderRadius.circular(5),
                                 border: Border.all(color: Colors.lightBlueAccent,width: 1.0)
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text("YES",
                                  style: TextStyle(color: Colors.white,
                                    fontSize: 13,
                                    fontFamily: 'BebesNeue',
                                    fontWeight: FontWeight.w700,)),
                            ),
                            padding: EdgeInsets.only(top: 6.5, bottom: 6.5),
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
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),

                                 border: Border.all(color: Colors.black54,width: 1.0)
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text("NO",
                                  style: TextStyle(color: Colors.black54,
                                    fontSize: 13,
                                    fontFamily: 'BebesNeue',
                                    fontWeight: FontWeight.w700,)),
                            ),
                            padding: EdgeInsets.only(top: 6.5, bottom: 6.5),
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
                              hintText: "Enter Cancellation Reason",

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
                              setState(() {
                              });

                              Navigator.of(context).pop(m_reasoncontroller);
                            } else {
                              print("Error");
                            }

                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.lightBlueAccent,
                              borderRadius: BorderRadius.circular(5),
                                 border: Border.all(color: Colors.lightBlueAccent,width: 1.0)
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text("SUBMIT",
                                  style: TextStyle(color: Colors.white,
                                    fontSize: 13,
                                    fontFamily: 'BebesNeue',
                                    fontWeight: FontWeight.w700,)),
                            ),
                            padding: EdgeInsets.only(top: 6.5, bottom: 6.5),
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
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                                 border: Border.all(color: Colors.black54,width: 1.0)
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text("CANCEL",
                                  style: TextStyle(color: Colors.black54,
                                    fontSize: 13,
                                    fontFamily: 'BebesNeue',
                                    fontWeight: FontWeight.w700,)),
                            ),
                            padding: EdgeInsets.only(top: 6.5, bottom: 6.5),
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

  _makingWhatsappAssign() async {

    String url = "91"+callassign;

    await launch("whatsapp://send?phone="+url+"&text=hello");
  }

  _makingWhatsappAccepted() async {

    String url = "91"+callaccepted;

    await launch("whatsapp://send?phone="+url+"&text=hello");
  }

  _makingWhatsappRejected() async {

    String url = "91"+callrejected;

    await launch("whatsapp://send?phone="+url+"&text=hello");
  }

}
