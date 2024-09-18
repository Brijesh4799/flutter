
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:salescrm/Darts/Expense.dart';
import 'package:salescrm/Darts/alert.dart';
import 'package:salescrm/Darts/b2b.dart';
import 'package:salescrm/Darts/b2c.dart';
import 'package:salescrm/Darts/login.dart';
import 'package:salescrm/Darts/salepipeline.dart';
import 'package:salescrm/Darts/viewactivity.dart';
import 'package:salescrm/Models/alertmeetupdatemodel.dart';
import 'package:salescrm/Models/alerttaskupdatemodel.dart';
import 'package:salescrm/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:url_launcher/url_launcher.dart';

import '../Apis/apis.dart';
import '../Models/taskmodel.dart';
import '../Providers/callprovider.dart';
import 'addcall.dart';
import 'addmeet.dart';
import 'addtask.dart';
import 'calltodaydata.dart';
import 'data.dart';


class PopUpCall extends StatelessWidget {

  final List<PopupMenuEntry> menucall;
  final Widget? icon;

  const PopUpCall({Key? key, required this.menucall,this.icon}): super(key: key);

  @override
  Widget build(BuildContext context){
    return PopupMenuButton(
      itemBuilder: ((context) => menucall),
      icon: icon,
    );
  }
}


class TaskST extends StatefulWidget {
  // ItemDetail({required this.itemlist});

  @override
  State createState() => new MyTaskST();
}

class MyTaskST extends State<TaskST> {

  late SharedPreferences prefs,preflog_in_out;

  GlobalKey<ScaffoldState> _drawerkey= GlobalKey<ScaffoldState>();

  String clock="Clock In";
  String clocktime="";
  bool isSwitched = false;
  bool isClockfont=true;
  bool isClockedfont=false;
  bool statusclock = false;

  String currenttime = DateFormat("hh:mm a").format(DateTime.now());
  String hour="";

  List<ResultsTask>? taskmodel;
  bool isWhatsapp=true;
  bool isCall=true;
  String callnumber="";
  String whatsappnumber="";



  List<Color> colorList = [Color(0xffffc107), Colors.green, Color(0xff00E5FF)];

  Color selectcolorstatus= Color(0xff01579b);
  Color priortystatus= Colors.lightGreenAccent;

  String select="Today";
  Color selectcolortoday= Color(0xff00E5FF);
  Color selectcolortomorrow= Colors.black54;
  Color selectcolordate= Colors.black54;
  bool isTodayLine=true;
  bool isTomorrowLine=false;
  bool isDateLine=false;

  DateTime fromselectedDate = DateTime.now();
  static String fromtime= DateFormat('dd-MM-yyyy').format(DateTime.now());

  String todaytime = DateFormat('dd-MM-yyyy').format(DateTime.now());

  String fromtimefilter = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String totimefilter = DateFormat('dd-MM-yyyy').format(DateTime.now().add(Duration(days: 1)));

  var statusarr=["Status","Scheduled","Rescheduled","Held","Canceled"];

  bool isFeedBackClickActivity = false;
  bool isFeedBackClickStatus = false;
  bool isFeedBackClickPeriod = false;

  String activityvalue = "1";
  String statusvalue = "5";
  String periodvalue = "11";

  String callplane = "ratingwhite.png";
  String meetplane = "ratingwhite.png";
  String taskplane = "ratingwhite.png";
  String allplane = "ratingwhite.png";


  void getCallPlane() {
    callplane = "ratingblue.png";
    meetplane = "ratingwhite.png";
    taskplane = "ratingwhite.png";
    allplane = "ratingwhite.png";
  }

  void getMeetPlane() {
    callplane = "ratingwhite.png";
    meetplane = "ratingblue.png";
    taskplane = "ratingwhite.png";
    allplane = "ratingwhite.png";
  }

  void getTaskPlane() {
    callplane = "ratingwhite.png";
    meetplane = "ratingwhite.png";
    taskplane = "ratingblue.png";
    allplane = "ratingwhite.png";
  }

  void getAllPlane() {
    callplane = "ratingwhite.png";
    meetplane = "ratingwhite.png";
    taskplane = "ratingwhite.png";
    allplane = "ratingblue.png";
  }


  String schedulestatus = "ratingwhite.png";
  String reschedulestatus = "ratingwhite.png";
  String heldstatus = "ratingwhite.png";
  String cancelstatus = "ratingwhite.png";
  String allstatus = "ratingwhite.png";

  void getScheduleStatus() {
    schedulestatus = "ratingblue.png";
    reschedulestatus = "ratingwhite.png";
    heldstatus = "ratingwhite.png";
    cancelstatus = "ratingwhite.png";
    allstatus = "ratingwhite.png";
  }

  void getRescheduleStatus() {
    schedulestatus = "ratingwhite.png";
    reschedulestatus = "ratingblue.png";
    heldstatus = "ratingwhite.png";
    cancelstatus = "ratingwhite.png";
    allstatus = "ratingwhite.png";
  }

  void getHeldStatus() {
    schedulestatus = "ratingwhite.png";
    reschedulestatus = "ratingwhite.png";
    heldstatus = "ratingblue.png";
    cancelstatus = "ratingwhite.png";
    allstatus = "ratingwhite.png";
  }

  void getCancelStatus() {
    schedulestatus = "ratingwhite.png";
    reschedulestatus = "ratingwhite.png";
    heldstatus = "ratingwhite.png";
    cancelstatus = "ratingblue.png";
    allstatus = "ratingwhite.png";
  }

  void getAllStatus() {
    schedulestatus = "ratingwhite.png";
    reschedulestatus = "ratingwhite.png";
    heldstatus = "ratingwhite.png";
    cancelstatus = "ratingwhite.png";
    allstatus = "ratingblue.png";
  }

  String todayperiod = "ratingwhite.png";
  String tomorrowperiod = "ratingwhite.png";
  String selectperiod = "ratingwhite.png";

  void getTodayPeriod() {
    todayperiod = "ratingblue.png";
    tomorrowperiod = "ratingwhite.png";
    selectperiod = "ratingwhite.png";
  }

  void getTomorrowPeriod() {
    todayperiod = "ratingwhite.png";
    tomorrowperiod = "ratingblue.png";
    selectperiod = "ratingwhite.png";
  }

  void getSelectPeriod() {
    todayperiod = "ratingwhite.png";
    tomorrowperiod = "ratingwhite.png";
    selectperiod = "ratingblue.png";
  }

  createDialog(BuildContext context){
    return showDialog(
        context: context,
        builder: (context){
          return  AlertDialog(

            content: Text('Are Your Sure You want to Logout?',style: TextStyle(color: Colors.black,fontSize: 14,
                fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),

            actions: [
              ElevatedButton(
                // textColor: Colors.black,
                onPressed: () {
                  preflog_in_out.clear();
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

              ElevatedButton(
                //  textColor: Colors.black,
                onPressed: () {
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
            ],
          );
        });
  }

  getMyLoginValue() async {
    preflog_in_out = await SharedPreferences.getInstance();
    preflog_in_out.setBool("ID",true);
  }

  @override
  void initState() {
    // TODO: implement initState
    statusclock=false;

    if(statusclock == true) {
      //   isSwitched = true;
      isClockedfont=true;
      isClockfont=false;
      clock="Clocked In";
      clocktime=fromtime+" "+currenttime;
      print("is click");
      print("Status of toggle is : $statusclock");
      print('Switch Button is ON');
    }
    else {
      //   isSwitched = false;
      isClockedfont=false;
      isClockfont=true;
      clock="Clock In";
      clocktime="";
      print("is click");
      print("Status of toggle is : $statusclock");
      print('Switch Button is OFF');
    }

    super.initState();

    getMyLoginValue();

    getTaskPlane();
    isFeedBackClickActivity = true;
    activityvalue = "3";
    print("Activity value is $activityvalue");

    getScheduleStatus();
    isFeedBackClickStatus = true;
    statusvalue = "5";
    print("Status value is $statusvalue");

    getTodayPeriod();
    isFeedBackClickPeriod = true;
    periodvalue = "10";
    todaytime = DateFormat('dd-MMM-yyyy').format(DateTime.now());
    print("Period value is $periodvalue");
    print("Today time is $todaytime");

    print("from time prickers : " + fromtimefilter);
    print("to time prickers : " + totimefilter);

    //  getMyLoginValue();
  }

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(

          key: _drawerkey,

          drawer: Drawer(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0),topRight: Radius.circular(15.0),),
            ),
            //  backgroundColor: Color(0xff37474f),
            child:Column(children: [

              Container(
                height: 170,
                width: MediaQuery.of(context).size.width,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0),bottomRight: Radius.circular(15.0)
                      ,topLeft: Radius.circular(15.0),topRight: Radius.circular(15.0),),
                    image: DecorationImage(
                      image: AssetImage("image/menubg.jpg"),
                      fit: BoxFit.cover,
                    ),

                    //  color: Colors.blue,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Container(
                        // margin: EdgeInsets.only(top: 5),
                        child: Image.asset("image/saleslogo.png",height: 70, width: 120,),
                      ),

                    /*  Container(
                        margin: EdgeInsets.only( top: 5),
                        child: Text("Hi Sanjeev !",
                          style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                      ),

                      SizedBox(height: 25,),

                      Container(
                        height: 50,
                        child: Row(
                          children: [

                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Visibility(
                                  visible: isClockfont,
                                  child: Container(
                                    margin: EdgeInsets.only( top: 7.5),
                                    child: Text(clock,
                                      style: TextStyle(color: Colors.white,fontSize: 13,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                                  ),
                                ),

                                Visibility(
                                  visible: isClockedfont,
                                  child: Container(
                                    margin: EdgeInsets.only( top: 0),
                                    child: Text(clock,
                                      style: TextStyle(color: Colors.white,fontSize: 11,),),
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.only( top: 5),
                                  child: Text(clocktime,
                                    style: TextStyle(color: Colors.white,fontSize: 13,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                                ),
                              ],

                            ),

                            Spacer(),


                            Container(

                              child: Column(
                                children: [

                                  Container(
                                    margin: EdgeInsets.only( right: 20),
                                    child: FlutterSwitch(
                                      width: 60.0,
                                      height: 27.5,
                                      valueFontSize: 12.0,
                                      toggleSize: 20.0,
                                      value: statusclock,
                                      borderRadius: 20.0,
                                      padding: 6.0,
                                      //  showOnOff: true,
                                      inactiveColor: Colors.lightBlue,
                                      activeColor: Colors.white,
                                      inactiveToggleColor: Colors.white,
                                      activeToggleColor: Colors.lightBlue,
                                      onToggle: (val) {
                                        setState(() {
                                          statusclock = val;

                                          if(statusclock == true) {
                                            //   isSwitched = true;
                                            isClockedfont=true;
                                            isClockfont=false;
                                            statusclock = val;
                                            clock="Clocked In";
                                            clocktime=fromtime+" "+currenttime;
                                            print("is click");
                                            print("Status of toggle is : $statusclock");
                                            print('Switch Button is ON');
                                          }
                                          else
                                          {
                                            //   isSwitched = false;
                                            isClockedfont=false;
                                            isClockfont=true;
                                            statusclock = val;
                                            clock="Clock In";
                                            clocktime="";
                                            print("is click");
                                            print("Status of toggle is : $statusclock");
                                            print('Switch Button is OFF');
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
                      ),*/
                    ],
                  ),

                ),
              ),

              Expanded(

                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      //  borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(


                      children: [

                        /* InkWell(
                        onTap:  (){
                         *//* Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                            return MyBottomNavigationBar();
                          }));*//*
                          print("is pressed");
                        },

                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                child: Image.asset("image/customermenu.png",height: 18, width: 18,),
                              ),

                              Container(
                                margin: EdgeInsets.only(left: 20),
                                child : Text("Customers",
                                    style: TextStyle(color: Colors.black54,fontSize: 12,
                                        fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                              )
                            ],
                          ),
                        ),
                      ),*/


                        InkWell(
                          onTap:  (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>B2BST()));
                            print("is pressed");
                          },

                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  child: Image.asset("image/bbmenu.png",height: 20, width: 20,),
                                ),

                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child : Text("B2B Agent",
                                      style: TextStyle(color: Colors.black54,fontSize: 12,
                                          fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                                )
                              ],
                            ),
                          ),
                        ),

                        InkWell(
                          onTap:  (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>B2CST()));
                            print("is pressed");
                          },

                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  child: Image.asset("image/bcmenu.png",height: 20, width: 25,),
                                ),

                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  child : Text("B2C",
                                      style: TextStyle(color: Colors.black54,fontSize: 12,
                                          fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                                )
                              ],
                            ),
                          ),
                        ),


                        InkWell(
                          onTap:  (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ExpenseST()));
                            print("is pressed");
                          },

                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  child: Image.asset("image/expmenu.png",height: 20, width: 25,),
                                ),

                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  child : Text("Expesnse",
                                      style: TextStyle(color: Colors.black54,fontSize: 12,
                                          fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                                )
                              ],
                            ),
                          ),
                        ),

                        InkWell(
                          onTap:  (){
                            //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AlertST()));
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AlertST()),).then((value) =>{ getUpdate()});
                            print("is pressed");
                          },

                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  child: Image.asset("image/alertmenu.png",height: 20, width: 25,),
                                ),

                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  child : Text("Alerts",
                                      style: TextStyle(color: Colors.black54,fontSize: 12,
                                          fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                                )
                              ],
                            ),
                          ),
                        ),

                        Container(width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 15,right: 15,top: 25,bottom: 25),
                          height: 1,
                          color: Colors.grey,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child : Text("Reports",
                                  style: TextStyle(color: Colors.black54,fontSize: 12,
                                      fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                            ),
                          ],
                        ),

                        InkWell(
                          onTap:  (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                              return MyCallBottomNavigationBar();
                            }));
                            print("is pressed");
                          },

                          child: Container(
                            margin: EdgeInsets.only(top: 17.5),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 17.5),
                                  child: Image.asset("image/reportmenu.png",height: 20, width: 20,),
                                ),

                                Container(
                                  margin: EdgeInsets.only(left: 17.5),
                                  child : Text("Call Report",
                                      style: TextStyle(color: Colors.black54,fontSize: 12,
                                          fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                                )
                              ],
                            ),
                          ),
                        ),

                        InkWell(
                          onTap:  (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                              return MyMeetBottomNavigationBar();
                            }));
                            print("is pressed");
                          },

                          child: Container(
                            margin: EdgeInsets.only(top: 17.5),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  child: Image.asset("image/reportmenu.png",height: 20, width: 25,),
                                ),

                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  child : Text("Meeting Report",
                                      style: TextStyle(color: Colors.black54,fontSize: 12,
                                          fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                                )
                              ],
                            ),
                          ),
                        ),

                        InkWell(
                          onTap:  (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                              return MyTaskBottomNavigationBar();
                            }));
                            print("is pressed");
                          },

                          child: Container(
                            margin: EdgeInsets.only(top: 17.5),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  child: Image.asset("image/reportmenu.png",height: 20, width: 25,),
                                ),

                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  child : Text("Task Report",
                                      style: TextStyle(color: Colors.black54,fontSize: 12,
                                          fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                                )
                              ],
                            ),
                          ),
                        ),

                        InkWell(
                          onTap:  (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SalesPipelineST()));
                            print("is pressed");
                          },

                          child: Container(
                            margin: EdgeInsets.only(top: 17.5),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  child: Image.asset("image/reportmenu.png",height: 20, width: 25,),
                                ),

                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  child : Text("Sale Pipeline Report",
                                      style: TextStyle(color: Colors.black54,fontSize: 12,
                                          fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                                )
                              ],
                            ),
                          ),
                        ),

                        /* InkWell(
                        onTap:  (){
                          //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ExpenseST()));
                          print("is pressed");
                        },

                        child: Container(
                          margin: EdgeInsets.only(top: 17.5),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                child: Image.asset("image/reportmenu.png",height: 20, width: 25,),
                              ),

                              Container(
                                margin: EdgeInsets.only(left: 15),
                                child : Text("Sale Payment Report",
                                    style: TextStyle(color: Colors.black54,fontSize: 12,
                                        fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                              )
                            ],
                          ),
                        ),
                      ),*/

                        /*InkWell(
                         onTap:  (){
                           //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ExpenseST()));
                           print("is pressed");
                         },

                         child: Container(
                           margin: EdgeInsets.only(top: 17.5),
                           child: Row(
                             children: [
                               Container(
                                 margin: EdgeInsets.only(left: 15),
                                 child: Image.asset("image/reportmenu.png",height: 20, width: 25,),
                               ),

                               Container(
                                 margin: EdgeInsets.only(left: 15),
                                 child : Text("Customer Report",
                                     style: TextStyle(color: Colors.black54,fontSize: 12,
                                         fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                               )
                             ],
                           ),
                         ),
                       ),*/

                        Container(width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 15,right: 15,top: 25,bottom: 20),
                          height: 1,
                          color: Colors.grey,),

                        InkWell(
                          onTap:  (){
                            createDialog(context);
                            print("is pressed");
                          },

                          child: Container(
                            margin: EdgeInsets.only(top: 0),
                            child: Row(
                              children: [

                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Image.asset("image/logout.png",height: 20, width: 20,),
                                ),

                                Container(
                                  margin: EdgeInsets.only(left: 17.5),
                                  child : Text("Logout",
                                      style: TextStyle(color: Colors.black54,fontSize: 12,
                                          fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                                )
                              ],
                            ),
                          ),
                        ),

                        /* InkWell(
                        onTap:  (){
                          //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ExpenseST()));
                          print("is pressed");
                        },

                        child: Container(
                          margin: EdgeInsets.only(top: 45),
                          child: Row(
                            children: [

                              Container(
                                margin: EdgeInsets.only(left: 65),
                                child : Text("Sync Now",
                                    style: TextStyle(color: Colors.black54,fontSize: 12,
                                        fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                              ),

                              Spacer(),

                              Container(
                                margin: EdgeInsets.only(right: 45),
                                child: Image.asset("image/syncmenu.png",height: 20, width: 25,),
                              ),
                            ],
                          ),
                        ),
                      ),*/

                        Column(
                          children: [
                            Container(
                                color: Colors.grey,
                                margin: EdgeInsets.only(top: 60,bottom: 0),
                                padding: EdgeInsets.only(top: 10,bottom: 10),

                                child:  Container(
                                  child:  Center(child: Image.asset("image/powered.png",height: 35, width: 115,)),
                                )


                              /* Row(
                            children: [

                              Expanded(
                                //   flex: 1,
                                child: Container(
                                  margin: EdgeInsets.only(left: 85,top: 5),
                                  child:Text("Powered By",
                                      style: TextStyle(color: Colors.black,fontSize: 11,
                                          fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),),),

                              Expanded(
                                //  flex: 1,
                                  child: Container(
                                    margin: EdgeInsets.only( right: 65),
                                    child:  Image.asset("image/deboxicon.png",height: 30, width: 35,),
                                  ))
                            ],
                          ),*/

                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ]),


          ),


          body:   Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("image/callbg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(children: [

              Container(
                height: 105,
                // margin: EdgeInsets.only(top: 15, bottom: 0),
                color: Colors.white,
                child: Container(
                  margin: EdgeInsets.only(top: 5, bottom: 0),
                  // padding: EdgeInsets.only(bottom: 20, top: 0),
                  child: Column(

                    children: [

                      Row(
                        children: [

                          InkWell(
                            onTap:(){
                              _drawerkey.currentState?.openDrawer();
                              print("drawer is pressed");
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 5, left: 15),
                              child: Image.asset(
                                "image/hamberghome.png", height: 25, width: 30,),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(top: 10, left: 15, right: 20),
                            child: Text("Task",
                              style: TextStyle(color: Colors.blue,
                                  fontSize: 20,
                                  fontFamily: 'BebesNeue',
                                  fontWeight: FontWeight.w700),),
                          ),

                          Spacer(),

                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Stack(children: [

                              Container(
                                margin: EdgeInsets.only(
                                    top: 5, left: 7.5, right: 5),
                                child: Image.asset(
                                  "image/plus.png", height: 35, width: 40,),
                              ),

                              PopUpCall(menucall: [


                                PopupMenuItem(

                                  child: Row(children: [

                                    addPopUp(),

                                  ],),)
                              ], icon: Text("")),
                            ],
                            ),
                          ),

                          InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AlertST()),).then((value) =>{ getUpdate()});
                              print("is pressed");
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 5, right: 12.5),
                              child: Image.asset(
                                "image/bellicon.png", height: 35, width: 40,),
                            ),
                          )
                        ],

                      ),

                      Align(
                          alignment: Alignment.centerRight,
                          child:InkWell(
                            onTap: (){
                              setState(() {
                                getTask();

                              });


                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 25,right: 25,top: 7.5,bottom: 7.5),
                              margin: EdgeInsets.only(top: 12.5,right: 20,),
                              color: Colors.lightBlueAccent,
                              child: Text("Search",
                                  style: TextStyle(color: Colors.white,fontSize: 14,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                            ),
                          )
                      ),
                    ],

                  ),
                ),
              ),

              Container(
                color: Colors.white,
                child: Column(children: [

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight:Radius.circular(30),),
                    ),

                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 2.5,bottom: 2.5),
                    margin: EdgeInsets.only(top: 0,left: 0,right: 0),


                    child: Row(children: [

                      InkWell(
                        onTap: (){
                          selectFromDateAssign(context);
                        },
                        child: Row(children: [

                          Container(
                            margin: EdgeInsets.only(left: 25),
                            child: Center(
                              child: Text(fromtime,
                                  style: TextStyle(color: Colors.white,fontSize: 13,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only( top: 2.5,left: 5),
                            child: Image.asset("image/dropdown.png",height: 10, width: 10,),
                          ),
                        ],
                        ),
                      ),

                      Spacer(),

                      Container(
                        alignment: Alignment.center,
                        //  padding: EdgeInsets.only(top: 20,bottom: 20,left: 20,right: 20),
                        width: 110.0,
                        height: 35.0,
                        margin: EdgeInsets.only(left: 10,right: 20),
                        child:DropdownButtonHideUnderline(

                          child: ButtonTheme(
                            focusColor: Colors.blue,
                            child: ChangeNotifierProvider<CallProvider>(

                                create: (context) => CallProvider(),

                                child: Consumer<CallProvider>(
                                    builder: (context, provider, child){

                                      return DropdownButton(
                                        dropdownColor: Colors.lightBlueAccent,
                                        style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                                        // dropdownColor: Colors.grey,
                                        focusColor: Colors.lightBlue,
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.white,
                                        ),
                                        items: statusarr.map((String itemnames) {
                                          return DropdownMenuItem<String>(

                                              value: itemnames,
                                              child: Text(itemnames,textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 13,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700))
                                          );
                                        }).toList(),

                                        onChanged: (String? value) {
                                          CallProvider.statustpye=value!;

                                          provider.selectTypes();

                                        },
                                        value: CallProvider.statustpye,
                                      );
                                    }
                                )


                            ),
                          ),
                        ),

                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(5),
                          color: Colors.lightBlueAccent,

                        ),
                      ),
                    ],
                    ),

                  ),
                ],

                ),
              ),

              // TASK API

              FutureBuilder(
                  future: getTask(),
                  builder:(context, snapshot) {

                    if(snapshot.hasData) {
                      taskmodel = snapshot.data as List<ResultsTask>;

                      return getTaskWidget();

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

            ],
            ),
          )
      ),
    );
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
        // getAssign();
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

  Widget addPopUp() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        width: 81,
        decoration: BoxDecoration(
          /* border: Border.all(
              color: Colors.blue,
              width: 2.5,
            ),*/
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [

            InkWell(onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddCallST()));
              print("is called");
            },
              child: Row(children: [

                Container(
                  //  margin: EdgeInsets.only(left: 5,top: 5, right: 5),
                  child: Image.asset(
                    "image/addcall.png", height: 15, width: 16,),
                ),

                Container(
                  margin: EdgeInsets.only(left: 7.5,),
                  child: Text("Add Call",
                      style: TextStyle(color: Colors.blue,
                        fontSize: 11,
                        fontFamily: 'BebesNeue',
                        fontWeight: FontWeight.w700,)),
                ),

              ],),
            ),

            SizedBox(height: 10,),

            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 1,
              color: Colors.grey,
            ),

            SizedBox(height: 10,),

            InkWell(
              onTap: (){
                print("is click");
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddMeetST()));
              },
              child: Row(children: [

                Container(
                  //  margin: EdgeInsets.only(left: 5,top: 5, right: 5),
                  child: Image.asset(
                    "image/addmeeting.png", height: 15, width: 16,),
                ),

                Container(
                  margin: EdgeInsets.only(left: 7.5,),
                  child: Text("Add Meeting",
                      style: TextStyle(color: Colors.blue,
                        fontSize: 11,
                        fontFamily: 'BebesNeue',
                        fontWeight: FontWeight.w700,)),
                ),

              ],),
            ),

            SizedBox(height: 10,),

            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 1,
              color: Colors.grey,
            ),

            SizedBox(height: 10,),

            InkWell(
              onTap: (){
                print("is click");
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddTaskST()));
              },
              child: Row(children: [

                Container(
                  //  margin: EdgeInsets.only(left: 5,top: 5, right: 5),
                  child: Image.asset("image/addtask.png", height: 15, width: 16,),
                ),

                Container(
                  margin: EdgeInsets.only(left: 5,),
                  child: Text("Add Task",
                      style: TextStyle(color: Colors.blue,
                        fontSize: 11,
                        fontFamily: 'BebesNeue',
                        fontWeight: FontWeight.w700,)),
                ),

              ],),
            ),

            /*SizedBox(height: 10,),

            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 1,
              color: Colors.grey,
            ),
            SizedBox(height: 10,),

            InkWell(
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ViewActST()));
                print("is called");
              },
              child: Row(children: [

                Container(
                  //  margin: EdgeInsets.only(left: 5,top: 5, right: 5),
                  child: Image.asset(
                    "image/viewactivity.png", height: 15, width: 16,),
                ),

                Container(
                  margin: EdgeInsets.only(left: 5,),
                  child: Text("View Activity",
                      style: TextStyle(color: Colors.blue,
                        fontSize: 11,
                        fontFamily: 'BebesNeue',
                        fontWeight: FontWeight.w700,)),
                ),

              ],),
            ),*/
          ],
        ),
      ),
    );
  }

  searchDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) =>
                AlertDialog(

                  actions: [

                    Column(children: [

                      // Activity

                      Column(children: [

                        SizedBox(height: 10,),

                        Row(children: [
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 2.5,),
                            child: Center(
                              child: Text("Activity",
                                  // textAlign: TextAlign.left,
                                  style: TextStyle(color: Colors.blue,
                                    fontSize: 10,
                                    fontFamily: 'BebesNeue',
                                    fontWeight: FontWeight.w700,)),
                            ),
                          ),
                        ],

                        ),

                        SizedBox(height: 10,),


                        Row(children: [

                          Container(
                            margin: EdgeInsets.only(left: 20, top: 2.5),
                            child: Text("Task",
                                style: TextStyle(color: Colors.black,
                                  fontSize: 11,
                                  /*fontFamily: 'BebesNeue',
                              fontWeight: FontWeight.w700,*/)),
                          ),

                          Spacer(),


                          Row(
                            children: [

                              InkWell(
                                onTap: () {
                                  setState(() {
                                    getTaskPlane();
                                    isFeedBackClickActivity = true;
                                    activityvalue = "3";
                                    print("Activity value is $activityvalue");
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 15),
                                  child: Image.asset("image/" + taskplane, height: 16, width: 16,),
                                ),
                              ),


                            ],),

                        ],),


                        SizedBox(height: 10,),


                        Container(
                          margin: EdgeInsets.only(left: 20, right: 15),
                          color: Colors.black54,
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                        ),


                      ],),

                      // Status

                      Column(children: [

                        SizedBox(height: 10,),

                        Row(children: [
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 2.5,),
                            child: Center(
                              child: Text("Status",
                                  // textAlign: TextAlign.left,
                                  style: TextStyle(color: Colors.blue,
                                    fontSize: 10,
                                    fontFamily: 'BebesNeue',
                                    fontWeight: FontWeight.w700,)),
                            ),
                          ),
                        ],

                        ),

                        SizedBox(height: 2.5,),


                        Row(children: [

                          Container(
                            margin: EdgeInsets.only(left: 20, top: 2.5),
                            child: Text("Schelduled", style: TextStyle(color: Colors.black,
                              fontSize: 11,
                              /*fontFamily: 'BebesNeue',
                              fontWeight: FontWeight.w700,*/)),
                          ),

                          Spacer(),

                          InkWell(
                            onTap: () {
                              setState(() {
                                getScheduleStatus();
                                isFeedBackClickStatus = true;
                                statusvalue = "5";
                                print("Status value is $statusvalue");
                              });
                            },
                            child: Row(
                              children: [

                                Container(
                                  padding:EdgeInsets.all(10),
                                  margin: EdgeInsets.only(right: 5),
                                  child: Image.asset("image/" + schedulestatus, height: 16, width: 16,),
                                ),

                              ],),
                          ),

                        ],),

                        SizedBox(height: 2.5,),

                        Row(children: [

                          Container(
                            margin: EdgeInsets.only(left: 20, top: 2.5),
                            child: Text("Re-Scheduled",
                                style: TextStyle(color: Colors.black,
                                  fontSize: 11,
                                  /*fontFamily: 'BebesNeue',
                              fontWeight: FontWeight.w700,*/)),
                          ),

                          Spacer(),

                          InkWell(
                            onTap: () {
                              setState(() {
                                getRescheduleStatus();
                                isFeedBackClickStatus = true;
                                statusvalue = "6";
                                print("Status value is $statusvalue");
                              });
                            },
                            child: Row(
                              children: [

                                Container(
                                  padding:EdgeInsets.all(10),
                                  margin: EdgeInsets.only(right: 5),
                                  child: Image.asset(
                                    "image/" + reschedulestatus, height: 16,
                                    width: 16,),
                                ),

                              ],),
                          ),


                        ],),

                        SizedBox(height: 2.5,),

                        Row(children: [

                          Container(
                            margin: EdgeInsets.only(left: 20, top: 2.5),
                            child: Text("Held",
                                style: TextStyle(color: Colors.black,
                                  fontSize: 11,
                                  /*fontFamily: 'BebesNeue',
                              fontWeight: FontWeight.w700,*/)),
                          ),

                          Spacer(),

                          InkWell(
                            onTap: () {
                              setState(() {
                                getHeldStatus();
                                isFeedBackClickStatus = true;
                                statusvalue = "7";
                                print("Status value is $statusvalue");
                              });
                            },
                            child: Row(
                              children: [

                                Container(
                                  padding:EdgeInsets.all(10),
                                  margin: EdgeInsets.only(right: 5),
                                  child: Image.asset(
                                    "image/" + heldstatus, height: 16,
                                    width: 16,),
                                ),

                              ],),
                          ),


                        ],),

                        SizedBox(height: 2.5,),

                        Row(children: [

                          Container(
                            margin: EdgeInsets.only(left: 20, top: 2.5),
                            child: Text("Cancelled",
                                style: TextStyle(color: Colors.black,
                                  fontSize: 11,
                                  /*fontFamily: 'BebesNeue',
                              fontWeight: FontWeight.w700,*/)),
                          ),

                          Spacer(),

                          InkWell(
                            onTap: () {
                              setState(() {
                                getCancelStatus();
                                isFeedBackClickStatus = true;
                                statusvalue = "8";
                                print("Status value is $statusvalue");
                              });
                            },
                            child: Row(
                              children: [

                                Container(
                                  padding:EdgeInsets.all(10),
                                  margin: EdgeInsets.only(right: 5),
                                  child: Image.asset(
                                    "image/" + cancelstatus, height: 16,
                                    width: 16,),
                                ),

                              ],),
                          ),


                        ],),

                        SizedBox(height: 2.5,),

                        Row(children: [

                          Container(
                            margin: EdgeInsets.only(left: 20, top: 2.5),
                            child: Text("All",
                                style: TextStyle(color: Colors.black,
                                  fontSize: 11,
                                  /*fontFamily: 'BebesNeue',
                              fontWeight: FontWeight.w700,*/)),
                          ),

                          Spacer(),

                          InkWell(
                            onTap: () {
                              setState(() {
                                getAllStatus();
                                isFeedBackClickStatus = true;
                                statusvalue = "9";
                                print("Status value is $statusvalue");
                              });
                            },
                            child: Row(
                              children: [

                                Container(
                                  padding:EdgeInsets.all(10),
                                  margin: EdgeInsets.only(right: 5),
                                  child: Image.asset(
                                    "image/" + allstatus, height: 16,
                                    width: 16,),
                                ),

                              ],),
                          ),


                        ],),

                        SizedBox(height: 2.5,),

                        Container(
                          margin: EdgeInsets.only(left: 20, right: 15),
                          color: Colors.black54,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: 1,
                        ),


                      ],),

                      // Activity Period

                      Column(children: [

                        SizedBox(height: 10,),

                        Row(children: [
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 2.5,),
                            child: Center(
                              child: Text("Activity Peroid",
                                  // textAlign: TextAlign.left,
                                  style: TextStyle(color: Colors.blue,
                                    fontSize: 10,
                                    fontFamily: 'BebesNeue',
                                    fontWeight: FontWeight.w700,)),
                            ),
                          ),
                        ],

                        ),

                        SizedBox(height: 2.5,),


                        Row(children: [

                          Container(
                            margin: EdgeInsets.only(left: 20, top: 2.5),
                            child: Text("Today",
                                style: TextStyle(color: Colors.black,
                                  fontSize: 11,
                                  /*fontFamily: 'BebesNeue',
                              fontWeight: FontWeight.w700,*/)),
                          ),

                          Spacer(),

                          InkWell(
                            onTap: () {
                              setState(() {
                                getTodayPeriod();
                                isFeedBackClickPeriod = true;
                                periodvalue = "10";
                                todaytime = DateFormat('dd-MMM-yyyy').format(
                                    DateTime.now());
                                print("Period value is $periodvalue");
                                print("Today time is $todaytime");
                              });
                            },
                            child: Row(
                              children: [

                                Container(
                                  padding:EdgeInsets.all(10),
                                  margin: EdgeInsets.only(right: 5),
                                  child: Image.asset(
                                    "image/" + todayperiod, height: 16,
                                    width: 16,),
                                ),

                              ],),
                          ),

                        ],),

                        SizedBox(height: 2.5,),

                        Row(children: [

                          Container(
                            margin: EdgeInsets.only(left: 20, top: 2.5),
                            child: Text("Tomorrow",
                                style: TextStyle(color: Colors.black,
                                  fontSize: 11,
                                  /*fontFamily: 'BebesNeue',
                              fontWeight: FontWeight.w700,*/)),
                          ),

                          Spacer(),

                          InkWell(
                            onTap: () {
                              setState(() {
                                getTomorrowPeriod();
                                isFeedBackClickPeriod = true;
                                periodvalue = "11";
                                todaytime = DateFormat('dd-MMM-yyyy').format(
                                    DateTime.now().add(Duration(days: 1)));
                                print("Period value is $periodvalue");
                                print("Tomorrow time is $todaytime");
                              });
                            },
                            child: Row(
                              children: [

                                Container(
                                  padding:EdgeInsets.all(10),
                                  margin: EdgeInsets.only(right: 5),
                                  child: Image.asset(
                                    "image/" + tomorrowperiod, height: 16,
                                    width: 16,),
                                ),

                              ],),
                          ),

                        ],),

                        SizedBox(height: 2.5,),

                        Row(children: [

                          Container(
                            margin: EdgeInsets.only(left: 20, top: 2.5),
                            child: Text("Select Peroid",
                                style: TextStyle(color: Colors.black,
                                  fontSize: 11,
                                  /*fontFamily: 'BebesNeue',
                              fontWeight: FontWeight.w700,*/)),
                          ),

                          Spacer(),

                          InkWell(
                            onTap: () {
                              setState(() {
                                getSelectPeriod();
                                isFeedBackClickPeriod = true;
                                periodvalue = "12";
                                print("Period value is $periodvalue");
                                dateDialog(context);
                              });
                            },
                            child: Row(
                              children: [

                                Container(
                                  padding:EdgeInsets.all(10),
                                  margin: EdgeInsets.only(right: 5),
                                  child: Image.asset(
                                    "image/" + selectperiod, height: 16,
                                    width: 16,),
                                ),

                              ],),
                          ),

                        ],),

                        SizedBox(height: 5,),


                        Container(
                          margin: EdgeInsets.only(left: 20, right: 15),
                          color: Colors.black54,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: 1,
                        ),


                      ],),


                      SizedBox(height: 15,),


                      ElevatedButton(
                        onPressed: () {
                          if (isFeedBackClickActivity &&
                              isFeedBackClickStatus && isFeedBackClickStatus) {
                            Fluttertoast.showToast(
                                msg: "Submitted ",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 3,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 12.0
                            );
                            Navigator.of(context).pop();
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please First Select One FeedBack!!!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 3,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 12.0
                            );
                          }
                        },
                        child: Container(
                          width: 80,
                          // margin: EdgeInsets.only(left: 5,right: 10),
                          padding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 12, right: 12),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(5),
                            //   border: Border.all(color: Colors.lightBlue,width: 1.0)
                          ),
                          child: Center(
                            child: Text("Search",
                                style: TextStyle(color: Colors.white,
                                  fontSize: 13,
                                  fontFamily: 'BebesNeue',
                                  fontWeight: FontWeight.w700,)),
                          ),
                        ),
                      ),


                      SizedBox(height: 5,),
                    ],),

                  ],

                ),
          );
        });
  }

  dateDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) =>
                AlertDialog(

                  actions: [

                    Column(children: [

                      // Activity

                      Column(children: [

                        SizedBox(height: 10,),

                        Row(children: [
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 2.5,),
                            child: Center(
                              child: Text("Select Peroid",
                                  // textAlign: TextAlign.left,
                                  style: TextStyle(color: Colors.black,
                                    fontSize: 13,
                                    fontFamily: 'BebesNeue',
                                    fontWeight: FontWeight.w700,)),
                            ),
                          ),
                        ],

                        ),

                        SizedBox(height: 30,),

                        InkWell(
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: fromselectedDate,
                                firstDate: DateTime(2015),
                                lastDate: DateTime(2025));

                            if (picked != null && picked != fromselectedDate) {
                              setState(() {
                                fromtimefilter = DateFormat('dd-MM-yyyy').format(picked);
                                print("from time prickers : " + fromtimefilter);
                              });
                            }
                          },
                          child: Row(children: [

                            Container(
                              margin: EdgeInsets.only(left: 10,),
                              child: Text("From Date : ",
                                  style: TextStyle(color: Colors.grey,
                                    fontSize: 13,
                                    fontFamily: 'BebesNeue',
                                    fontWeight: FontWeight.w700,)),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 10,),
                              child: Text(fromtimefilter,
                                  style: TextStyle(color: Colors.black,
                                    fontSize: 13,
                                    fontFamily: 'BebesNeue',
                                    fontWeight: FontWeight.w700,)),
                            ),

                          ]),
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                          color: Colors.black54,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: 1,
                        ),


                        SizedBox(height: 30,),

                        InkWell(
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: fromselectedDate,
                                firstDate: DateTime(2015),
                                lastDate: DateTime(2025));

                            if (picked != null && picked != fromselectedDate) {
                              setState(() {
                                totimefilter =
                                    DateFormat('dd-MM-yyyy').format(picked);
                                print("to time prickers : " + totimefilter);
                              });
                            }
                          },
                          child: Row(children: [

                            Container(
                              margin: EdgeInsets.only(left: 10,),
                              child: Text("To Date : ",
                                  style: TextStyle(color: Colors.grey,
                                    fontSize: 13,
                                    fontFamily: 'BebesNeue',
                                    fontWeight: FontWeight.w700,)),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 10,),
                              child: Text(totimefilter,
                                  style: TextStyle(color: Colors.black,
                                    fontSize: 13,
                                    fontFamily: 'BebesNeue',
                                    fontWeight: FontWeight.w700,)),
                            ),

                          ]),
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                          color: Colors.black54,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: 1,
                        ),


                      ],),


                      SizedBox(height: 20,),


                      ElevatedButton(
                        onPressed: () {
                          if (fromtimefilter==totimefilter) {

                            Fluttertoast.showToast(
                                msg: "Please Select Valid Date",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 3,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 12.0
                            );
                          } else {

                            Fluttertoast.showToast(
                                msg: "Done",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 3,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 12.0
                            );
                            Navigator.of(context).pop();
                          }
                        },
                        child: Container(
                          width: 70,
                          // margin: EdgeInsets.only(left: 5,right: 10),
                          padding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 12, right: 12),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(5),
                            //   border: Border.all(color: Colors.lightBlue,width: 1.0)
                          ),
                          child: Center(
                            child: Text("DONE",
                                style: TextStyle(color: Colors.white,
                                  fontSize: 13,
                                  fontFamily: 'BebesNeue',
                                  fontWeight: FontWeight.w700,)),
                          ),
                        ),
                      ),


                      SizedBox(height: 10,),
                    ],),

                  ],

                ),
          );
        });
  }

  Widget getTaskWidget(){
    return  Expanded(

      child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 10),
          //height: 275,

          padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom:15),


          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              /* border: Border(
                            top: BorderSide(color: Colors.white,width: 2.0,style: BorderStyle.solid),
                            bottom: BorderSide(color: Colors.white,width: 2.0,style: BorderStyle.solid),
                            right: BorderSide(color: Colors.white,width: 2.0,style: BorderStyle.solid),
                            left: BorderSide(color: Colors.white,width: 2.0,style: BorderStyle.solid),
                          ),*/
              //  color: Colors.deepOrange,
              gradient: LinearGradient(
                //   begin: Alignment.topLeft,
                //   end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.3),
                  Colors.white.withOpacity(0.3),
                ],
                //  stops: [0.0,1.0]
              )

          ),

          child: Column(
            children: [

              Expanded(child:  ListView.builder(
                  padding: EdgeInsets.only(top: 15),
                  itemCount: taskmodel!.length,
                  itemBuilder: (context,index){
                   ResultsTask itemslists = taskmodel![index];

                    if (itemslists.status == "Rescheduled") {
                      selectcolorstatus = Color(0xff01579b);
                    }
                    else if (itemslists.status == "Scheduled") {
                      selectcolorstatus = Colors.orange;
                    }
                    else if (itemslists.status == "cancelled") {
                      selectcolorstatus = Colors.red;
                    }
                    else if (itemslists.status == "held") {
                      selectcolorstatus = Colors.lightGreen;
                    }

                    if(itemslists.priorty=="LOW"){
                      priortystatus=Colors.lightGreenAccent;
                    }else if(itemslists.priorty=="MEDIUM"){
                      priortystatus=Colors.orange;
                    }else if(itemslists.priorty=="HIGH"){
                      priortystatus=Colors.redAccent;
                    }

                    if(itemslists.contactno==""){
                      isCall=false;
                      isWhatsapp=false;
                    }else{
                      isCall=true;
                      isWhatsapp=true;
                    }

                    return Container(
                      margin: EdgeInsets.only(bottom: 7.5),
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2.5),

                        //  color: Colors.deepOrange,


                      ),
                      child: Column(children: [

                        Container(height: 2,
                          margin: EdgeInsets.only(left: 5,right: 5),
                          width: MediaQuery.of(context).size.width,
                          color: Color(0xff00E5FF),),

                        Row(children: [

                          Container(
                            margin: EdgeInsets.only(left: 10, top: 10),
                            width: 150,
                            child:  Text(itemslists.salesperson.toString(),
                              style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                          ),

                          Spacer(),

                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                            child: Center(
                              child: Text(itemslists.date.toString(),
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 11,
                                    fontFamily: 'BebesNeue',
                                    fontWeight: FontWeight.w700),),
                            ),
                          ),

                        ]),

                        Row(children: [

                          Container(
                            margin: EdgeInsets.only(left: 10, top: 5),
                            width: 150,
                            child:  Text(itemslists.client.toString(),
                              style: TextStyle(color: Colors.grey,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                          ),

                          Spacer(),

                          Container(
                            width: 90,
                            padding: EdgeInsets.only(top: 2.5,bottom:2.5),
                            margin: EdgeInsets.only(left: 10,right:10, top: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(2.5)),
                              color: selectcolorstatus,
                            ),
                            child:  Center(
                              child: Text(itemslists.status.toString(),
                                style: TextStyle(color: Colors.white,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                            ),
                          ),


                        ]),

                        Row(children: [

                          Container(
                            margin: EdgeInsets.only(left: 10, top: 5),
                            child:  Text("Agenda:",
                              style: TextStyle(color: Colors.grey,fontSize: 10,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 2.5, top: 5),
                            width: 65,
                            child:  Text(itemslists.meeting_agenda.toString(),
                              style: TextStyle(color: Colors.grey,fontSize: 10,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),maxLines: 1,),
                          ),

                          Container(
                            width: 80,
                            margin: EdgeInsets.only(
                                left: 40, right: 0, top: 5),
                            child: Center(
                              child: Text(itemslists.contactno.toString(),
                                  style: TextStyle(color: Colors.grey,
                                      fontSize: 10,
                                      fontFamily: 'BebesNeue',
                                      fontWeight: FontWeight.w700),maxLines: 1),
                            ),
                          ),

                          Visibility(
                            visible:isCall,
                            child: InkWell(
                              onTap:(){
                                callnumber=itemslists.contactno.toString();
                                // callnumber="+91-9910924485";
                                print("pick phone no is : $callnumber");
                                _makingPhoneCall();
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: 5, left: 10),
                                child: Image.asset(
                                  "image/callblue.png", height: 18,
                                  width: 18,),
                              ),
                            ),
                          ),

                          Visibility(
                            visible: isWhatsapp,
                            child: InkWell(
                              onTap:(){
                                // whatsappnumber="+91-9910924485";
                                whatsappnumber=itemslists.contactno.toString();
                                print("pick whatsapp no is : $whatsappnumber");
                                _makingWhatsapp();
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: 5, left: 15),
                                child: Image.asset(
                                  "image/whatsapp.png", height: 20,
                                  width: 20,),
                              ),
                            ),
                          ),

                        ]),

                        Row(children: [

                          Container(
                            margin: EdgeInsets.only(left: 10, top: 5),
                            child:  Text("Priorty:",
                              style: TextStyle(color: Colors.grey,fontSize: 10,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 2.5, top: 5,right: 10),

                            child:  Text(itemslists.priorty.toString(),
                                style: TextStyle(color: priortystatus,fontSize: 10,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),maxLines: 1),
                          ),

                        ]),

                      ],),
                    );
                  }
              ),

              )


            ],

          )


      ),
    );
  }

  Future<List <ResultsTask>> getTask() async{



   String newurl=AppNetworkConstants.TASKS +"?date="+fromtime+"&status="+CallProvider.typevalue;

 //   String newurl = "https://inboundcrm.in/travcrm-dev_2.2/Api/App/nikhil/json_task.php?followupdate="+fromtime+"&status="+CallProvider.typevalue;

    print("Tasks url is : "+newurl);

    var url= Uri.parse(newurl);


    http.Response res = await http.get(url);
    //  List datas= jsonDecode(res.body);

    print("Tasks response is : "+res.body);

    var datas= jsonDecode(res.body)['results'] as List;

    List<ResultsTask> dashdata = datas.map((data) => ResultsTask.fromJson(data)).toList();

    if(dashdata.length==0) {
      Fluttertoast.showToast(
          msg: "No Task for Today",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 12.0
      );
    }else{
      Fluttertoast.showToast(
          msg: "Updated Now : ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 12.0
      );
    }

    return dashdata;
  }

  Future<List <ResultAlertMeetUpdate>> getAlertMeetUpdate() async{

   // String newurl = "https://inboundcrm.in/travcrm-dev_2.2/Api/App/nikhil/json_meetupdate.php";

      String newurl=AppNetworkConstants.ALERTSMEETUPDATE;

    print("Alert Meet Update url is : "+newurl);

    var url= Uri.parse(newurl);

    http.Response res = await http.get(url);
    //  List datas= jsonDecode(res.body);

    print("Alert Meet Update response is : "+res.body);

    var datas= jsonDecode(res.body)['result'] as List;

    List<ResultAlertMeetUpdate> dashdata = datas.map((data) => ResultAlertMeetUpdate.fromJson(data)).toList();

    print("Alert Meet Update : " + dashdata[0].msg!);

    return dashdata;
  }

  Future<List <ResultAlertTaskUpdate>> getAlertTaskUpdate() async{

  //  String newurl = "https://inboundcrm.in/travcrm-dev_2.2/Api/App/nikhil/json_taskupdate.php";

     String newurl=AppNetworkConstants.ALERTSTASKUPDATE;

    print("Alert Task Update url is : "+newurl);

    var url= Uri.parse(newurl);

    http.Response res = await http.get(url);
    //  List datas= jsonDecode(res.body);

    print("Alert Task Update response is : "+res.body);

    var datas= jsonDecode(res.body)['result'] as List;

    List<ResultAlertTaskUpdate> dashdata = datas.map((data) => ResultAlertTaskUpdate.fromJson(data)).toList();

    print("Alert Task Update : " + dashdata[0].msg!);

    return dashdata;
  }

  void getUpdate(){
    setState(() {
      getAlertMeetUpdate();
      getAlertTaskUpdate();
    });
  }

  _makingPhoneCall() async {

    //  const url = 'tel:9910910910';

    String url = 'tel:'+callnumber!;

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _makingWhatsapp() async {
    // String url = '+919910910910';

    //  await launch('https://wa.me/$url?text=Welcome');

    String url = whatsappnumber;

    await launch("whatsapp://send?phone="+url+"&text=hello");
  }
}