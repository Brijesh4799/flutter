
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:salescrm/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;




class DaysST extends StatefulWidget {
  // ItemDetail({required this.itemlist});

  @override
  State createState() => new MyDaysST();
}

class MyDaysST extends State<DaysST> {

  late SharedPreferences prefs,preflog_in_out;

  GlobalKey<ScaffoldState> _drawerkey= GlobalKey<ScaffoldState>();

  bool isOfficeHeader=true;
  bool isClientHeader=false;

  bool isOfficetext=true;
  bool isClienttext=false;

  Color selectcoloroffice= Colors.lightBlue;
  Color selectcolorclient= Colors.deepPurple;
  Color selectcolorofficetext= Colors.white;
  Color selectcolorclienttext= Colors.white;


  getColorOffice(){
    setState(() {
      isOfficeHeader=true;
      isClientHeader=false;

      isOfficetext=true;
      isClienttext=false;

      selectcoloroffice= Colors.lightBlue;
      selectcolorclient= Colors.deepPurple;
      selectcolorofficetext= Colors.white;
      selectcolorclienttext= Colors.white;
    });
  }

  getColorClient(){
    setState(() {
      isOfficeHeader=false;
      isClientHeader=true;

      isOfficetext=false;
      isClienttext=true;

      selectcoloroffice= Colors.deepPurple;
      selectcolorclient= Colors.blue;
      selectcolorofficetext= Colors.white;
      selectcolorclienttext= Colors.white;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  getMyLoginValue();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(


        body:  Padding(
            padding: EdgeInsets.all(0),

            child:   Container(
              decoration: BoxDecoration(
               /* image: DecorationImage(
                  image: AssetImage("image/daybg1.png"),
                  fit: BoxFit.cover,
                ),*/
                color: Colors.white
              ),
              child: Column(children: [

                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 110,
                  margin: EdgeInsets.only(top: 10,bottom: 0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("image/dayheader.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child:  Container(
                      margin: EdgeInsets.only(top: 5,bottom: 0),
                      padding: EdgeInsets.only(bottom: 20,top: 0),
                      child:  Container(
                        margin: EdgeInsets.only(left: 0, top: 0),
                        child:  Center(
                          child: Text("HELLO SANJEEV !",
                            style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                        ),
                      ),
                    ),
                ),
                
                Expanded(
                  child: SingleChildScrollView(
                    
                    child: Column(children: [

                      Container(
                        margin: EdgeInsets.only(top: 15,left: 0),
                        child:  Image.asset("image/daytext.png",height: 90, width: MediaQuery.of(context).size.width,),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 20,left: 0),
                        child:  Image.asset("image/daygirl.png",height: 250, width: MediaQuery.of(context).size.width,),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 30,left: 0),
                        child: Center(
                          child: Text("Choose the right option to mark your attendence",
                            style: TextStyle(color: Colors.deepPurple,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                        ),),


                      InkWell(
                        onTap: (){
                          isOfficeHeader=true;
                          isOfficetext=true;
                          getColorOffice();
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyBottomNavigationBar()));
                        },
                        child: Container(
                          width: 180,
                          child: Center(
                            child: Text("AT OFFICE",
                              style: TextStyle(color:selectcolorofficetext,fontSize: 15,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                          ),
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.all(Radius.circular(2.5)),
                            color: selectcoloroffice,
                          ),
                          margin: EdgeInsets.only(left: 0,right: 0,top: 10),
                          padding: EdgeInsets.only(left: 0,right: 0,top: 12.5,bottom: 12.5),

                        ),
                      ),

                      InkWell(
                        onTap: (){
                          /* isPreOrderHeader=true;
                                    value="7";
                                    getSelectionColor();
                                    getColorPre();*/
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyBottomNavigationBar()));
                          isClientHeader=true;
                          isClienttext=true;
                          getColorClient();
                        },
                        child: Container(
                          width: 180,
                          child: Center(
                            child: Text("VISITING CLIENT",
                              style: TextStyle(color: selectcolorclienttext,fontSize: 15,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                          ),
                          decoration: BoxDecoration(
                            //  borderRadius: BorderRadius.all(Radius.circular(2.5)),
                            color: selectcolorclient,
                          ),
                          margin: EdgeInsets.only(left: 0,right: 0,top: 7.5,bottom: 0),
                          padding: EdgeInsets.only(left: 0,right: 0,top: 12.5,bottom: 12.5),

                        ),
                      ),


                      Row(children: [

                        Container(

                          margin: EdgeInsets.only(left: 60,),
                          child: Column(children: [
                            Container(
                              margin: EdgeInsets.only(top: 25,left: 0,),
                              child: Center(
                                child: Text("I'LL DO IT LATER",
                                  style: TextStyle(color: Colors.blue,fontSize: 12.5,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                              ),),
                            Container(
                              width: 102,
                              height: 2,color: Colors.blue,),
                          ],),
                        ),

                        Container(margin: EdgeInsets.only(top: 22,left: 22,right: 22),width: 2,height: 25,color: Colors.blue),

                        Container(
                          child: Column(children: [

                            Container(
                              margin: EdgeInsets.only(top: 25,),
                              child: Center(
                                child: Text("I AM ON LEAVE",
                                  style: TextStyle(color: Colors.blue,fontSize: 12.5,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                              ),),

                            Container(
                              width: 94,
                              height: 2,color: Colors.blue,),
                          ],),
                        )
                      ],),

                      SizedBox(height: 20,),
                      
                    ],),
                  ),
                ),

              ],
              ),
            ))
    );
  }
}