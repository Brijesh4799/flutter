import 'dart:async';
import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:micetravel/Dart/perdoc.dart';
import 'package:micetravel/Dart/travdoc.dart';




class DocumentSL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Document(),
    );
  }
}

class Document extends StatefulWidget {

  @override
  State createState() => MyDocument();
}

class MyDocument extends State<Document> {

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
                child: Text("Travel Documents",
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
          image: DecorationImage(
            image: AssetImage("image/travbgmice.jpg"),
            fit: BoxFit.cover,
          ),),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              InkWell(
                onTap:  (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TravDoc() ));
                  print("is pressed");
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                     // color: Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.lightBlueAccent,width: 4.0),
                      gradient: LinearGradient(
                        //   begin: Alignment.topLeft,
                        //   end: Alignment.bottomRight,
                        colors: [
                          Colors.lightBlue.withOpacity(0.50),
                          Colors.lightBlue.withOpacity(0.50),
                        ],
                        //  stops: [0.0,1.0]
                      )

                  ),
                  margin: EdgeInsets.only(left: 20,right: 20),
                    padding: EdgeInsets.only(top: 17,bottom: 17),

                  child: Row(

                      children: [

                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 20),
                          child : Text("Travel Documents",
                              style: TextStyle(color: Colors.white,fontSize: 18,
                                  fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                        ),

                        Spacer(),

                        Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(right: 20),
                          child: Image.asset("image/travdociconmice.png",height: 60, width: 40,),
                        ),

                      ],
                    ),

                ),
              ),

              SizedBox(height: 75,),

              InkWell(
                onTap:  (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PerDoc() ));
                  print("is pressed");
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    // color: Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.lightBlueAccent,width: 4.0),
                      gradient: LinearGradient(
                        //   begin: Alignment.topLeft,
                        //   end: Alignment.bottomRight,
                        colors: [
                          Colors.lightBlue.withOpacity(0.50),
                          Colors.lightBlue.withOpacity(0.50),
                        ],
                        //  stops: [0.0,1.0]
                      )

                  ),
                  margin: EdgeInsets.only(left: 20,right: 20),
                  padding: EdgeInsets.only(top: 17,bottom: 17),

                  child: Row(

                    children: [

                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 20),
                        child : Text("Personal Documents",
                            style: TextStyle(color: Colors.white,fontSize: 18,
                                fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                      ),

                      Spacer(),

                      Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: 20),
                        child: Image.asset("image/perdocicon.png",height: 60, width: 40,),
                      ),

                    ],
                  ),

                ),
              ),

             // SizedBox(height: 30),



            ],
          ),

      ),

    );
  }

}
