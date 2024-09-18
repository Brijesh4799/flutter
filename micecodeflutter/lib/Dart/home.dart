import 'dart:async';
import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:micetravel/Dart/tourspecialist.dart';
import 'package:micetravel/Dart/translatest.dart';
import 'package:micetravel/Dart/tripfeedback.dart';
import 'package:micetravel/Dart/utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'detailitnraryvoucher.dart';
import 'document.dart';
import 'itinerary.dart';
import 'itinerarylat.dart';
import 'login.dart';
import 'myprofile.dart';
import 'myupdateprofile.dart';



class HomeSL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Home(),
    );
  }
}

class Home extends StatefulWidget {

  @override
  State createState() => MyHome();
}

class MyHome extends State<Home> {

  late SharedPreferences preflog_in_out, prefprofile,prefId, prefRefid,prefquotationId,prefqueryId;

  String fname="";
  String lname="";
  String refID="";
  String queryID="";
  String ID="";

  GlobalKey<ScaffoldState> _drawerkey= GlobalKey<ScaffoldState>();



  @override
  void initState() {
    getMyLoginValue();
    getPrefProfile();
    getMyRefId();
    getMyId();
    super.initState();
  }

  getMyRefId() async {
    prefRefid = await SharedPreferences.getInstance();
    prefquotationId = await SharedPreferences.getInstance();
    prefqueryId = await SharedPreferences.getInstance();

    setState(() {
      refID = prefRefid.getString("refid")!;
      queryID = prefqueryId.getString("queryId")!;
      prefquotationId.getString("quotationId")!;
    });
  }

  getMyId() async {
    prefId = await SharedPreferences.getInstance();

    setState(() {
      ID = prefId.getString("id")!;
    });
  }


  getPrefProfile() async {
    prefprofile = await SharedPreferences.getInstance();

    setState(() {
      fname =  prefprofile.getString("fname")!;
      lname =  prefprofile.getString("lname")!;
      print("Shared Recieved firstname is : $fname");
      print("Shared Recieved lastname is : $lname");
    });
  }

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

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                InkWell(
                  onTap: () {
                    preflog_in_out.clear();
                    prefprofile.clear();
                    prefRefid.clear();
                    prefId.clear();
                    prefquotationId.clear();
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {return Login();}));
                    print("is pressed");
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 20),
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

                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    width: 60,
                    height:30,
                    child: Center(child: Text("No",style: TextStyle(color: Colors.white, fontSize: 14,
                        fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,)),
                    decoration: BoxDecoration(color: Colors.blue,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),


              ],),

              SizedBox(height: 10,)
            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      key: _drawerkey,

      drawer: Drawer(

        backgroundColor: Colors.white,

        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
             //   color: Colors.lightBlueAccent
                image: DecorationImage(
                  image: AssetImage("image/menubg.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  Container(
                 //   margin: EdgeInsets.only(left: 55),
                    child: Image.asset("image/profileimg.png", width: 50, height: 50,),
                  ),

                  SizedBox(height: 10,),

                  Container(
                    child: Center(
                      child: Text(fname+" "+lname,
                        style: TextStyle(color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'BebesNeue',
                            fontWeight: FontWeight.w700),),
                    ),
                  ),

                  SizedBox(height: 10,),

                  Container(
                    child: Center(
                      child: Text("Version - 1.0",
                        style: TextStyle(color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'BebesNeue',
                            fontWeight: FontWeight.w700),),
                    ),
                  ),

                  SizedBox(height: 5,),

                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ProfileUpdate()));
                    },

                      child: Container(
                        width: 50,
                        padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7.5),
                            border: Border.all(color: Colors.blue,width: 2.0)
                        ),

                        child: Center(
                          child: Text("Edit",
                            style: TextStyle(color: Colors.blue,
                                fontSize: 10,
                                fontFamily: 'BebesNeue',
                                fontWeight: FontWeight.w700),),
                        ),

                      ),
                  ),

                ],),

            ),

            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,

              child: Column(
                children: [

                  InkWell(
                    onTap:  (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> MyBottomNavigationBar()));
                      print("is pressed");
                    },

                    child: Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Image.asset("image/homemenu.png",height: 22, width: 22,),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 25),
                            child : Text("Home",
                                style: TextStyle(color: Colors.black,fontSize: 13,
                                    fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                          )
                        ],
                      ),
                    ),
                  ),

                 /* Container(
                    margin: EdgeInsets.only(top: 15),
                    child: ListTile(
                      title: Text("Sales",
                          style: TextStyle(color: Colors.white,fontSize: 13,
                              fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                    ),
                  ),*/

                  InkWell(
                    onTap:  (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Profile()));
                      print("is pressed");
                    },

                    child: Container(
                      margin: EdgeInsets.only(top: 25),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Image.asset("image/profilemenucolor.png",height: 22, width: 22,),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 25),
                            child : Text("My Profile",
                                style: TextStyle(color: Colors.black,fontSize: 13,
                                    fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                          )
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap:  (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ItineraryLat()));
                      print("is pressed");
                    },

                    child: Container(
                      margin: EdgeInsets.only(top: 25),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Image.asset("image/mytripmenu.png",height: 22, width: 22,),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 25),
                            child : Text("My Trip Itinerary",
                                style: TextStyle(color: Colors.black,fontSize: 13,
                                    fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                          )
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap:  (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Document()));
                      print("is pressed");
                    },

                    child: Container(
                      margin: EdgeInsets.only(top: 25),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Image.asset("image/documentsmenu.png",height: 22, width: 22,),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 25),
                            child : Text("Travel Documents",
                                style: TextStyle(color: Colors.black,fontSize: 13,
                                    fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                          )
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap:  (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TranslateST()));
                      print("is pressed");
                    },

                    child: Container(
                      margin: EdgeInsets.only(top: 25),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Image.asset("image/mic.png",height: 22, width: 22,),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 25),
                            child : Text("Translator",
                                style: TextStyle(color: Colors.black,fontSize: 13,
                                    fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                          )
                        ],
                      ),
                    ),
                  ),



                  InkWell(
                    onTap:  (){
                      createDialog(context);
                      print("is pressed");
                    },

                    child: Container(
                      margin: EdgeInsets.only(top: 25),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Image.asset("image/logout.png",height: 22, width: 22,),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 25),
                            child : Text("Logout",
                                style: TextStyle(color: Colors.black,fontSize: 13,
                                    fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                          )
                        ],
                      ),
                    ),
                  ),

                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(top: 50),
                    padding: EdgeInsets.only(top: 15,bottom: 15),

                    child: Row(
                      children: [

                        Expanded(
                          //   flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(left: 95,top: 10),
                            child:Text("Powered by",
                                style: TextStyle(color: Colors.black,fontSize: 9,
                                    fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),),),

                        Expanded(
                          //  flex: 1,
                            child: Container(
                              margin: EdgeInsets.only( right: 75),
                              child:  Image.asset("image/deboxicon.png",height: 30, width: 35,),
                            ))
                      ],
                    ),

                  ),
                ],
              ),
            )
          ],
        ),


      ),

      body: SafeArea(

        child: Container(

          child: Column(
            children: [

              Container(

                child: Row(
                  children: [

                    Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: (){
                            _drawerkey.currentState?.openDrawer();
                            print("drawer is pressed");
                          },
                          child: Container(
                            margin: EdgeInsets.only(top:5),
                            child: Image.asset("image/menumice.png",height: 25, width: 28,),
                          ),
                        )),

                    Expanded(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.only(top: 5,left: 20,right: 20),
                          child: Image.asset("image/travassitantlogomice.png",height: 85, width: 110,),
                        )),

                    Expanded(
                        flex: 1,
                        child: Container(
                        //  margin: EdgeInsets.only( top: 5),
                          child: Image.asset("image/deboxicon.png",height: 30, width: 35,),
                        ))
                  ],

                ),
              ),

            //  SizedBox(height: 5,),

              Expanded(
                child: SingleChildScrollView(

                  child: Container(
                    margin: EdgeInsets.only(left: 10,right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.lightBlueAccent,width: 1,style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                        image: AssetImage("image/homebglatmice.jpg"),
                        fit: BoxFit.cover,
                      ),),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                     
                      Center(
                        child: Row(
                          children: [

                            // Lett
                            Expanded(
                                flex: 1,
                                child: Row(
                                  children: [

                                    // left

                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children:
                                    [

                                      SizedBox(height: 45,),

                                      InkWell(
                                        onTap: (){
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ItineraryLat()));

                                          //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Pdfview()));
                                        },
                                        child: Container(
                                          width: 150,
                                          height: 130,
                                          margin: EdgeInsets.only(left: 10,),
                                          child: Image.asset("image/brefite.png",),
                                        ),
                                      ),

                                      SizedBox(height: 20,),

                                      InkWell(
                                        onTap: (){
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Document()));
                                        },
                                        child: Container(
                                          width: 150,
                                          height: 130,
                                          margin: EdgeInsets.only(left: 10,),
                                          child: Image.asset("image/travdoc.png",),
                                        ),
                                      ),

                                      SizedBox(height: 20,),

                                      InkWell(
                                        onTap: (){
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TripFeedBack()));
                                        },
                                        child: Container(
                                          width: 150,
                                          height: 130,
                                          margin: EdgeInsets.only(left: 15,),
                                          child: Image.asset("image/tripfeed.png",),
                                        ),
                                      ),

                                    ],)

                                  ],
                                ),


                            ),

                            // Right
                            Expanded(
                                flex: 1,
                                child:Row(children: [

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      SizedBox(height: 45,),

                                      InkWell(
                                        onTap: (){
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetatilItineraryw()));
                                        },
                                        child: Container(
                                          width: 150,
                                          height: 130,
                                          margin: EdgeInsets.only(left: 10),
                                          child: Image.asset("image/detailedite.png",),
                                        ),
                                      ),

                                      SizedBox(height: 20,),

                                      InkWell(
                                        onTap: (){
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Utilies()));
                                        },
                                        child: Container(
                                          width: 150,
                                          height: 130,
                                          margin: EdgeInsets.only(left: 10),
                                          child: Image.asset("image/travuti.png",),
                                        ),
                                      ),

                                     /* SizedBox(height: 12.5,),

                                      InkWell(
                                        onTap: (){
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ReferEarn()));
                                        },
                                        child: Container(
                                          width: 150,
                                          height: 112.5,
                                          margin: EdgeInsets.only(left: 10),
                                          child: Image.asset("image/referlatmice.png",),
                                        ),
                                      ),*/

                                      SizedBox(height: 20,),

                                      InkWell(
                                        onTap: (){
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TourSpl()));
                                        },
                                        child: Container(
                                          width: 150,
                                          height: 130,
                                           margin: EdgeInsets.only(left: 10,),
                                          child: Image.asset("image/tourassistant.png",),
                                        ),
                                      )
                                    ],
                                  )

                                ],),

                            ),

                          ],

                        ),
                      ),

                      SizedBox(height: 100,),

                    ],),
                  ),
                ),
              )


            ],
          ),
        )

      ),

    );
  }

}
