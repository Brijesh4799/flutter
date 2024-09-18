
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:salescrm/Darts/Expense.dart';
import 'package:salescrm/Darts/alert.dart';
import 'package:salescrm/Darts/b2b.dart';
import 'package:salescrm/Darts/salepipeline.dart';
import 'package:salescrm/Models/alerttaskupdatemodel.dart';
import 'package:salescrm/Models/todolatmodel.dart';
import 'package:salescrm/Models/togglemodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:pie_chart/pie_chart.dart';


import '../Apis/apis.dart';
import '../Models/alertmeetupdatemodel.dart';
import '../Models/dashmodel.dart';
import '../Models/todomodel.dart';
import '../main.dart';
import 'b2c.dart';
import 'data.dart';
import 'days.dart';
import 'items.dart';
import 'login.dart';



class DashBoardST extends StatefulWidget {
  // ItemDetail({required this.itemlist});

  @override
  State createState() => new MyDashBoardST();
}

class MyDashBoardST extends State<DashBoardST> {

  late SharedPreferences prefs,preflog_in_out;

  GlobalKey<ScaffoldState> _drawerkey= GlobalKey<ScaffoldState>();

  List<ResultsDash>? dashmodel;
  List<ArticlesToDoLat>? todomodel;
  List<ResultsToggle>? togglemodel;

  bool status = false;
  String statusid = "false";
  bool isImageNetwork=true;
  bool isImageLocal=true;
  String todoimage="";

  String clock="Clock In";
  String clocktime="";
  bool isSwitched = false;
  bool isClockfont=true;
  bool isClockedfont=false;

  Map<String, double> dataMap = {
    "Flutter": 3,
    "React": 3,
    "Native": 3,
  };

  DateTime fromselectedDate = DateTime.now();
  static String fromtime= DateFormat('dd-MMM-yyyy').format(DateTime.now());

  String currenttime = DateFormat("hh:mm a").format(DateTime.now());
  String hour="";

  List<Color> colorList = [Color(0xffffc107), Colors.green, Color(0xff00E5FF)];

  getMyLoginValue() async {
    preflog_in_out = await SharedPreferences.getInstance();
    preflog_in_out.setBool("ID",true);
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

  @override
  void initState() {
    // TODO: implement initState
    /*Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {
        currenttime = DateFormat('kk:mm').format(DateTime.now());
        hour = DateFormat('a').format(DateTime.now());
        print("Current time : $currenttime");
        print("Hour : $hour");
      });
    });*/
    getToggle();
  //  statusid="true";

    if(status == true) {
      //   isSwitched = true;
      statusid="true";
      isClockedfont=true;
      isClockfont=false;
      clock="Clocked In";
      clocktime=fromtime+" "+currenttime;
      print("is click");
      print("Status of toggle is : $status");
      print('Switch Button is ON');
    }
    else {
      //   isSwitched = false;
      statusid="false";
      isClockedfont=false;
      isClockfont=true;
      clock="Clock In";
      clocktime="";
      print("is click");
      print("Status of toggle is : $status");
      print('Switch Button is OFF');
    }

    super.initState();
    print("init state is running");
      getMyLoginValue();
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
                width: MediaQuery.of(context).size.width,
                height: 170,
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

                      /*Container(
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
                                      value: status,
                                      borderRadius: 20.0,
                                      padding: 6.0,
                                      //  showOnOff: true,
                                      inactiveColor: Colors.lightBlue,
                                      activeColor: Colors.white,
                                      inactiveToggleColor: Colors.white,
                                      activeToggleColor: Colors.lightBlue,
                                      onToggle: (val) {
                                        setState(() {
                                          statusid="false";
                                          getToggle();
                                          status = val;

                                          if(status == true) {
                                            //   isSwitched = true;
                                            statusid="true";
                                            isClockedfont=true;
                                            isClockfont=false;
                                            status = val;
                                            clock="Clocked In";
                                            clocktime=fromtime+" "+currenttime;
                                            print("is click");
                                            print("Status of toggle is : $status");
                                            print('Switch Button is ON');
                                          }
                                          else
                                          {
                                            statusid="true";
                                            getToggle();
                                            //   isSwitched = false;
                                            statusid="false";
                                            isClockedfont=false;
                                            isClockfont=true;
                                            status = val;
                                            clock="Clock In";
                                            clocktime="";
                                            print("is click");
                                            print("Status of toggle is : $status");
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


          body:  Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("image/homebg1.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(children: [

              Container(
                height: 110,
                margin: EdgeInsets.only(top: 0,bottom: 0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("image/whiteheader.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child:  Container(
                  margin: EdgeInsets.only(top: 10,bottom: 0),
                  padding: EdgeInsets.only(bottom: 20,top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      InkWell(
                        onTap: (){
                          _drawerkey.currentState?.openDrawer();
                          print("drawer is pressed");
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 15,top: 10),
                          child: Image.asset("image/hamberghome.png",height: 25, width: 30,),
                        ),
                      ),

                      Spacer(),

                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Image.asset("image/saleslogo.png",height: 50, width: 100,),
                      ),

                      Spacer(),

                      Container(
                        margin: EdgeInsets.only( top: 10,right: 10),
                        child: Image.asset("image/deboxicon.png",height: 30, width: 45,),
                      )
                    ],

                  ),
                ),
              ),

              // DASHBOARD

              FutureBuilder(
                  future: getDash(),
                  builder:(context, snapshot) {

                    if(snapshot.hasData) {
                      dashmodel= snapshot.data as List<ResultsDash>;

                      return Container(
                        padding: EdgeInsets.only(top: 10),
                        margin: EdgeInsets.only(left: 7.5,right: 7.5),
                        // height: 245,

                        child: Column(
                          children: [


                            Row(children: [

                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [

                                      Container(
                                        child: Text("TODAY'S WORK",
                                          style: TextStyle(color: Colors.white,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                                      ),

                                      Container(
                                        width: 100,
                                        height: 110,
                                        margin: EdgeInsets.only(left: 0),
                                        padding: EdgeInsets.only(top:15, bottom: 20,left: 0,right:10),
                                        child: PieChart(
                                          dataMap: dataMap,
                                          animationDuration: Duration(milliseconds: 1400),
                                          chartLegendSpacing: 22,
                                          // chartRadius: MediaQuery.of(context).size.width / 3.2,
                                          chartRadius: 100,
                                          colorList: colorList,
                                          initialAngleInDegree: 0,
                                          chartType: ChartType.ring,
                                          ringStrokeWidth: 22,
                                          // centerText: "HYBRID",
                                          legendOptions: LegendOptions(
                                            showLegendsInRow: false,
                                            legendPosition: LegendPosition.right,
                                            showLegends: false,
                                            //   legendShape: _BoxShape.circle,
                                            legendTextStyle: TextStyle(
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
                                    ],
                                  )),

                              Expanded(
                                flex: 1,
                                child:
                                Column(children: [

                                  Container(
                                    child: Text("TARGET VS SALES",
                                      style: TextStyle(color: Colors.white,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                                  ),

                                  Container(
                                    height: 110,
                                    margin: EdgeInsets.only(left: 15,right: 15),
                                    child: LinearPercentIndicator( //leaner progress bar
                                      animation: true,
                                      animationDuration: 1000,
                                      lineHeight: 40.0,
                                      percent:int.parse(dashmodel![0].totalsale!.substring(0,2))/100,
                                      linearStrokeCap: LinearStrokeCap.roundAll,
                                      progressColor: Color(0xff01579b),
                                      backgroundColor: Color(0xff00E5FF),
                                      barRadius: Radius.circular(10),
                                    ),
                                  ),
                                ],

                                ),),

                            ],),


                            Container(
                              //  margin: EdgeInsets.only(top: 10),
                              child: Row(children: [
                                // First column

                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 35),
                                    child: Column(
                                      children: [
                                        // first blue

                                        Row(children:
                                        [
                                          Container(
                                            //   margin: EdgeInsets.only(left: 20),
                                            child: Image.asset("image/aqua.png",height: 8, width: 8,),
                                            //  child: Text("Today",style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                                          ),

                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            width: 45,
                                            child: Text("Call",
                                              style: TextStyle(color: Colors.white,fontSize: 10,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                                          ),

                                          Container(
                                            margin: EdgeInsets.only(left: 25),
                                            child: Text(dashmodel![0].totalCalls.toString(),
                                              style: TextStyle(color: Colors.white,fontSize: 13,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                                          ),
                                        ],

                                        ),

                                        SizedBox(height: 10),

                                        Row(children:
                                        [
                                          Container(
                                            //  margin: EdgeInsets.only(left: 20),
                                            child: Image.asset("image/green.png",height: 8, width: 8,),
                                            //  child: Text("Today",style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                                          ),

                                          Container(
                                            width: 45,
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text("Meeting",
                                                style: TextStyle(color: Colors.white,fontSize: 10,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),maxLines: 1),
                                          ),

                                          Container(
                                            margin: EdgeInsets.only(left: 25),
                                            child: Text(dashmodel![0].totalmeetings.toString(),
                                              style: TextStyle(color: Colors.white,fontSize: 13,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                                          ),
                                        ],

                                        ),

                                        SizedBox(height: 10),

                                        Row(children:
                                        [
                                          Container(
                                            //   margin: EdgeInsets.only(left: 20),
                                            child: Image.asset("image/yellow.png",height: 8, width: 8,),
                                            //  child: Text("Today",style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                                          ),

                                          Container(
                                            width: 45,
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text("Task",
                                              style: TextStyle(color: Colors.white,fontSize: 10,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                                          ),

                                          Container(
                                            margin: EdgeInsets.only(left:25),
                                            child: Text(dashmodel![0].totaltasks.toString(),
                                              style: TextStyle(color: Colors.white,fontSize: 13,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                                          ),
                                        ],

                                        ),
                                      ],
                                    ),
                                  ),
                                ),



                                // second column

                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 30),
                                    child: Column(
                                      children: [

                                        // first blue
                                        Row(children:
                                        [
                                          Container(
                                            //  margin: EdgeInsets.only(left: 5),
                                            child: Image.asset("image/blue.png",height: 8, width: 8,),
                                          ),

                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text("Sale",
                                              style: TextStyle(color: Colors.white,fontSize: 10,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                                          ),

                                          Expanded(
                                            child: Container(
                                              width: 85,
                                              margin: EdgeInsets.only(left: 24),
                                              child: Text(dashmodel![0].totalsale.toString(),
                                                style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),maxLines: 1,),
                                            ),
                                          ),
                                        ],

                                        ),

                                        SizedBox(height: 10),

                                        Row(children:
                                        [
                                          Container(
                                            //  margin: EdgeInsets.only(left: 5),
                                            child: Image.asset("image/aqua.png",height: 8, width: 8,),
                                          ),

                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text("Target",
                                              style: TextStyle(color: Colors.white,fontSize: 10,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                                          ),

                                          Expanded(
                                            child: Container(
                                              width: 85,
                                              margin: EdgeInsets.only(left: 17),
                                              child: Text(dashmodel![0].totaltarget.toString(),
                                                  style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),maxLines: 1),
                                            ),
                                          ),
                                        ],

                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              ],

                              ),
                            ),
                          ],
                        ),

                      );

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


              // TODO LIST

              Expanded(

                child: SingleChildScrollView(
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 15,right: 15,top: 30),
                      height: 290,

                      padding: EdgeInsets.all(0),


                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border(
                            top: BorderSide(color: Colors.white,width: 2.0,style: BorderStyle.solid),
                            bottom: BorderSide(color: Colors.white,width: 2.0,style: BorderStyle.solid),
                            right: BorderSide(color: Colors.white,width: 2.0,style: BorderStyle.solid),
                            left: BorderSide(color: Colors.white,width: 2.0,style: BorderStyle.solid),
                          ),
                          //  color: Colors.deepOrange,
                          gradient: LinearGradient(
                            //   begin: Alignment.topLeft,
                            //   end: Alignment.bottomRight,
                            colors: [
                              Colors.black54.withOpacity(0.2),
                              Colors.black54.withOpacity(0.2),
                            ],
                            //  stops: [0.0,1.0]
                          )

                      ),

                      child: Column(
                        children: [

                          Container(
                            // color: Colors.green,
                            width:140,
                            child: Row(children: [

                              Container(
                                margin: EdgeInsets.only(top: 15,left: 0),
                                child:  Image.asset("image/todo.png",height: 27.5, width: 30,),
                              ),

                              Container(
                                margin: EdgeInsets.only(left: 0, top: 15),
                                child:  Text("TO-DO LIST",
                                  style: TextStyle(color: Color(0xff00E5FF),fontSize: 18,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                              ),

                            ],
                            ),

                          ),


                          FutureBuilder(
                              future: getToDo(),
                              builder:(context, snapshot) {

                                if(snapshot.hasData) {
                                  todomodel= snapshot.data as List<ArticlesToDoLat>;

                                  return getTODOWidget();

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

                      )


                  ),
                ),
              ),

            ],
            ),
          ),
      ),
    );
  }

  Widget getTODOWidget(){
    return  Expanded(
      child: Column(children: [

        Row(children: [

          Container(
            margin: EdgeInsets.only(left: 15, top: 10),
            width: 40,
            child:  Text("ACT.",
              style: TextStyle(color: Colors.white,fontSize: 12.5,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
          ),


          Container(
            width: 90,
            margin: EdgeInsets.only(left: 10, top: 10),
            child:  Center(
              child: Text("CUSTOMER",
                style: TextStyle(color: Colors.white,fontSize: 12.5,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
            ),
          ),


          Container(
            width: 60,
            margin: EdgeInsets.only(left: 20, top: 10),
            child:  Center(
              child: Text("PROD.",
                style: TextStyle(color: Colors.white,fontSize: 12.5,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
            ),
          ),

          Container(
            width: 60,
            margin: EdgeInsets.only(left: 20,right:10, top: 10),
            child:  Center(
              child: Text("STATUS",
                style: TextStyle(color: Colors.white,fontSize: 12.5,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
            ),
          ),

        ]),

        Expanded(child:  ListView.builder(
            padding: EdgeInsets.only(top: 2),
            itemCount: todomodel!.length,
            itemBuilder: (context,index){
              ArticlesToDoLat itemslists = todomodel![index];

              if(itemslists!=null){

                todoimage="meeting.png";
              }

              /*  if(itemslists.act==""){
                  todoimage="meeting.png";
                  isImageLocal=true;
                  isImageNetwork=false;
                }else{
                  todoimage= itemslists.act!;
                  isImageLocal=false;
                  isImageNetwork=true;
                }
              }*/

              return Container(
                margin: EdgeInsets.only(top: 2.5,bottom: 2.5),
                child: Row(children: [

                  /*Visibility(
                    visible: isImageNetwork,
                    child: Container(
                        margin: EdgeInsets.only(left: 15, top:15),
                        width: 40,
                        child: Image.network(todoimage,
                            height: 20, width: 20)),
                  ),*/


                 /* Visibility(
                    visible: isImageLocal,
                    child: Container(
                        margin: EdgeInsets.only(left: 15, top:15),
                        width: 40,
                        child: Image.asset("image/"+todoimage,height: 20, width: 20,)),
                  ),*/

                  Container(
                      margin: EdgeInsets.only(left: 7.5, top:15),
                      width: 40,
                      child: Image.asset("image/"+todoimage,height: 20, width: 20,)),

                  Spacer(),

                  Container(
                    width: 75,
                    margin: EdgeInsets.only(left: 10, top: 10),
                    child:  Center(
                      child: Text(itemslists.customer.toString(),
                        style: TextStyle(color: Colors.white,fontSize: 11.5,),overflow: TextOverflow.ellipsis),
                    ),
                  ),

                  Spacer(),

                  Container(
                    width: 75,
                    margin: EdgeInsets.only(left: 5, top: 10),
                    child:  Center(
                      child: Text(itemslists.product.toString(),
                        style: TextStyle(color: Colors.white,fontSize: 11.5,),overflow: TextOverflow.ellipsis),
                    ),
                  ),

                  Spacer(),

                  Container(
                    width: 60,
                    margin: EdgeInsets.only(left: 0,right:10, top: 10),
                    child:  Center(
                      child: Text("+"+itemslists.status.toString(),
                        style: TextStyle(color: Colors.blue,fontSize: 11.5,),),
                    ),
                  ),

                ]),
              );
            }
        ),

        )
      ],),
    );
  }

  Future<List <ResultsDash>> getDash() async{

    String newurl=AppNetworkConstants.DASHBOARD;

    print("Dash Board url is : "+newurl);

    var url= Uri.parse(newurl);


    http.Response res = await http.get(url);
    //  List datas= jsonDecode(res.body);

    print("Dash Board response is : "+res.body);

    var datas= jsonDecode(res.body)['results'] as List;

    List<ResultsDash> dashdata = datas.map((data) => ResultsDash.fromJson(data)).toList();


    // print("Dash Response City is : " + dashdata[0].salespercent!);


    return dashdata;
  }

  Future<List <ResultsToggle>> getToggle() async{

    String newurl=AppNetworkConstants.TOGGLE+"?status="+statusid;

    print("Toggle url is : "+newurl);

    var url= Uri.parse(newurl);


    http.Response res = await http.get(url);
    //  List datas= jsonDecode(res.body);

    print("Toggle response is : "+res.body);

    var datas= jsonDecode(res.body)['results'] as List;

    List<ResultsToggle> toggledata = datas.map((data) => ResultsToggle.fromJson(data)).toList();

      status=toggledata[0].statusclock!;


     print("Status from api : " + status.toString());


    return toggledata;
  }

  Future<List <ArticlesToDoLat>> getToDo() async{

    String newurl=AppNetworkConstants.TODOLIST;

    print("To Do LIST url is : "+newurl);

    var url= Uri.parse(newurl);


    http.Response res = await http.get(url);
    //  List datas= jsonDecode(res.body);

    print("To Do LIST response is : "+res.body);

    var datas= jsonDecode(res.body)['articles'] as List;

    List<ArticlesToDoLat> tododata = datas.map((data) => ArticlesToDoLat.fromJson(data)).toList();


    // print("Dash Response City is : " + dashdata[0].salespercent!);


    return tododata;
  }

  Future<List <ResultAlertMeetUpdate>> getAlertMeetUpdate() async{

  //  String newurl = "https://inboundcrm.in/travcrm-dev_2.2/Api/App/nikhil/json_meetupdate.php";

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

   // String newurl = "https://inboundcrm.in/travcrm-dev_2.2/Api/App/nikhil/json_taskupdate.php";

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

}