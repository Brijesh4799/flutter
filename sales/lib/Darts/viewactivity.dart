
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../Apis/apis.dart';
import '../Models/callmodel.dart';
import '../Providers/callprovider.dart';
import 'addcall.dart';
import 'addmeet.dart';
import 'addtask.dart';
import 'calltodaydata.dart';
import 'data.dart';
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


class ViewActST extends StatefulWidget {
  // ItemDetail({required this.itemlist});

  @override
  State createState() => new MyViewActST();
}

class MyViewActST extends State<ViewActST> {

  late SharedPreferences prefs, preflog_in_out;

  GlobalKey<ScaffoldState> _drawerkey = GlobalKey<ScaffoldState>();

  List<ResultsCall>? callmodel;

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


  var statusarr = ["Status", "Scheduled", "Rescheduled", "Held", "Cancelled"];

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
    return  Scaffold(


        body: Padding(
            padding: EdgeInsets.all(0),

            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("image/callbg.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(children: [

                Container(
                  height: 80,
                  margin: EdgeInsets.only(top: 15, bottom: 0),
                  color: Colors.white,
                  child: Container(
                    margin: EdgeInsets.only(top: 20, bottom: 0),
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
                          child: Text("View Activity",
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

                        InkWell(onTap: () {
                          searchDialog(context);
                        },
                          child: Container(
                            margin: EdgeInsets.only(top: 5, left: 12.5),
                            child: Image.asset("image/search.png", height: 35,
                              width: 40,),
                          ),
                        ),

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

                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
                      margin: EdgeInsets.only(top: 0, left: 0, right: 0),


                      child: Row(children: [

                        InkWell(
                          onTap: () {
                            selectFromDateAssign(context);
                          },
                          child: Row(children: [

                            Container(
                              margin: EdgeInsets.only(left: 25),
                              child: Center(
                                child: Text(fromtime,
                                    style: TextStyle(color: Colors.white,
                                        fontSize: 13,
                                        fontFamily: 'BebesNeue',
                                        fontWeight: FontWeight.w700)),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(top: 2.5, left: 5),
                              child: Image.asset(
                                "image/dropdown.png", height: 10, width: 10,),
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
                          margin: EdgeInsets.only(left: 10, right: 20),
                          child: DropdownButtonHideUnderline(

                            child: ButtonTheme(
                              focusColor: Colors.blue,
                              child: ChangeNotifierProvider<CallProvider>(

                                  create: (context) => CallProvider(),

                                  child: Consumer<CallProvider>(
                                      builder: (context, provider, child) {
                                        return DropdownButton(
                                          dropdownColor: Colors.lightBlueAccent,
                                          style: TextStyle(color: Colors.black,
                                              fontSize: 13,
                                              fontFamily: 'BebesNeue',
                                              fontWeight: FontWeight.w700),
                                          // dropdownColor: Colors.grey,
                                          focusColor: Colors.lightBlue,
                                          icon: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.white,
                                          ),
                                          items: statusarr.map((
                                              String itemnames) {
                                            return DropdownMenuItem<String>(

                                                value: itemnames,
                                                child: Text(itemnames,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13,
                                                        fontFamily: 'BebesNeue',
                                                        fontWeight: FontWeight
                                                            .w700))
                                            );
                                          }).toList(),

                                          onChanged: (String? value) {
                                            CallProvider.statustpye = value!;

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

                // Call Api

                getCallWidget()



              ],
              ),
            ))
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
                  itemCount: calltodaydata!.length,
                  itemBuilder: (context, index) {
                    CallTodayData itemslists = calltodaydata![index];

                    if (itemslists.status == "RESCHEDULED") {
                      selectcolorstatus = Color(0xff01579b);
                    }
                    else if (itemslists.status == "SCHEDULED") {
                      selectcolorstatus = Colors.orange;
                    }
                    else if (itemslists.status == "CANCELED") {
                      selectcolorstatus = Colors.red;
                    }
                    else if (itemslists.status == "HELD") {
                      selectcolorstatus = Colors.lightGreen;
                    }

                    if(itemslists.whatsappno==""){
                      isCall=false;
                      isWhatsapp=false;
                    }else{
                      isCall=true;
                      isWhatsapp=true;
                    }

                    return Container(
                      margin: EdgeInsets.only(bottom: 7.5),
                      height: 80,
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
                            width: 150,
                            child: Text(itemslists.name.toString(),
                              style: TextStyle(color: Colors.black,
                                  fontSize: 11,
                                  fontFamily: 'BebesNeue',
                                  fontWeight: FontWeight.w700),),
                          ),


                          Spacer(),

                          Container(
                            margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                            child: Center(
                              child: Text(itemslists.date.toString()+"  "+itemslists.time.toString(),
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                    fontFamily: 'BebesNeue',
                                    fontWeight: FontWeight.w700),),
                            ),
                          ),

                        ]),

                        Row(children: [

                          Container(
                            margin: EdgeInsets.only(
                                left: 10, top: 10),
                            width: 150,
                            child: Text(itemslists.company.toString(),
                              style: TextStyle(color: Colors.grey,
                                  fontSize: 10,
                                  fontFamily: 'BebesNeue',
                                  fontWeight: FontWeight.w700),),
                          ),

                          Spacer(),

                          Container(
                            width: 90,
                            padding: EdgeInsets.only(
                                top: 2.5, bottom: 2.5),
                            margin: EdgeInsets.only(
                                left: 10, right: 10, top: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(2.5)),
                              color: selectcolorstatus,
                            ),
                            child: Center(
                              child: Text(itemslists.status.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontFamily: 'BebesNeue',
                                    fontWeight: FontWeight.w700),),
                            ),
                          ),


                        ]),

                        Row(children: [

                          Container(
                            margin: EdgeInsets.only(
                                left: 10, top: 5),
                            child: Text("Agenda:",
                              style: TextStyle(color: Colors.grey,
                                  fontSize: 9,
                                  fontFamily: 'BebesNeue',
                                  fontWeight: FontWeight.w700),),
                          ),

                          Container(
                            margin: EdgeInsets.only(
                                left: 2.5, top: 5),
                            width: 65,
                            child: Text(itemslists.agenda.toString(),
                              style: TextStyle(color: Colors.grey,
                                  fontSize: 9,
                                  fontFamily: 'BebesNeue',
                                  fontWeight: FontWeight.w700),),
                          ),

                          Container(
                            width: 80,
                            margin: EdgeInsets.only(
                                left: 40, right: 0, top: 5),
                            child: Center(
                              child: Text(itemslists.whatsappno.toString(),
                                  style: TextStyle(color: Colors.grey,
                                      fontSize: 9,
                                      fontFamily: 'BebesNeue',
                                      fontWeight: FontWeight.w700),maxLines: 1),
                            ),
                          ),

                          Visibility(
                            visible:isCall,
                            child: InkWell(
                              onTap:(){
                                callnumber=itemslists.whatsappno.toString();
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
                                 whatsappnumber=itemslists.whatsappno.toString();
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

  Future<List <ResultsCall>> getCall() async{

    String newurl=AppNetworkConstants.CALLS;

    print("Call url is : "+newurl);

    var url= Uri.parse(newurl);


    http.Response res = await http.get(url);
    //  List datas= jsonDecode(res.body);

    print("Call response is : "+res.body);

    var datas= jsonDecode(res.body)['results'] as List;

    List<ResultsCall> dashdata = datas.map((data) => ResultsCall.fromJson(data)).toList();


    // print("Dash Response City is : " + dashdata[0].salespercent!);


    return dashdata;
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