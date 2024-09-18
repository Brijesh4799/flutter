import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:micetravel/Dart/pictures.dart';
import 'package:micetravel/Dart/rating.dart';

import 'experience.dart';



class TripFeedBackSL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: TripFeedBack(),
    );
  }
}

class TripFeedBack extends StatefulWidget {

  @override
  State createState() => MyTripFeedBack();
}

class MyTripFeedBack extends State<TripFeedBack> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color(0xff263238),
        title:  Container(
          padding: EdgeInsets.only(top: 17.5, bottom: 17.5),
          color: Color(0xff263238),
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
               //  margin: EdgeInsets.only(left: 15),
                child: Text("Trip Feedback",
                    style: TextStyle(color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'BebesNeue',
                        fontWeight: FontWeight.w700)),
              )

            ],

          ),
        ),
      ),

      body: Container(
       /* decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("image/financebg.jpg"),
            fit: BoxFit.cover,
          ),),*/

        child: Container(
       //   margin: EdgeInsets.only(bottom: 50),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Rating()));

                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey,width: 2.0)
                  ),
                  margin: EdgeInsets.only(left: 20,right: 20),
                  padding: EdgeInsets.only(top: 10,bottom: 10),

                  child: Row(

                    children: [

                      Container(
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey,width: 2.0)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              child: Image.asset("image/ratingicon.jpg",height: 65, width: 90,),
                            ),

                            Container(

                              margin: EdgeInsets.only(top: 12.5,bottom: 15),
                              child : Text("RATINGS",
                                  style: TextStyle(color: Colors.black,fontSize: 14,
                                      fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                            ),

                          ],

                        ),
                      ),

                      Expanded(
                        // flex: 1,
                        child:Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 15),
                              child : Text("Please rate your trip",
                                  style: TextStyle(color: Colors.grey,fontSize: 12,
                                      fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                ),
              ),

              SizedBox(height: 25),

              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Experience()));

                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey,width: 2.0)
                  ),
                  margin: EdgeInsets.only(left: 20,right: 20),
                  padding: EdgeInsets.only(top: 10,bottom: 10),

                  child: Row(

                    children: [

                      Container(
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey,width: 2.0)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              child: Image.asset("image/experience.png",height: 65, width: 90,),
                            ),

                            Container(

                              margin: EdgeInsets.only(top: 12.5,bottom: 15),
                              child : Text("EXPERIENCE",
                                  style: TextStyle(color: Colors.black,fontSize: 14,
                                      fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                            ),

                          ],

                        ),
                      ),

                      Expanded(
                        // flex: 1,
                        child:Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 15),
                              child : Text("Share your experience and\nhelp us to serve you better\nin future.",
                                  style: TextStyle(color: Colors.grey,fontSize: 12,
                                      fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),

                ),
              ),

              SizedBox(height: 25),

              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Pictures()));

                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey,width: 2.0)
                  ),
                  margin: EdgeInsets.only(left: 20,right: 20),
                  padding: EdgeInsets.only(top: 10,bottom: 10),

                  child: Row(

                    children: [

                      Container(
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey,width: 2.0)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Image.asset("image/pictures.png",height: 65, width: 90,),
                            ),

                            Container(

                              margin: EdgeInsets.only(top: 12.5,bottom: 15),
                              child : Text("PICTURES",
                                  style: TextStyle(color: Colors.black,fontSize: 14,
                                      fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                            ),

                          ],

                        ),
                      ),

                      Expanded(
                        // flex: 1,
                        child:Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 15),
                              child : Text("Post pictures and share\nwonderful memories of\nyour trip.",
                                  style: TextStyle(color: Colors.grey,fontSize: 12,
                                      fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                ),
              ),


            ],
          ),
        ),

      ),




    );
  }

}
