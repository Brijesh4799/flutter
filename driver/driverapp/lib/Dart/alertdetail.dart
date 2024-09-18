import 'dart:async';
import 'dart:convert';


import 'package:driverapp/Models/AlertDetailModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Apis/apis.dart';
import '../Models/NotificationModel.dart';
import 'package:http/http.dart' as http;



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

  late SharedPreferences  prefroleid, prefid,prefuserid;

  List<DutyDetailsAlertsDetail>? alertdetailmodel;


  String? roleId="0";
  String? UserId="1";
  String? id="1";

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

    setState(() {
      roleId = prefroleid.getString("roleid")!;
      print("my Recieved Role Id in Home is : $roleId");

      id= prefid.getString("alertid")!;
      print("my Recieved Alert Id in AlertDetail is : $id");

      UserId = prefuserid.getString("userid")!;
      print("my Recieved OTP is : $UserId");
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color(0xff1a237e),
        title: Container(
          padding: EdgeInsets.only(top: 15, bottom: 15),
          color: Color(0xff1a237e),
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
                alertdetailmodel= snapshot.data as List<DutyDetailsAlertsDetail>;

                if(alertdetailmodel!.length==0) {

                  Fluttertoast.showToast(
                      msg: "No Detail Now",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 3,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 12.0
                  );
                }

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

    return Container(
      padding: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 10),
      margin: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
         gradient: LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          colors: [
            Colors.blue.withOpacity(0.075),
            Colors.blue.withOpacity(0.075),
          ],
          //  stops: [0.0,1.0]
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

          SizedBox(height: 7.5,),

          Container(
            child: Row(
                children: [

                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child:  Text("Start Reading : ",
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
                    child:  Text("End Reading : ",
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
          ),

          SizedBox(height: 5,),

          Container(
            margin: EdgeInsets.only(left: 5,right: 10,top: 10,bottom: 5),
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: Colors.grey,
          ),

          SizedBox(height: 5,),

          Container(
            child: Row(
                children: [

                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child:  Text("Actual Pickup Time : ",
                      style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                  ),

                  Container(
                    width: 200,
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
                    child:  Text("Actual Drop Time : ",
                      style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                  ),

                  Container(
                    width: 200,
                    margin: EdgeInsets.only(left: 0),
                    child:  Text("   "+droptime!,
                      style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),overflow: TextOverflow.ellipsis),
                  ),

                ]
            ),
          ),

          SizedBox(height: 7.5,),
        ],


      ),
    );

  }

  Future<List<DutyDetailsAlertsDetail>> getAlertDetailLatest() async {

    String newurl = AppNetworkConstants.ALERTDUTYDETAILSLATEST+ "id="+id!+ "&roleId="+roleId!;

  //  String newurl = "https://inboundcrm.in/travcrm-dev_2.2/driverapp/json_alertdutyDetailslatest.php?id=263&roleId=2";

    print("Alert Detail Latest url is : " + newurl);

    var url = Uri.parse(newurl);

    http.Response res = await http.get(url);

    print("alert Detait latest Response is : " +res.body);

    getNotification();

    //  List datas= jsonDecode(res.body);

    var datas = jsonDecode(res.body)['dutyDetails'] as List;

    List<DutyDetailsAlertsDetail> alertDetailData = datas.map((data) =>
        DutyDetailsAlertsDetail.fromJson(data)).toList();

    return alertDetailData;
  }


  Future<List<NotificationsList>> getNotification() async {

    String newurl = AppNetworkConstants.NOTIFICATION + "driverId=" +UserId!+ "&roleId=" + roleId!;

    print("Notification url is : "+newurl);

    var url = Uri.parse(newurl);


    http.Response res = await http.get(url);
    //  List datas= jsonDecode(res.body);

    print("response of notification is : " +res.body);

    var datas = jsonDecode(res.body)['notifications'] as List;

    List<NotificationsList> notificationData = datas.map((data) =>
        NotificationsList.fromJson(data)).toList();

    return notificationData;
  }

}
