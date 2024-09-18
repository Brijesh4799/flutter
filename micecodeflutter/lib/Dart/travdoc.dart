import 'dart:async';
import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:micetravel/Dart/visa.dart';



class TravDocSL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: TravDoc(),
    );
  }
}

class TravDoc extends StatefulWidget {

  @override
  State createState() => MyTravDoc();
}

class MyTravDoc extends State<TravDoc> {

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
                child: Text("Attach Travel Documents",
                    style: TextStyle(color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'BebesNeue',
                        fontWeight: FontWeight.w700)),
              )

            ],

          ),
        ),
      ),

      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white),

            child: Column(
            //  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Expanded(
                 
                  child: SingleChildScrollView(
                    child: Column(children: [

                      SizedBox(height: 20,),

                      InkWell(
                        onTap:  (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Visa() ));
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
                                child : Text("Visa",
                                    style: TextStyle(color: Colors.lightBlue,fontSize: 22,
                                        fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                              ),

                              Container(
                                alignment: Alignment.centerRight,
                                margin: EdgeInsets.only(left: 25),
                                child: Image.asset("image/visamice.png",height: 65, width: 45,),
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

                      SizedBox(height: 55,),

                      Container(
                        margin: EdgeInsets.only(left: 5,right: 5),
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                        color: Colors.grey,
                      ),

                      SizedBox(height: 75,),


                    ],),
                  ),
                ),

               
               // SizedBox(height: 30),



              ],
            ),

        ),
      ),

    );
  }




}
