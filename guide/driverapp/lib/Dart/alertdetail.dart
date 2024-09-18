import 'dart:async';
import 'dart:convert';


import 'package:driverapp/Dart/BottomNavAlert.dart';
import 'package:driverapp/Dart/pendingduties.dart';
import 'package:driverapp/Dart/profile.dart';
import 'package:driverapp/Models/AlertDetailModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Apis/apis.dart';
import '../Models/AlertModel.dart';
import '../Models/NotificationModel.dart';
import 'alert.dart';
import 'completeduties.dart';
import 'home.dart';
import 'login.dart';
import 'package:http/http.dart' as http;

import 'mylist.dart';


class AlertDetailSL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: AlertDetail(),
    );
  }
}

class AlertDetail extends StatefulWidget {

  @override
  State createState() => MyAlertDetail();
}

class MyAlertDetail extends State<AlertDetail> {

  bool loadCircle = false;

  late SharedPreferences  prefroleid, prefid, prefnotification, prefuserid;

  List<DutyDetailsAlert>? alertdetailmodel;

  String? UserId="1";
  String? roleId="0";
  String? id="1";
  String? notifcation="0";

  String? tourid="0";
  String? tourname="0";
  String? tourdate="0";
  String? startreading="0";
  String? endreading="0";
  String? pickuptime="0";
  String? droptime="0";

  @override
  void initState() {
    super.initState();
    getPref();
  }

  Future getPref() async {
    prefroleid = await SharedPreferences.getInstance();
    prefid = await SharedPreferences.getInstance();
    prefuserid = await SharedPreferences.getInstance();
    prefnotification = await SharedPreferences.getInstance();

    setState(() {
      roleId = prefroleid.getString("roleid")!;
      print("my Recieved Role Id in Home is : $roleId");

      id= prefid.getString("alertid")!;
      print("my Recieved Alert Id in AlertDetail is : $id");

      UserId = prefuserid.getString("userid")!;
      print("my Recieved OTP is : $UserId");

      notifcation = prefnotification.getString("count");
      print("my Recieved  Count is : $notifcation");

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Container(
          padding: EdgeInsets.only(top: 15, bottom: 15),
          color: Colors.deepOrange,
          child: Row(
            children: [

              /* InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Image.asset(
                        "image/back.png", height: 20, width: 25,),
                    ),
                  ),*/

              Container(
                //   margin: EdgeInsets.only(right: 5),
                child: Text("Alert Details",
                    style: TextStyle(color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'BebesNeue',
                        fontWeight: FontWeight.w700)),
              )

            ],

          ),
        ),
      ),

      body:  Column(children: [

        FutureBuilder(
            future: getAlertDetailLatest(),
            builder:(context, snapshot) {

              if(snapshot.hasData) {
                alertdetailmodel= snapshot.data as List<DutyDetailsAlert>;

                tourid = alertdetailmodel![0].tourId;
                tourname = alertdetailmodel![0].tourName;
                tourdate = alertdetailmodel![0].tourDate;
                startreading = alertdetailmodel![0].startReading;
                endreading = alertdetailmodel![0].endReading;
                pickuptime = alertdetailmodel![0].actualPickupTime;
                droptime = alertdetailmodel![0].actualdropTime;

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
      ],
      ),
    );
  }


  Widget  getBodyWidget() {

    return Expanded(

      child: Column(
        children: [

          Container(
            margin: EdgeInsets.only(top: 15,right: 00),
            child: Image.asset("image/guidelogo.png", height: 50.0, width: 100),
          ),

         SizedBox(height: 15,),

          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
              image: DecorationImage(
              image: AssetImage("image/guidehomebg.jpg"),
              fit: BoxFit.cover,

             ),
             borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
            ),
              child: Column(children: [

                Container(
                  child: Center(
                    child:Image.asset("image/guidealert.png", width: 230, height: 60,),
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 10),
                  margin: EdgeInsets.only(top: 20,left: 10,right: 10,bottom: 10),
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

                      SizedBox(height: 7.5,),

                      Container(
                        child: Row(
                            children: [

                              Container(
                                margin: EdgeInsets.only(left: 5),
                                child:  Text("Tour Id : ",
                                  style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                              ),

                              Container(
                                width: 200,
                                margin: EdgeInsets.only(left: 0),
                                child:  Text("           "+tourid!,
                                  style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                              ),

                            ]
                        ),
                      ),

                      SizedBox(height: 7.5,),

                      Container(
                        child: Row(
                            children: [

                              Container(
                                margin: EdgeInsets.only(left: 5),
                                child:  Text("Tour Name : ",
                                  style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                              ),

                              Container(
                                width: 200,
                                margin: EdgeInsets.only(left: 0),
                                child:  Text("    "+tourname!,
                                    style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),maxLines: 1),
                              ),

                            ]
                        ),
                      ),

                      SizedBox(height: 7.5,),

                      Container(
                        child: Row(
                            children: [

                              Container(
                                margin: EdgeInsets.only(left: 5),
                                child:  Text("Date : ",
                                  style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                              ),

                              Container(
                                width: 200,
                                margin: EdgeInsets.only(left: 0),
                                child:  Text("              "+tourdate!,
                                    style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),overflow: TextOverflow.ellipsis),
                              ),

                            ]
                        ),
                      ),

                     /* SizedBox(height: 7.5,),

                      Container(
                        child: Row(
                            children: [

                              Container(
                                margin: EdgeInsets.only(left: 5),
                                child:  Text("Start Activity Time : ",
                                  style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                              ),

                              Container(
                                width: 200,
                                margin: EdgeInsets.only(left: 0),
                                child:  Text(startreading!,
                                  style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                              ),

                            ]
                        ),
                      ),

                      SizedBox(height: 7.5,),

                      Container(
                        child: Row(
                            children: [

                              Container(
                                margin: EdgeInsets.only(left: 5),
                                child:  Text("End Activity Time : ",
                                  style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                              ),

                              Container(
                                width: 200,
                                margin: EdgeInsets.only(left: 0),
                                child:  Text("  "+endreading!,
                                  style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                              ),

                            ]
                        ),
                      ),*/

                      SizedBox(height: 10,),

                      // dot line
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 3,
                        margin: EdgeInsets.only(left:10,right: 10),
                        child:  Image.asset("image/dotline.png",),
                      ),

                      SizedBox(height: 10,),

                      Container(
                        child: Row(
                            children: [

                              Container(
                                margin: EdgeInsets.only(left: 5),
                                child:  Text("Actual Start Time : ",
                                  style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                              ),

                              Container(
                                width: 180,
                                margin: EdgeInsets.only(left: 0),
                                child:  Text(pickuptime!,
                                    style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),overflow: TextOverflow.ellipsis),
                              ),

                            ]
                        ),
                      ),

                      SizedBox(height: 7.5,),

                      Container(
                        child: Row(
                            children: [

                              Container(
                                margin: EdgeInsets.only(left: 5),
                                child:  Text("Actual End Time : ",
                                  style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                              ),

                              Container(
                                width: 180,
                                margin: EdgeInsets.only(left: 0),
                                child:  Text("   "+droptime!,
                                    style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),overflow: TextOverflow.ellipsis),
                              ),

                            ]
                        ),
                      ),

                      SizedBox(height: 7.5,),                    ],


                  ),
                ),
              ],
              ),
            ),
          ),

        ],

      ),
    );

  }

  Future<List<DutyDetailsAlert>> getAlertDetailLatest() async {

    String newurl = AppNetworkConstants.ALERTDUTYDETAILSLATEST+ "id="+id!+ "&roleId="+roleId!;

    print("Alert Detail Latest url is : " + newurl);

    var url = Uri.parse(newurl);

    http.Response res = await http.get(url);

    print("alert Detait latest Response is : " +res.body);

    getNotification();

    //  List datas= jsonDecode(res.body);

    var datas = jsonDecode(res.body)['dutyDetails'] as List;

    List<DutyDetailsAlert> alertDetailData = datas.map((data) =>
        DutyDetailsAlert.fromJson(data)).toList();

    return alertDetailData;
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

}
