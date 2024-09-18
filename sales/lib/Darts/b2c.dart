
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:salescrm/Models/b2cmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../Apis/apis.dart';
import '../Models/allusersmodel.dart';
import '../Models/callmodel.dart';
import '../Providers/callprovider.dart';
import 'addcall.dart';
import 'addmeet.dart';
import 'addtask.dart';
import 'calltodaydata.dart';
import 'data.dart';
import 'expensedata.dart';
import 'items.dart';


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


class B2CST extends StatefulWidget {
  // ItemDetail({required this.itemlist});

  @override
  State createState() => new MyB2CST();
}

class MyB2CST extends State<B2CST> {

  late SharedPreferences prefs, preflog_in_out;

  GlobalKey<ScaffoldState> _drawerkey = GlobalKey<ScaffoldState>();

  List<ResultsB2c>? b2cmodel;

  List<ArticlesUsers>? allusermodels;
  late ArticlesUsers selectedUser;
  String m_userid="37";
  String m_username="";
  int mypos=0;

  List<Color> colorList = [Color(0xffffc107), Colors.green, Color(0xff00E5FF)];

  Color selectcolorstatus = Color(0xff01579b);

  String select = "Today";
  Color selectcolortoday = Color(0xff00E5FF);
  Color selectcolortomorrow = Colors.black54;
  Color selectcolordate = Colors.black54;
  bool isTodayLine = true;
  bool isTomorrowLine = false;
  bool isDateLine = false;

  DateTime fromselectedDate = DateTime.now();
  static String fromtime = DateFormat('dd-MMM-yyyy').format(DateTime.now());

  String todaytime = DateFormat('dd-MMM-yyyy').format(DateTime.now());

  String fromtimefilter = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String totimefilter = DateFormat('dd-MM-yyyy').format(DateTime.now().add(Duration(days: 1)));


  var businessarr = ["All Business Type", "Agent", "Corporate", "Employee", "Local Agent","UAE Parner"];

  var assignarr = ["All Assigned Users", "Praveen Kumar", "Advik Jain", "Mahendra Soni", "Nikhil Agarwal"];

  bool isWhatsapp=true;
  bool isCall=true;
  String callnumber="";
  String whatsappnumber="";

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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllPlane();
    isFeedBackClickActivity = true;
    activityvalue = "4";
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
    //  getMyLoginValue();

  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("image/callbg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(children: [

              Container(
                height: 75,
                margin: EdgeInsets.only(top: 0, bottom: 0),
                color: Colors.white,
                child: Container(
                  margin: EdgeInsets.only(top: 0, bottom: 0),
                  padding: EdgeInsets.only(bottom: 20, top: 0),
                  child: Row(
                    children: [

                      InkWell(
                        onTap:(){
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 5, left: 15),
                          child: Image.asset(
                            "image/back.png", height: 20, width: 25,),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 5, left: 15, right: 20),
                        child: Text("B2C",
                          style: TextStyle(color: Colors.blue,
                              fontSize: 20,
                              fontFamily: 'BebesNeue',
                              fontWeight: FontWeight.w700),),
                      ),

                      Spacer(),

                      Container(
                        margin: EdgeInsets.only(top: 12, left: 0, right: 0),
                        child: Text("",
                          style: TextStyle(color: Colors.blue,
                              fontSize: 22,
                              fontFamily: 'BebesNeue',
                              fontWeight: FontWeight.w700),),
                      ),

                     /* InkWell(onTap: () {
                        searchDialog(context);
                      },
                        child: Container(
                          margin: EdgeInsets.only(top: 5, left: 12.5),
                          child: Image.asset("image/search.png", height: 35,
                            width: 40,),
                        ),
                      ),*/

                      Container(
                        margin: EdgeInsets.only(top: 5, right: 12.5),
                        child: Image.asset(
                          "image/bellicon.png", height: 35, width: 40,),
                      )
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
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),),
                    ),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
                    margin: EdgeInsets.only(top: 0, left: 0, right: 0),
                    child: Row(children: [

                      Container(),

                      Spacer(),

                      FutureBuilder(
                          future: getAllUsers(),
                          builder:(context,  snapshot) {

                            if(snapshot.hasData) {

                              allusermodels= snapshot.data as List<ArticlesUsers>?;

                              selectedUser = allusermodels![mypos];
                              print("Position : "+mypos.toString());

                              return  Container(
                                alignment: Alignment.center,
                                //  padding: EdgeInsets.only(top: 20,bottom: 20,left: 20,right: 20),
                                width: 140.0,
                                height: 35.0,
                                margin: EdgeInsets.only(left: 10, right: 25),
                                child: DropdownButtonHideUnderline(

                                  child: ButtonTheme(
                                    focusColor: Colors.blue,
                                    child: ChangeNotifierProvider<CallProvider>(

                                        create: (context) => CallProvider(),

                                        child: Consumer<CallProvider>(
                                            builder: (context, provider, child) {
                                              return  DropdownButton(
                                                dropdownColor: Colors.lightBlueAccent,
                                                focusColor: Colors.blue,

                                                value: selectedUser,
                                                icon: Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: Colors.white,
                                                ),
                                                items: allusermodels!.map((ArticlesUsers user) {
                                                  return DropdownMenuItem<ArticlesUsers>(
                                                      value: user,
                                                      child: Text( user.username.toString(),textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 13,
                                                          fontFamily: 'BebesNeue',
                                                          fontWeight: FontWeight.w700),)
                                                  );
                                                }).toList(),


                                                onChanged: (ArticlesUsers? user) {

                                                  mypos=allusermodels!.indexOf(user!);
                                                  selectedUser = user!;
                                                  m_username=user!.username.toString();
                                                  m_userid=user!.id.toString();

                                                  //  PickersResultTargetProvider.username=user!.username.toString();
                                                  provider.selectUser(m_username,m_userid,selectedUser,mypos);

                                                  setState(() {

                                                  });

                                                  //  print("User Name is : "+m_username+" and User ID is : "+m_userid);
                                                },
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
                              );


                            }

                            return Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(right: 50),
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  value: 0.8,
                                )
                            );
                          }
                      ),



                    ],
                    ),

                  ),
                ],

                ),
              ),

              // Call Api

              Expanded(
                child: Column(
                  children: [
                    Container(
                      child:  FutureBuilder(
                          future: getB2C(),
                          builder:(context, snapshot) {

                            if(snapshot.hasData) {

                              b2cmodel= snapshot.data as List<ResultsB2c>?;

                              return getCallWidget();


                            }

                            return SizedBox(
                              height: 10,
                            );
                          }
                      ),
                    ),
                  ],
                ),
              )





            ],
            ),
          )
      ),
    );
  }


  Widget getCallWidget(){
    return  Expanded(

      child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
              left: 10, right: 10, top: 20, bottom: 10),
          //height: 275,

          padding: EdgeInsets.only(
              left: 10, right: 10, top: 0, bottom: 15),


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

              Expanded(child: ListView.builder(
                  padding: EdgeInsets.only(top: 15),
                  itemCount: b2cmodel!.length,
                  itemBuilder: (context, index) {
                    ResultsB2c itemslists = b2cmodel![index];

                    if(itemslists.phone==""){
                      isCall=false;
                      isWhatsapp=false;
                    }else{
                      isCall=true;
                      isWhatsapp=true;
                    }

                    return Container(
                      margin: EdgeInsets.only(bottom: 7.5),
                      height: 85,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2.5),

                        //  color: Colors.deepOrange,


                      ),
                      child: Column(children: [

                        Container(height: 2,
                          margin: EdgeInsets.only(
                              left: 5, right: 5),
                          width: MediaQuery.of(context).size.width,
                          color: Color(0xff00E5FF),),

                        Row(children: [

                          Container(
                            margin: EdgeInsets.only(
                                left: 10, top: 10),
                            width: 170,
                            child: Text(itemslists.salesperson.toString(),maxLines: 1,
                              style: TextStyle(color: Colors.black,
                                  fontSize: 11,
                                  fontFamily: 'BebesNeue',
                                  fontWeight: FontWeight.w700),),
                          ),


                          Spacer(),

                          Container(
                            margin: EdgeInsets.only(left: 10, right: 15, top: 5),
                            child: Center(
                              child: Text(itemslists.email.toString(),
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 9,
                                    fontFamily: 'BebesNeue',
                                    fontWeight: FontWeight.w700),),
                            ),
                          ),

                        ]),



                        Row(children: [

                          Container(
                            margin: EdgeInsets.only(left: 10, top: 0),
                            width: 120,
                            child: Text(itemslists.address.toString(),maxLines: 3,
                              style: TextStyle(color: Colors.grey,
                                  fontSize: 9,
                                  fontFamily: 'BebesNeue',
                                  fontWeight: FontWeight.w700),),
                          ),

                          Spacer(),

                          Container(
                            margin: EdgeInsets.only(
                                top: 0, left: 0,right: 10),
                            child: Image.asset("image/viewbc.png", height: 45, width: 45,),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 0, right: 10, top: 0),
                            child: Column(children: [


                              Container(

                                margin: EdgeInsets.only(left: 10, right: 0, top: 10),
                                child: Center(
                                  child: Text(itemslists.phone.toString(),
                                      style: TextStyle(color: Colors.grey,
                                          fontSize: 10,
                                          fontFamily: 'BebesNeue',
                                          fontWeight: FontWeight.w700),maxLines: 1),
                                ),
                              ),

                              Row(children: [

                                Visibility(
                                  visible:isCall,
                                  child: InkWell(
                                    onTap:(){
                                      callnumber=itemslists.phone.toString();
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
                                      whatsappnumber=itemslists.phone.toString();
                                      print("pick whatsapp no is : $whatsappnumber");
                                      _makingWhatsapp();
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: 5, left: 20),
                                      child: Image.asset(
                                        "image/whatsapp.png", height: 20,
                                        width: 20,),
                                    ),
                                  ),
                                ),
                              ],),

                            ]),
                          ),

                        ],
                        ),



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

  selectFromDateAssign(BuildContext context,) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: fromselectedDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2025));

    if (picked != null && picked != fromselectedDate) {
      setState(() {
        fromtime = DateFormat('dd-MMM-yyyy').format(picked);
        print("from time prickers : " + fromtime);
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
                            child: Text("View Activity",
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
                                      getAllPlane();
                                      isFeedBackClickActivity = true;
                                      activityvalue = "4";
                                      print("Activity value is $activityvalue");
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 15),
                                    child: Image.asset("image/" + allplane, height: 16, width: 16,),
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
                                fromtimefilter =
                                    DateFormat('dd-MM-yyyy').format(picked);
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

  Future<List <ResultsB2c>> getB2C() async{

 //   String newurl="https://inboundcrm.in/travcrm-dev_2.2/Api/App/SALES/json_b2c.php?userid="+m_userid;

    String newurl= AppNetworkConstants.B2C+"?userid="+m_userid;

    print("B2C url is : "+newurl);

    var url= Uri.parse(newurl);


    http.Response res = await http.get(url);
    //  List datas= jsonDecode(res.body);

    print("B2C response is : "+res.body);

    var datas= jsonDecode(res.body)['results'] as List;

    List<ResultsB2c> dashdata = datas.map((data) => ResultsB2c.fromJson(data)).toList();


    if(dashdata.length==0) {
      Fluttertoast.showToast(
          msg: "No Data Available Now",
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

  Future<List <ArticlesUsers>> getAllUsers() async{

   // String newurl="https://travcrm.in/travcrm-dev_2.2/Api/App/SALES/json_allusername.php";

    String newurl=AppNetworkConstants.all_user_url;

    print("All User Url is : "+ newurl.toString());


    var url= Uri.parse(newurl);

    http.Response res = await http.get(url);

    print("All Users Response is : "+ res.body);

    var datas= jsonDecode(res.body)['articles'] as List;

    List<ArticlesUsers> agentdata = datas.map((data) => ArticlesUsers.fromJson(data)).toList();

    return agentdata;
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