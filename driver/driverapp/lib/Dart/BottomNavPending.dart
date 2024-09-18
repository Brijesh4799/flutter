import 'dart:async';
import 'dart:convert';


import 'package:driverapp/Dart/pendingduties.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Apis/apis.dart';
import '../Models/NotificationModel.dart';
import 'alert.dart';
import 'completeduties.dart';
import 'home.dart';
import 'package:http/http.dart' as http;

import 'mylist.dart';


class BottomNavPending extends  StatefulWidget {

  @override
  State createState() => new MyBottomNavPending();
}

class MyBottomNavPending extends State<BottomNavPending>  {

  late SharedPreferences prefroleid, prefuserid;

  String? UserId="12";
  String? roleId="2";

  List<NotificationsList>? notificatiomodel;

  String? notifcation="";
  bool isShow=false;
  bool isNotShow=true;


  int _currentIndex=2;
  Color colorlist = Color(0xffb2ebf2);

  final List tabs=[Home(),MyList(),PendingDuties(),CompleteDuties(),Alert()];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: tabs[_currentIndex],

      bottomNavigationBar: Container(
      //  padding: EdgeInsets.only(left: 5,right: 5),
        //  color: Colors.grey,

        /* decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("image/footerstrip.png"),
            fit: BoxFit.cover,
          ),
        ),*/

        child: Container(
          margin: EdgeInsets.only(left: 0,right: 0),
          padding: EdgeInsets.only(top: 15,bottom:15),
          //  height: 55,
          decoration: BoxDecoration(
            color: colorlist,
            borderRadius: BorderRadius.only(topLeft:Radius.circular(0),topRight:Radius.circular(0),),
            /*gradient: LinearGradient(
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              colors: [
                Color(0xFFFFFFFF).withOpacity(0.1),
                Color(0xFFFFFFFF).withOpacity(0.1),
              ],
              //  stops: [0.0,1.0]
            ),*/
            image: DecorationImage(
              image: AssetImage("image/bnlat.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,

            onTap: (index){
              setState(() {
                _currentIndex=index;
                if(_currentIndex==0)
                {
                  colorlist=Colors.transparent;
                  print("bn position ${_currentIndex}");
                }else{
                  colorlist=Color(0xffb2ebf2);
                  print("bn position ${_currentIndex}");
                }
              });
            },


            items: [
              BottomNavigationBarItem(
                icon: Image.asset("image/homeiconbnplane.png",height: 25, width: 25,),
                activeIcon:new Image.asset('image/homeiconbncolor.png',height: 25, width: 25,),
                label: "Home",

                //   backgroundColor: Colors.transparent,
              ),

              BottomNavigationBarItem(
                icon: Image.asset("image/mylisticonbnplane.png",height: 25, width: 25,),
                activeIcon:new Image.asset('image/mylisticonbncolor.png',height: 25, width: 25,),
                label: "My List",
                //  backgroundColor: Colors.blue,
              ),

              BottomNavigationBarItem(
                icon: Image.asset("image/pendingiconbnplane.png",height: 25, width: 25,),
                activeIcon:new Image.asset('image/pendingiconbncolor.png',height: 25, width: 25,),
                label: "Pending",
                //  backgroundColor: Colors.blue,
              ),

              BottomNavigationBarItem(
                icon: Image.asset("image/completeiconbnplane.png",height: 25, width: 25,),
                activeIcon:new Image.asset('image/completeiconbncolor.png',height: 25, width: 25,),
                label: "Completed",
                // backgroundColor: Colors.blue
              ),

              BottomNavigationBarItem(
                icon: new Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset("image/alerticonbnplane.png",height: 25, width: 25,),
                    FutureBuilder(
                        future: getNotificationfromHome(),
                        builder:(context, snapshot) {

                          if(snapshot.hasData) {

                            notificatiomodel= snapshot.data;

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
                                        color: Colors.lightBlueAccent,
                                        border: Border.all(
                                          color:Colors.lightBlueAccent,
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
                    new Image.asset('image/alerticonbncolor.png',height: 25, width: 25,),
                    FutureBuilder(
                        future: getNotificationfromHome(),
                        builder:(context, snapshot) {

                          if(snapshot.hasData) {

                            notificatiomodel= snapshot.data;

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

                            Fluttertoast.showToast(
                                msg:  notifcation!,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 4,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 12.0
                            );

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
                                        color: Colors.lightBlueAccent,
                                        border: Border.all(
                                          color:Colors.lightBlueAccent,
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


    var datas = jsonDecode(res.body)['notifications'] as List;

    /*setState(() {
      loadCircle = false;
    });*/

    List<NotificationsList> notificationData = datas.map((data) =>
        NotificationsList.fromJson(data)).toList();

    /*notifcation = notificationData[0].countorders!;

    print("Notification is : $notifcation");*/

    return notificationData;
  }

}
