
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:salescrm/Darts/addexpense.dart';
import 'package:salescrm/Darts/expensedata.dart';
import 'package:salescrm/Models/addexpmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Apis/apis.dart';
import '../Models/expmodel.dart';
import '../Providers/callprovider.dart';
import 'addcall.dart';
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


class ExpenseST extends StatefulWidget {
  // ItemDetail({required this.itemlist});

  @override
  State createState() => new MyExpenseST();
}

class MyExpenseST extends State<ExpenseST> {

  String imgurl="https://inboundcrm.in/travcrm-dev_2.2/dirfiles/1682594470-images.jpg";

  bool isQoutesimg=true;
  bool isNotQuotesimg=false;

  String? attachment="";

  late SharedPreferences prefs, preflog_in_out;

  GlobalKey<ScaffoldState> _drawerkey = GlobalKey<ScaffoldState>();

  List<ResultsExp>? expmodel;
  
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

  GlobalKey<FormState> formkeyall = GlobalKey<FormState>();

  var typeController = TextEditingController();
  var typeup = "";

  var amtController = TextEditingController();
  var amtup = "";

  String? typeValidate(String? value) {
    if (value == null || value.isEmpty)
      return 'Enter a Expense Type';
    else
      typeup = value;
    print("Expense Type : " + typeup);
    return null;
  }

  String? amountValidate(String? value) {
    if (value == null || value.isEmpty)
      return 'Enter a Amount';
    else
      amtup = value;
    print("Amount : " + amtup);
    return null;
  }


  var statusarr = ["Status", "Scheduled", "Rescheduled", "Held", "Cancelled"];

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
    getCallPlane();
    isFeedBackClickActivity = true;
    activityvalue = "1";
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
    return Scaffold(


        body: Container(
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
                      margin: EdgeInsets.only(top: 2.5, left: 20,),
                      child: Text("Expense",
                        style: TextStyle(color: Colors.blue,
                            fontSize: 20,
                            fontFamily: 'BebesNeue',
                            fontWeight: FontWeight.w700),),
                    ),

                    Spacer(),

                   /* InkWell(onTap: () {
                      searchDialog(context);
                    },
                      child: Container(
                        margin: EdgeInsets.only(top: 2.5, right: 15),
                        child: Image.asset("image/search.png", height: 35,
                          width: 40,),
                      ),
                    ),*/
                  ],

                ),
              ),
            ),


            Expanded(

              child: Container(width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
                //height: 275,
                padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 15),


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

                // Expense Api

                child:  FutureBuilder(
                    future: getExp(),
                    builder:(context, snapshot) {

                      if(snapshot.hasData) {
                        expmodel= snapshot.data as List<ResultsExp>;
                        return getExpWidget();

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
            ),

            SizedBox(height: 5,),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Container(
                  margin: EdgeInsets.only(right: 15),
                  child: FloatingActionButton(
                      child: Icon(Icons.add),
                      backgroundColor: Colors.blue,
                      onPressed: (){
                      //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddExpenseST()));
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddExpenseST()),).then((value) =>{ getUpdate()});
                        print("click");

                      }),
                ),
              ],
            ),

            SizedBox(height: 15,)

          ],
          ),
        )
    );
  }


  Widget getExpWidget(){
    return  Column(
      children: [

        Expanded(child: ListView.builder(
            padding: EdgeInsets.only(top: 15),
            itemCount: expmodel!.length,
            itemBuilder: (context, index) {
              ResultsExp itemslists = expmodel![index];

              if (itemslists.status == "Approved") {
                selectcolorstatus = Colors.lightGreen;
              }
              else if (itemslists.status == "Pending") {
                selectcolorstatus = Colors.orange;
              }
              else if (itemslists.status == "Rejected") {
                selectcolorstatus = Colors.red;
              }

              var myString = itemslists.attachment.toString();
              if (myString.length > 0) {
                var output = myString[myString.length - 1];
                print('Last character : $output');

                if(output=="'"){
                  isQoutesimg=true;
                  isNotQuotesimg=false;
                  print("Quotes is Visible");
                }else{
                  isQoutesimg=false;
                  isNotQuotesimg=true;
                  print("Quotes is not Visible");
                }

              } else {
                print('Empty string, please check by me.');
                print("No Attachment");

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

                  Container(
                    height: 2,
                    margin: EdgeInsets.only(left: 5, right: 5),
                    width: MediaQuery.of(context).size.width,
                    color: Color(0xff00E5FF),),

                  Row(children: [

                    Container(
                      margin: EdgeInsets.only(left: 10, top: 10),
                      child: Text("#"+itemslists.id.toString(),
                        style: TextStyle(color: Colors.black,
                            fontSize: 13,
                            fontFamily: 'BebesNeue',
                            fontWeight: FontWeight.w700),),
                    ),

                    Container(
                      width: 70,
                      padding: EdgeInsets.only(
                          top: 5, bottom: 5),
                      margin: EdgeInsets.only(
                          left: 10, right: 10, top: 10),
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


                    Spacer(),

                    Container(
                      margin: EdgeInsets.only(right: 10, top: 10),
                      child: Text(itemslists.expenseDate.toString(),
                        style: TextStyle(color: Colors.grey,
                            fontSize: 12,
                            fontFamily: 'BebesNeue',
                            fontWeight: FontWeight.w700),),
                    ),

                  ]),

                  Row(children: [

                    Container(
                      margin: EdgeInsets.only(left: 10, top: 10),
                      child: Text(itemslists.type.toString(),
                        style: TextStyle(color: Colors.blue,
                            fontSize: 12,
                            fontFamily: 'BebesNeue',
                            fontWeight: FontWeight.w700),),
                    ),

                    Container(
                      margin: EdgeInsets.only(left: 7.5,right: 7.5,top: 10),
                      height: 15,width: 1,color: Colors.black,),

                    InkWell(
                      onTap:(){
                        attachment=itemslists.attachment.toString();
                        print("Attachment is : $attachment");
                        if(attachment==""){
                          Fluttertoast.showToast(
                              msg: "No Attachment",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 4,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 12.0
                          );
                        }else{
                          imgDialog(context);
                        }
                      },
                      child: Container(
                        color: Colors.blue,
                        margin: EdgeInsets.only(top: 10,left: 5),
                        padding: EdgeInsets.only(left: 10, top: 5,bottom: 5,right: 10),
                        child: Text("Attachment",
                            style: TextStyle(color: Colors.white,
                                fontSize: 11,
                                fontFamily: 'BebesNeue',
                                fontWeight: FontWeight.w700),maxLines: 1),
                      ),
                    ),


                    Spacer(),

                    Container(
                      margin: EdgeInsets.only(right: 10, top: 5),
                      child: Text("₹"+itemslists.expenseAmount.toString(),
                        style: TextStyle(color: Colors.lightBlueAccent,
                            fontSize: 14,
                            fontFamily: 'BebesNeue',
                            fontWeight: FontWeight.w700),),
                    ),

                  ]),


                ],),
              );
            }
        ),

        )


      ],

    );
  }



  Future<List <ResultsExp>> getExp() async{

    String newurl=AppNetworkConstants.EXPENSE;

  //  String newurl="https://inboundcrm.in/travcrm-dev_2.2/Api/App/SALES/json_expense.php";

    print("Expense url is : "+newurl);

    var url= Uri.parse(newurl);


    http.Response res = await http.get(url);
    //  List datas= jsonDecode(res.body);

    print("Expense response is : "+res.body);

    var datas= jsonDecode(res.body)['results'] as List;

    List<ResultsExp> dashdata = datas.map((data) => ResultsExp.fromJson(data)).toList();


    // print("Dash Response City is : " + dashdata[0].salespercent!);


    return dashdata;
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

                      // Activity Period

                      Form(
                        key: formkeyall,
                        child: Column(children: [

                          SizedBox(height: 10,),


                          Row(children: [

                            Container(
                              margin: EdgeInsets.only(left: 15, top: 10),
                              child:  Text("Expense Type",
                                style: TextStyle(color: Colors.blue,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                            ),


                          ]),

                          SizedBox(height: 15,),

                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 30,
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(
                              // textAlign: TextAlign.center,
                              controller: typeController,
                              validator: typeValidate,
                              style: TextStyle(color: Colors.blue,fontSize: 13,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                              maxLines: 1,
                              decoration: InputDecoration(
                                hintText: "Type",

                              ),
                            ),
                          ),


                          SizedBox(height: 10,),


                          Row(children: [

                            Container(
                              margin: EdgeInsets.only(left: 15, top: 10),
                              child:  Text("Amount",
                                style: TextStyle(color: Colors.blue,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                            ),


                          ]),

                          SizedBox(height: 15,),


                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 30,
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(
                              keyboardType:TextInputType.number,
                              // textAlign: TextAlign.center,
                              controller: amtController,
                              validator: amountValidate,
                              style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                              maxLines: 1,
                              decoration: InputDecoration(
                                hintText: "Amount",

                              ),
                            ),
                          ),

                          SizedBox(height: 15,),


                          InkWell(
                            onTap: (){
                             dateDialog(context);
                            },
                            child: Row(children: [

                              Container(
                                margin: EdgeInsets.only(left: 15, top: 15),
                                child: Text("Select Peroid",
                                    style: TextStyle(color: Colors.blue,
                                      fontSize: 11,
                                      fontFamily: 'BebesNeue',
                                  fontWeight: FontWeight.w700,)),
                              ),

                            ],),
                          ),

                          SizedBox(height: 5,),


                          Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            color: Colors.grey,
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                          ),


                        ],),
                      ),


                      SizedBox(height: 15,),


                      ElevatedButton(
                        onPressed: () {

                         // validatdationAll();


                          if (formkeyall.currentState!.validate()) {
                            print("OK");
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
                            print("Error");
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

  imgDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) =>
                AlertDialog(

                  actions: [

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: isQoutesimg,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 250,
                           // margin: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 10),
                            child:  Image.network(attachment.toString(),
                              // width: 280.0,
                            ),
                          ),
                        ),

                        Visibility(
                          visible: isNotQuotesimg,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 250,
                           // margin: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 10),
                            child:  Image.network(attachment.toString(),
                              // width: 280.0,
                            ),
                          ),
                        ),
                      ],
                    )
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


  void validatdationAll() {
    if (formkeyall.currentState!.validate()) {
      print("OK");
      // getUpdateProfile();
      //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyBottomNavigationBar()));
    } else {
      print("Error");
    }
  }

  void getUpdate(){
    setState(() {

    });
  }
}