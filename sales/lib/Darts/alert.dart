
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salescrm/Darts/alertmeetdetail.dart';
import 'package:salescrm/Darts/alertoverduedetail.dart';
import 'package:salescrm/Darts/alertpaydetail.dart';
import 'package:salescrm/Models/alertduemodel.dart';
import 'package:salescrm/Models/alertpaymodel.dart';
import 'package:salescrm/Models/alerttaskmodel.dart';
import 'package:salescrm/Models/itemodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Apis/apis.dart';
import '../Models/alertmeetmodel.dart';
import '../Models/callmodel.dart';
import 'alerttaskdetail.dart';
import 'data.dart';
import 'expensedata.dart';
import 'items.dart';


class AlertST extends StatefulWidget {
  // ItemDetail({required this.itemlist});

  @override
  State createState() => new MyAlertST();
}

class MyAlertST extends State<AlertST> {

  late SharedPreferences prefid, prefname, prefdate;

  List<ResultsAlertPay>? alertpaymodel;
  List<ResultsAlertMeet>? alertmeetmodel;
  List<ResultsAlertTask>? alerttaskmodel;
  List<JsonResultAlertDue>? alertduemodel;

  String payimgcolor="paycolor.png";
  String payarrowcolor="payarrow.png";
  String meetimgcolor="meetcolor.png";
  String meetarrowcolor="meetarrow.png";
  String taskimgcolor="taskcolor.png";
  String taskarrowcolor="taskarrow.png";
  String overdueimgcolor="overduecolor.png";
  String overduearrowcolor="overduearrow.png";

  Color selectcolorpayment = Color(0xff29c9a0);
  Color selectcolormeeting = Color(0xffffb031);
  Color selectcolortask = Color(0xff14a8ff);
  Color selectcoloroverdue = Color(0xff9d88f0);

  Color selectcolorpaymenttext = Colors.white;
  Color selectcolormeetingtext = Color(0xff868585);
  Color selectcolortasktext = Color(0xff868585);
  Color selectcolorovertext = Color(0xff868585);

  bool isPayActive = true;
  bool isMeetActive = false;
  bool isTaskActive = false;
  bool isOverdueActive = false;

  getColorPay(){
    setState(() {
       isPayActive = true;
       isMeetActive = false;
       isTaskActive = false;
       isOverdueActive = false;

        selectcolorpayment = Color(0xff29c9a0);
        selectcolormeeting = Colors.white;
        selectcolortask = Colors.white;
        selectcoloroverdue = Colors.white;

        selectcolorpaymenttext = Colors.white;
        selectcolormeetingtext = Color(0xff868585);
        selectcolortasktext = Color(0xff868585);
        selectcolorovertext = Color(0xff868585);

        print("isSelect payment is true");
    });
  }

  getColorMeet(){
    setState(() {
      isPayActive = false;
      isMeetActive = true;
      isTaskActive = false;
      isOverdueActive = false;

      selectcolorpayment = Colors.white;
      selectcolormeeting = Color(0xffffb031);
      selectcolortask = Colors.white;
      selectcoloroverdue = Colors.white;

      selectcolorpaymenttext = Color(0xff868585);
      selectcolormeetingtext = Colors.white;
      selectcolortasktext = Color(0xff868585);
      selectcolorovertext = Color(0xff868585);

      print("isSelect meeting is true");
    });
  }

  getColorTask(){
    setState(() {
      isPayActive = false;
      isMeetActive = false;
      isTaskActive = true;
      isOverdueActive = false;

      selectcolorpayment = Colors.white;
      selectcolormeeting = Colors.white;
      selectcolortask = Color(0xff14a8ff);
      selectcoloroverdue = Colors.white;

      selectcolorpaymenttext = Color(0xff868585);
      selectcolormeetingtext = Color(0xff868585);
      selectcolortasktext = Colors.white;
      selectcolorovertext = Color(0xff868585);


      print("isSelect Task is true");
    });
  }

  getColorOverdue(){
    setState(() {
      isPayActive = false;
      isMeetActive = false;
      isTaskActive = false;
      isOverdueActive = true;

      selectcolorpayment = Colors.white;
      selectcolormeeting = Colors.white;
      selectcolortask = Colors.white;
      selectcoloroverdue = Color(0xff9d88f0);

      selectcolorpaymenttext = Color(0xff868585);
      selectcolormeetingtext = Color(0xff868585);
      selectcolortasktext = Color(0xff868585);
      selectcolorovertext = Colors.white;

      print("isSelect task is true");
    });
  }

  Color getcolorpaymentext = Color(0xff29c9a0);
  Color getcolormeetingtext = Color(0xffffb031);
  Color gettcolortasktext = Color(0xff14a8ff);
  Color getcolortasktext = Color(0xff9d88f0);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getColorPay();

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
                        child: Text("Alerts",
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


                      Container(
                        margin: EdgeInsets.only(top: 5, right: 12.5),
                        child: Image.asset(
                          "image/bell.png", height: 35, width: 40,),
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
                    height: 35,
                    padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
                    margin: EdgeInsets.only(top: 0, left: 0, right: 0),
                    child: Row(children: [

                    ],
                    ),

                  ),
                ],

                ),
              ),


              Container(
                height: 30,
                margin: EdgeInsets.only(left: 10,top: 20,right: 10,),
                child: Row(children: [

                  // Payment

                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap:() {
                        getColorPay();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectcolorpayment,

                          borderRadius: BorderRadius.only(topLeft: Radius.circular(5)),
                        ),
                        // color: Color(0xff29c9a0),
                        width: 80,
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Container(
                              margin: EdgeInsets.only(left: 10, right: 0, top: 5),
                              child: Center(
                                child: Text("PAYMENT",
                                  style: TextStyle(
                                      color: selectcolorpaymenttext,
                                      fontSize: 10,
                                      fontFamily: 'BebesNeue',
                                      fontWeight: FontWeight.w700),),
                              ),
                            ),

                            Container(
                              width: 16,
                              height: 16,
                              margin: EdgeInsets.only(left: 1,bottom: 7.5),
                              padding: EdgeInsets.only(top: 1,bottom: 1,left: 1,right: 1),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color:  selectcolorpaymenttext,
                                  //                   <--- border color
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text("9",
                                    style: TextStyle(color: Colors.black,
                                        fontSize:8,
                                        fontFamily: 'BebesNeue',
                                        fontWeight: FontWeight.w700),maxLines: 2),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  Container(
                    color: Color(0xff868585),
                  //  height: 20,
                    width: .5,
                  ),

                  // Meeting
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: (){
                        getColorMeet();
                      },
                      child: Container(
                        color: selectcolormeeting,
                        width: 80,
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 0, top: 5),
                              child: Center(
                                child: Text("MEETING",
                                  style: TextStyle(
                                      color: selectcolormeetingtext,
                                      fontSize: 10,
                                      fontFamily: 'BebesNeue',
                                      fontWeight: FontWeight.w700),),
                              ),
                            ),

                            Container(
                              width: 16,
                              height: 16,
                              margin: EdgeInsets.only(left: 1,bottom: 7.5),
                              padding: EdgeInsets.only(top: 1,bottom: 1,left: 1,right: 1),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: selectcolormeetingtext,
                                  //                   <--- border color
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text("7",
                                    style: TextStyle(color: Colors.black,
                                        fontSize:8,
                                        fontFamily: 'BebesNeue',
                                        fontWeight: FontWeight.w700),maxLines: 2),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  Container(
                    color: Color(0xff868585),
                   // height: 20,
                    width: .5,
                  ),

                  // Task
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: (){
                        getColorTask();
                      },
                      child: Container(
                        color: selectcolortask,
                        width: 80,
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 0, top: 5),
                              child: Center(
                                child: Text("TASK",
                                  style: TextStyle(
                                      color: selectcolortasktext,
                                      fontSize: 10,
                                      fontFamily: 'BebesNeue',
                                      fontWeight: FontWeight.w700),),
                              ),
                            ),

                            Container(
                              width: 16,
                              height: 16,
                              margin: EdgeInsets.only(left: 1,bottom: 7.5),
                              padding: EdgeInsets.only(top: 1,bottom: 1,left: 1,right: 1),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: selectcolortasktext,
                                  //                   <--- border color
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text("8",
                                    style: TextStyle(color: Colors.black,
                                        fontSize:8,
                                        fontFamily: 'BebesNeue',
                                        fontWeight: FontWeight.w700)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  Container(
                    color: Color(0xff868585),
                   // height: 20,
                    width: .5,
                  ),

                  // Overdue
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: (){
                        getColorOverdue();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectcoloroverdue,

                          borderRadius: BorderRadius.only(topRight: Radius.circular(5)),
                        ),
                        //  color: Color(0xff29c9a0),
                        width: 80,
                        height: 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 0, top: 5),
                              child: Center(
                                child: Text("OVERDUE",
                                  style: TextStyle(
                                      color: selectcolorovertext,
                                      fontSize: 10,
                                      fontFamily: 'BebesNeue',
                                      fontWeight: FontWeight.w700),),
                              ),
                            ),

                            Container(
                              width: 16,
                              height: 16,
                              margin: EdgeInsets.only(left: 1,bottom: 7.5),
                              padding: EdgeInsets.only(top: 1,bottom: 1,left: 1,right: 1),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: selectcolorovertext,
                                  //                   <--- border color
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text("6",
                                    style: TextStyle(color: Colors.black,
                                        fontSize:8,
                                        fontFamily: 'BebesNeue',
                                        fontWeight: FontWeight.w700)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                ],),
              ),

              // Call Api

              //Payment
              Visibility(
                visible: isPayActive,
                  child: FutureBuilder(
                      future: getAlertsPay(),
                      builder:(context,  snapshot) {

                        if(snapshot.hasData) {

                          alertpaymodel = snapshot.data as List<ResultsAlertPay>?;

                          return getPayWidget();
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

              // Meeting
              Visibility(
                visible: isMeetActive,
                child: FutureBuilder(
                    future: getAlertsMeet(),
                    builder:(context,  snapshot) {

                      if(snapshot.hasData) {

                        alertmeetmodel = snapshot.data as List<ResultsAlertMeet>?;


                        return getMeetWidget();
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

              // Task
              Visibility(
                visible: isTaskActive,
                child: FutureBuilder(
                    future: getAlertsTask(),
                    builder:(context,  snapshot) {

                      if(snapshot.hasData) {

                        alerttaskmodel = snapshot.data as List<ResultsAlertTask>?;


                        return getTaskWidget();
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

              // Overdue
              Visibility(
                visible: isOverdueActive,
                child: FutureBuilder(
                    future: getAlertsOverDue(),
                    builder:(context,  snapshot) {

                      if(snapshot.hasData) {

                        alertduemodel = snapshot.data as List<JsonResultAlertDue>?;


                        return getOverdueWidget();
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


            ],
            ),
          )
      ),
    );
  }


  Widget getPayWidget(){
    return  Expanded(

      child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
              left: 10, right: 10, top: 0, bottom: 10),
          //height: 275,

          padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 15),


          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5)),
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
                  itemCount: alertpaymodel!.length,
                  itemBuilder: (context, index) {
                  ResultsAlertPay itemslists = alertpaymodel![index];

                    if(itemslists.showid=="0"){
                      getcolorpaymentext=Color(0xff29c9a0);
                      payimgcolor="paycolor.png";
                      payarrowcolor="payarrow.png";
                    }else{
                      getcolorpaymentext=Color(0xff868585);
                      payimgcolor="paybw.png";
                      payarrowcolor="alertarrow.png";
                    }

                    return Container(
                      margin: EdgeInsets.only(bottom: 7.5),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),

                        //  color: Colors.deepOrange,


                      ),
                      child: Column(children: [

                        Row(children: [

                          Container(
                            margin: EdgeInsets.only(top: 5, left: 10),
                            child: Image.asset(
                              "image/"+payimgcolor, height: 40,
                              width: 35,),
                          ),

                          Container(
                            width:167.5,
                            margin: EdgeInsets.only(top: 5, left: 7.5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Container(
                                  margin: EdgeInsets.only(
                                      left: 0, top: 0),

                                  child: Text(itemslists.tripId.toString(),
                                    style: TextStyle(color: getcolorpaymentext,
                                        fontSize: 11,
                                        fontFamily: 'BebesNeue',
                                        fontWeight: FontWeight.w700),maxLines: 1),
                                ),

                                Container(
                                  margin: EdgeInsets.only(
                                      left: 0, top: 2.5),

                                  child: Text(itemslists.totalClientCost.toString(),
                                    style: TextStyle(color: getcolorpaymentext,
                                        fontSize: 9,
                                        fontFamily: 'BebesNeue',
                                        fontWeight: FontWeight.w700),),
                                ),
                              ],
                            ),
                          ),

                          Spacer(),

                          Container(
                            margin: EdgeInsets.only(top: 5, left: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [

                                Container(
                                  margin: EdgeInsets.only(
                                      left: 0, top: 0),

                                  child: Text(itemslists.received.toString(),
                                    style: TextStyle(color: getcolorpaymentext.withOpacity(0.4),
                                        fontSize: 9,
                                        fontFamily: 'BebesNeue',
                                        fontWeight: FontWeight.w700),),
                                ),

                                Container(
                                  margin: EdgeInsets.only(
                                      left: 0, top: 2.5),

                                  child: Text(itemslists.pendingCost.toString(),
                                    style: TextStyle(color: getcolorpaymentext,
                                        fontSize: 10.5,
                                        fontFamily: 'BebesNeue',
                                        fontWeight: FontWeight.w700),),
                                ),
                              ],
                            ),
                          ),

                          InkWell(
                            child: Container(
                              margin: EdgeInsets.only(top: 5, left: 5,right: 5),
                              child: Image.asset(
                                "image/"+payarrowcolor, height: 17.5,
                                width: 20,),
                            ),
                            onTap: () async {

                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AlertPayDetailST()),).then((value) =>{ getUpdate()});
                              //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AlertMeetDetailST()));
                              print("is pressed");

                              prefid = await SharedPreferences.getInstance();
                              prefid.setString("id", itemslists.id.toString());
                            },
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

  Widget getMeetWidget(){
    return  Expanded(

      child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
              left: 10, right: 10, top: 0, bottom: 10),
          //height: 275,

          padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 15),


          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5)),
            //  borderRadius: BorderRadius.circular(5),
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
                  itemCount: alertmeetmodel!.length,
                  itemBuilder: (context, index) {
                    ResultsAlertMeet itemslists = alertmeetmodel![index];

                    if(itemslists.show=="0"){
                      getcolorpaymentext=Color(0xffffb031);
                       meetimgcolor="meetcolor.png";
                       meetarrowcolor="meetarrow.png";
                    }else{
                      getcolorpaymentext=Color(0xff868585);
                      meetimgcolor="meetbw.png";
                      meetarrowcolor="alertarrow.png";
                    }

                    return Container(
                      margin: EdgeInsets.only(bottom: 7.5),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),

                        //  color: Colors.deepOrange,


                      ),
                      child: Column(children: [

                        Row(children: [

                          Container(
                            margin: EdgeInsets.only(top: 5, left: 10),
                            child: Image.asset(
                              "image/"+meetimgcolor, height: 40,
                              width: 35,),
                          ),

                          Container(
                            width:167.5,
                            margin: EdgeInsets.only(top: 5, left: 7.5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Container(
                                  margin: EdgeInsets.only(
                                      left: 0, top: 0),

                                  child: Text(itemslists.time.toString(),
                                      style: TextStyle(color: getcolorpaymentext,
                                          fontSize: 11,
                                          fontFamily: 'BebesNeue',
                                          fontWeight: FontWeight.w700),maxLines: 1),
                                ),

                                Container(
                                  margin: EdgeInsets.only(
                                      left: 0, top: 2.5),

                                  child: Text(itemslists.contactPerson.toString(),
                                    style: TextStyle(color: getcolorpaymentext,
                                        fontSize: 9,
                                        fontFamily: 'BebesNeue',
                                        fontWeight: FontWeight.w700),),
                                ),
                              ],
                            ),
                          ),

                          Spacer(),

                          Container(
                            margin: EdgeInsets.only(top: 5, left: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [

                                Container(
                                  margin: EdgeInsets.only(
                                      left: 0, top: 0),

                                  child: Text("",
                                    style: TextStyle(color: getcolorpaymentext.withOpacity(0.4),
                                        fontSize: 9,
                                        fontFamily: 'BebesNeue',
                                        fontWeight: FontWeight.w700),),
                                ),

                                Container(
                                  margin: EdgeInsets.only(
                                      left: 0, top: 2.5),

                                  child: Text(itemslists.date.toString(),
                                    style: TextStyle(color: getcolorpaymentext,
                                        fontSize: 10.5,
                                        fontFamily: 'BebesNeue',
                                        fontWeight: FontWeight.w700),),
                                ),
                              ],
                            ),
                          ),

                          InkWell(
                            child: Container(
                              margin: EdgeInsets.only(top: 5, left: 5,right: 5),
                              child: Image.asset(
                                "image/"+meetarrowcolor, height: 17.5,
                                width: 20,),
                            ),
                            onTap: () async {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AlertMeetDetailST()),).then((value) =>{ getUpdate()});
                           //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AlertMeetDetailST()));
                              print("is pressed");

                              prefid = await SharedPreferences.getInstance();
                              prefid.setString("id", itemslists.id.toString());
                            },
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

  Widget getTaskWidget(){
    return  Expanded(

      child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
              left: 10, right: 10, top: 0, bottom: 10),
          //height: 275,

          padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 15),


          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5)),
             // borderRadius: BorderRadius.circular(5),
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
                  itemCount: alerttaskmodel!.length,
                  itemBuilder: (context, index) {
                    ResultsAlertTask itemslists = alerttaskmodel![index];

                    if(itemslists.show=="0"){
                      getcolorpaymentext=Color(0xff14a8ff);
                      taskimgcolor="taskcolor.png";
                      taskarrowcolor="taskarrow.png";
                    }else{
                      getcolorpaymentext=Color(0xff868585);
                      taskimgcolor="taskbw.png";
                      taskarrowcolor="alertarrow.png";
                    }

                    return Container(
                      margin: EdgeInsets.only(bottom: 7.5),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),

                        //  color: Colors.deepOrange,


                      ),
                      child: Column(children: [

                        Row(children: [

                          Container(
                            margin: EdgeInsets.only(top: 5, left: 10),
                            child: Image.asset(
                              "image/"+taskimgcolor, height: 40,
                              width: 35,),
                          ),

                          Container(
                            width:167.5,
                            margin: EdgeInsets.only(top: 5, left: 7.5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Container(
                                  margin: EdgeInsets.only(
                                      left: 0, top: 0),

                                  child: Text(itemslists.time.toString(),
                                      style: TextStyle(color: getcolorpaymentext,
                                          fontSize: 11,
                                          fontFamily: 'BebesNeue',
                                          fontWeight: FontWeight.w700),maxLines: 1),
                                ),

                                Container(
                                  margin: EdgeInsets.only(
                                      left: 0, top: 2.5),

                                  child: Text(itemslists.contactPerson.toString(),
                                    style: TextStyle(color: getcolorpaymentext,
                                        fontSize: 9,
                                        fontFamily: 'BebesNeue',
                                        fontWeight: FontWeight.w700),),
                                ),
                              ],
                            ),
                          ),

                          Spacer(),

                          Container(
                            margin: EdgeInsets.only(top: 5, left: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [

                                Container(
                                  margin: EdgeInsets.only(
                                      left: 0, top: 0),

                                  child: Text("",
                                    style: TextStyle(color: getcolorpaymentext.withOpacity(0.4),
                                        fontSize: 9,
                                        fontFamily: 'BebesNeue',
                                        fontWeight: FontWeight.w700),),
                                ),

                                Container(
                                  margin: EdgeInsets.only(
                                      left: 0, top: 2.5),

                                  child: Text(itemslists.date.toString(),
                                    style: TextStyle(color: getcolorpaymentext,
                                        fontSize: 10.5,
                                        fontFamily: 'BebesNeue',
                                        fontWeight: FontWeight.w700),),
                                ),
                              ],
                            ),
                          ),

                          InkWell(
                            child: Container(
                              margin: EdgeInsets.only(top: 5, left: 5,right: 5),
                              child: Image.asset(
                                "image/"+taskarrowcolor, height: 17.5,
                                width: 20,),
                            ),
                            onTap: () async {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AlertTaskDetailST()),).then((value) =>{ getUpdate()});
                              //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AlertMeetDetailST()));
                              print("is pressed");

                              prefid = await SharedPreferences.getInstance();
                              prefid.setString("id", itemslists.id.toString());
                            },
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

  Widget getOverdueWidget(){
    return  Expanded(

      child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
              left: 10, right: 10, top: 0, bottom: 10),
          //height: 275,

          padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 15),


          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5)),
             // borderRadius: BorderRadius.circular(5),
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
                  itemCount: alertduemodel!.length,
                  itemBuilder: (context, index) {
                    JsonResultAlertDue itemslists = alertduemodel![index];

                    if(itemslists.showid=="0"){
                      getcolorpaymentext=Color(0xff9d88f0);
                      overdueimgcolor="overduecolor.png";
                      overduearrowcolor="overduearrow.png";
                    }else{
                      getcolorpaymentext=Color(0xff868585);
                      overdueimgcolor="overduebw.png";
                      overduearrowcolor="alertarrow.png";
                    }

                    return Container(
                      margin: EdgeInsets.only(bottom: 7.5),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),

                        //  color: Colors.deepOrange,


                      ),
                      child: Column(children: [

                        Row(children: [

                          Container(
                            margin: EdgeInsets.only(top: 5, left: 10),
                            child: Image.asset(
                              "image/"+overdueimgcolor, height: 40,
                              width: 35,),
                          ),

                          Container(
                            width:167.5,
                            margin: EdgeInsets.only(top: 5, left: 7.5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Container(
                                  margin: EdgeInsets.only(
                                      left: 0, top: 0),

                                  child: Text(itemslists.agentname.toString(),
                                      style: TextStyle(color: getcolorpaymentext,
                                          fontSize: 11,
                                          fontFamily: 'BebesNeue',
                                          fontWeight: FontWeight.w700),maxLines: 1),
                                ),

                                Container(
                                  margin: EdgeInsets.only(
                                      left: 0, top: 2.5),

                                  child: Text(itemslists.contactperson.toString(),
                                    style: TextStyle(color: getcolorpaymentext,
                                        fontSize: 9,
                                        fontFamily: 'BebesNeue',
                                        fontWeight: FontWeight.w700),),
                                ),
                              ],
                            ),
                          ),

                          Spacer(),

                          Container(
                            margin: EdgeInsets.only(top: 5, left: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [

                                Container(
                                  margin: EdgeInsets.only(
                                      left: 0, top: 0),

                                  child: Text("",
                                    style: TextStyle(color: getcolorpaymentext.withOpacity(0.4),
                                        fontSize: 9,
                                        fontFamily: 'BebesNeue',
                                        fontWeight: FontWeight.w700),),
                                ),

                                Container(
                                  margin: EdgeInsets.only(
                                      left: 0, top: 2.5),

                                  child: Text(itemslists.paymentduedate.toString(),
                                    style: TextStyle(color: getcolorpaymentext,
                                        fontSize: 10.5,
                                        fontFamily: 'BebesNeue',
                                        fontWeight: FontWeight.w700),),
                                ),
                              ],
                            ),
                          ),

                          InkWell(
                            child: Container(
                              margin: EdgeInsets.only(top: 5, left: 5,right: 5),
                              child: Image.asset(
                                "image/"+overduearrowcolor, height: 17.5, width: 20,),
                            ),
                            onTap: () async {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AlertOverDueDetailST()),).then((value) =>{ getUpdate()});

                              //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AlertOverDueDetailST()));
                              print("is pressed");

                              prefid = await SharedPreferences.getInstance();
                              prefid.setString("id", itemslists.id.toString());
                            },
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

  Future<List <ResultsAlertMeet>> getAlertsMeet() async{

 //   String newurl = "https://inboundcrm.in/travcrm-dev_2.2/Api/App/nikhil/json_meetalert.php";

    String newurl=AppNetworkConstants.ALERTSMEET;

    print("Alerts Meet url is : "+newurl);

    var url= Uri.parse(newurl);


    http.Response res = await http.get(url);
    //  List datas= jsonDecode(res.body);

    print("Alerts Meet response is : "+res.body);

    var datas= jsonDecode(res.body)['results'] as List;

    List<ResultsAlertMeet> dashdata = datas.map((data) => ResultsAlertMeet.fromJson(data)).toList();

    return dashdata;
  }

  Future<List <ResultsAlertTask>> getAlertsTask() async{

  //  String newurl = "https://inboundcrm.in/travcrm-dev_2.2/Api/App/nikhil/json_taskalert.php";

       String newurl=AppNetworkConstants.ALERTSTASK;

    print("Alerts Task url is : "+newurl);

    var url= Uri.parse(newurl);


    http.Response res = await http.get(url);
    //  List datas= jsonDecode(res.body);

    print("Alerts Task response is : "+res.body);

    var datas= jsonDecode(res.body)['results'] as List;

    List<ResultsAlertTask> dashdata = datas.map((data) => ResultsAlertTask.fromJson(data)).toList();

    return dashdata;
  }


  Future<List <JsonResultAlertDue>> getAlertsOverDue() async{

  //  String newurl = "https://inboundcrm.in/travcrm-dev_2.2/Api/App/nikhil/json_overduealert.php";

         String newurl=AppNetworkConstants.ALERTSDUE;

    print("Alerts OverDue url is : "+newurl);

    var url= Uri.parse(newurl);


    http.Response res = await http.get(url);
    //  List datas= jsonDecode(res.body);

    print("Alerts OverDue response is : "+res.body);

    var datas= jsonDecode(res.body)['json_result'] as List;

    List<JsonResultAlertDue> dashdata = datas.map((data) => JsonResultAlertDue.fromJson(data)).toList();

    return dashdata;
  }

  Future<List <ResultsAlertPay>> getAlertsPay() async{

  //  String newurl = "https://inboundcrm.in/travcrm-dev_2.2/Api/App/nikhil/json_paymentalert.php";

      String newurl=AppNetworkConstants.ALERTSPAY;

    print("Alerts Payment url is : "+newurl);

    var url= Uri.parse(newurl);


    http.Response res = await http.get(url);
    //  List datas= jsonDecode(res.body);

    print("Alerts Payment response is : "+res.body);

    var datas= jsonDecode(res.body)['results'] as List;

    List<ResultsAlertPay> dashdata = datas.map((data) => ResultsAlertPay.fromJson(data)).toList();

    return dashdata;
  }

  void getUpdate(){
    setState(() {

    });
  }
}