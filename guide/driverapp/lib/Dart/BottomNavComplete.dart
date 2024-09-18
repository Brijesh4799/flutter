import 'dart:async';
import 'dart:convert';


import 'package:driverapp/Dart/alertdetail.dart';
import 'package:driverapp/Dart/pendingduties.dart';
import 'package:driverapp/Dart/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Apis/apis.dart';
import '../Models/AlertModel.dart';
import '../Models/NotificationModel.dart';
import '../Providers/pickeralert.dart';
import '../Providers/pickeralert.dart';
import '../main.dart';
import 'alert.dart';
import 'completeduties.dart';
import 'home.dart';
import 'login.dart';
import 'package:http/http.dart' as http;

import 'mylist.dart';


class BottomNavComplete extends  StatefulWidget {

  @override
  State createState() => new MyBottomNavComplete();
}

class MyBottomNavComplete extends State<BottomNavComplete>  {

  late SharedPreferences prefroleid, prefuserid, prefstatusvar;


  int _currentIndex=3;

  final List tabs=[Home(),MyList(),PendingDuties(),CompleteDuties(),Alert()];

  List<NotificationsList>? notificatiomodel;

  String? UserId="45";
  String? roleId="3";

  String? notifcation="";

  bool isShow=false;
  bool isNotShow=true;

  Future getPref() async {
    prefroleid = await SharedPreferences.getInstance();

    prefuserid = await SharedPreferences.getInstance();

    setState(() {

      UserId = prefuserid.getString("userid")!;
      print("my Recieved OTP is : $UserId");

      roleId = prefroleid.getString("roleid")!;
      print("my Recieved Role Id in Home is : $roleId");
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: tabs[_currentIndex],

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xFFeaeaea),
        ),
        child: Container(
          //  padding: EdgeInsets.only(top: 15,bottom:15),
          // margin: EdgeInsets.only(left: 7.5,right: 7.5),
          height: 85,
          decoration: BoxDecoration(
            //   borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight:Radius.circular(20),),
            gradient: LinearGradient(
              // begin: Alignment.topLeft,
              //  end: Alignment.bottomRight,
              colors: [
                Color(0xFFd3d3d3).withOpacity(0.7),
                Color(0xFFd3d3d3).withOpacity(0.7),
              ],
              //  stops: [0.0,1.0]
            ),
            image: DecorationImage(
              image: AssetImage("image/bnlat.png"),
              fit: BoxFit.cover,
            ),
          ),

          child: BottomNavigationBar(
            unselectedItemColor: Colors.black45,
            selectedItemColor: Colors.orange,
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,

            onTap: (index){
              setState(() {
                _currentIndex=index;
              });
            },


            items: [
              BottomNavigationBarItem(
                icon: Image.asset("image/guidebtnhomebw.png",height: 25, width: 25,),
                activeIcon:new Image.asset('image/guidebtnhomecl.png',height: 25, width: 25,),
                label: "Home",

                //   backgroundColor: Colors.transparent,
              ),

              BottomNavigationBarItem(
                icon: Image.asset("image/guidebtnlistbw.png",height: 25, width: 25,),
                activeIcon:new Image.asset('image/guidebtnlistcl.png',height: 25, width: 25,),
                label: "My List",
                //  backgroundColor: Colors.blue,
              ),

              BottomNavigationBarItem(
                icon: Image.asset("image/guidebtnpendingbw.png",height: 25, width: 25,),
                activeIcon:new Image.asset('image/guidebtnpendingcl.png',height: 25, width: 25,),
                label: "Pending",
                //  backgroundColor: Colors.blue,
              ),

              BottomNavigationBarItem(
                icon: Image.asset("image/guidebtncompletebw.png",height: 25, width: 25,),
                activeIcon:new Image.asset('image/guidebtncompletecl.png',height: 25, width: 25,),
                label: "Completed",
                // backgroundColor: Colors.blue
              ),

              BottomNavigationBarItem(
                icon: new Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset("image/guidebtnalertbw.png",height: 25, width: 25,),
                    FutureBuilder(
                        future: getNotificationfromHome(),
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

                            /* Fluttertoast.showToast(
                              msg:  notifcation!,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 4,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 12.0
                          );*/

                            print("Notification is : $notifcation");

                            return  Positioned(

                              bottom: 12.5,
                              left: 12.5,
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
                                        color: Color(0xFFdb5041),
                                        border: Border.all(
                                          color:Color(0xFFdb5041),
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
                                      width: 25,
                                      height: 25,
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

                    ),
                  ],
                ),

                activeIcon:new Stack(
                  clipBehavior: Clip.none,
                  children: [
                    new Image.asset('image/guidebtnalertcl.png',height: 25, width: 25,),
                    FutureBuilder(
                        future: getNotificationfromHome(),
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

                            /* Fluttertoast.showToast(
                              msg:  notifcation!,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 4,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 12.0
                          );*/

                            print("Notification is : $notifcation");

                            return  Positioned(

                              bottom: 12.5,
                              left: 12.5,
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
                                        color: Color(0xFFdb5041),
                                        border: Border.all(
                                          color:Color(0xFFdb5041),
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
                                      width: 25,
                                      height: 25,
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

                    ),
                  ],
                ),
                label: "Alerts",
                // backgroundColor: Colors.blue
              ),

            ],

          ),
        ),
      ),
    );


  }
  Future<List<NotificationsList>> getNotificationfromHome() async {

    String newurl = AppNetworkConstants.NOTIFICATION + "driverId=" +UserId!+ "&roleId=" + roleId!;

    print("Notification url is : "+newurl);

    var url = Uri.parse(newurl);


    http.Response res = await http.get(url);

    print("notification response from home is "+ res.body);
    //  List datas= jsonDecode(res.body);
    //  getToogleNotify();

    var datas = jsonDecode(res.body)['notifications'] as List;

    /*setState(() {
      loadCircle = false;
    });*/

    List<NotificationsList> notificationData = datas.map((data) =>
        NotificationsList.fromJson(data)).toList();

    notifcation = notificationData[0].countorders!;

    print("Notification is : $notifcation");

    return notificationData;
  }
}
