import 'dart:async';
import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:micetravel/Dart/pancard.dart';
import 'package:micetravel/Dart/passport.dart';
import 'package:micetravel/Dart/voter.dart';
import 'aadhar.dart';



class PerDocSL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: PerDoc(),
    );
  }
}

class PerDoc extends StatefulWidget {

  @override
  State createState() => MyPerDoc();
}

class MyPerDoc extends State<PerDoc> {

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
                //   margin: EdgeInsets.only(right: 5),
                child: Text("Attach Personal Documents",
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
        decoration: BoxDecoration(
          color: Colors.white),

          child: Column(
          //  mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(height: 10,),

              InkWell(
                onTap:  (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Aadhar() ));
                  print("is pressed");
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 20,right: 20),
                  child: Row(

                      children: [

                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 20),
                          child : Text("Aadhar",
                              style: TextStyle(color: Colors.lightBlue,fontSize: 22,
                                  fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                        ),

                        Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(left: 25),
                          child: Image.asset("image/adharmice.png",height: 65, width: 45,),
                        ),

                        Spacer(),

                        Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(right: 30),
                          child: Image.asset("image/plusmice.png",height: 40, width: 25,),
                        ),

                      ],
                    ),

                ),
              ),

              SizedBox(height:25,),

              Container(
                margin: EdgeInsets.only(left: 5,right: 5),
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: Colors.grey,
              ),

              SizedBox(height: 10,),

              InkWell(
                onTap:  (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Pan() ));
                  print("is pressed");
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 20,right: 20),
                  child: Row(

                    children: [

                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 20),
                        child : Text("Pan Card",
                            style: TextStyle(color: Colors.lightBlue,fontSize: 22,
                                fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                      ),

                      Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(left: 25),
                        child: Image.asset("image/pancardmice.png",height: 60, width: 35,),
                      ),

                      Spacer(),

                      Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: 30),
                        child: Image.asset("image/plusmice.png",height: 40, width: 25,),
                      ),

                    ],
                  ),

                ),
              ),

              SizedBox(height: 25,),

              Container(
                margin: EdgeInsets.only(left: 5,right: 5),
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: Colors.grey,
              ),

              SizedBox(height: 10,),

              InkWell(
                onTap:  (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Voter() ));
                  print("is pressed");
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 20,right: 20),
                  child: Row(

                    children: [

                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 20),
                        child : Text("Voter Id ",
                            style: TextStyle(color: Colors.lightBlue,fontSize: 22,
                                fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                      ),

                      Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(left: 25),
                        child: Image.asset("image/voterid_mice.png",height: 50, width: 30,),
                      ),

                      Spacer(),

                      Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: 30),
                        child: Image.asset("image/plusmice.png",height: 40, width: 25,),
                      ),

                    ],
                  ),

                ),
              ),

              SizedBox(height: 25,),

              Container(
                margin: EdgeInsets.only(left: 5,right: 5),
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: Colors.grey,
              ),

              SizedBox(height: 10,),


              InkWell(
                onTap:  (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Passport() ));
                  print("is pressed");
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 20,right: 20),
                  child: Row(

                    children: [

                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 20),
                        child : Text("Passport",
                            style: TextStyle(color: Colors.lightBlue,fontSize: 22,
                                fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                      ),

                      Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(left: 25),
                        child: Image.asset("image/passportmice.png",height: 65, width: 45,),
                      ),

                      Spacer(),

                      Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: 30),
                        child: Image.asset("image/plusmice.png",height: 40, width: 25,),
                      ),

                    ],
                  ),

                ),
              ),

              SizedBox(height: 10,),

              Container(
                margin: EdgeInsets.only(left: 5,right: 5),
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: Colors.grey,
              ),

              SizedBox(height: 35,),

              InkWell(
                  onTap: () {
                   // validate();
                  },
                  child: Container(
                    //   height:,
                    width: 140,
                    padding: EdgeInsets.only(top: 10, bottom: 10, left: 10,right: 10),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(5),
                      //   border: Border.all(color: Colors.lightBlue,width: 1.0)
                    ),
                    child: Center(
                      child: Text("Upload",
                        style: TextStyle(color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'BebesNeue',
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  )
              ),


             // SizedBox(height: 30),



            ],
          ),

      ),

    );
  }


}
