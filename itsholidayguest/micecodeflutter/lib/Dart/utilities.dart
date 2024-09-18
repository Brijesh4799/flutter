

import 'package:flutter/material.dart';
import 'package:micetravel/Dart/translatest.dart';
import 'package:micetravel/Dart/weather.dart';
import 'currst.dart';



class UtiliesSL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Utilies(),
    );
  }
}

class Utilies extends StatefulWidget {

  @override
  State createState() => MyUtilies();
}

class MyUtilies extends State<Utilies> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title:  Container(
          padding: EdgeInsets.only(top: 17.5, bottom: 17.5),
          color: Colors.lightBlueAccent,
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
                child: Text("Travel Utilites",
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
            image: AssetImage("image/utilites.png"),
            fit: BoxFit.cover,
          ),),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

             /* Row(
                children: [

                  Container(
                    margin: EdgeInsets.only(left: 20, top: 60),
                    child: Text("Travel Utilites",
                        style: TextStyle(color: Color(0xffb71c1c),fontSize: 20,
                            fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                  ),
                ],
              ),*/

             /* SizedBox(height: 60,),*/

              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CurST()));
                  print("is pressed");
                },

                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.lightBlue,width: 4.0)
                  ),
                  margin: EdgeInsets.only(left: 20,right: 20),
                  padding: EdgeInsets.only(top: 10,bottom: 10),

                  child: Row(

                    children: [

                      Expanded(
                        // flex: 1,
                        child:Column(
                          children: [
                            SizedBox(height: 10,),
                            Container(
                              width: 170,
                              height: 40,
                              margin: EdgeInsets.only(left: 35),
                              child : Text("Currency",
                                  style: TextStyle(color: Color(0xff263238),fontSize: 20,
                                      fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                            ),

                            Container(
                              width: 170,
                              height: 40,
                              margin: EdgeInsets.only(left: 35),
                              child : Text("Convertor",
                                  style: TextStyle(color: Color(0xff263238),fontSize: 20,
                                      fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        //flex: 1,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 100,
                          width: 80,
                          margin: EdgeInsets.only(left: 25),
                          child: Image.asset("image/currencycolor.png",height: 90, width: 100,),
                        ),
                      ),


                    ],
                  ),

                ),
              ),

              SizedBox(height: 40),

              InkWell(
                onTap:  (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TranslateST()));
                  print("is pressed");
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.lightBlue,width: 4.0)
                  ),
                  margin: EdgeInsets.only(left: 20,right: 20),
                  padding: EdgeInsets.only(top: 17.5,bottom: 17.5),

                  child: Row(

                    children: [

                      Expanded(
                        // flex: 1,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          width: 160,
                          height: 40,
                          margin: EdgeInsets.only(left: 35),
                          child : Text("Translator",
                              style: TextStyle(color: Color(0xff263238),fontSize: 20,
                                  fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                        ),
                      ),

                      Expanded(
                        //flex: 1,
                        child: Container(
                       //   alignment: Alignment.centerRight,
                          height: 85,
                          width: 55,
                          margin: EdgeInsets.only(right: 15),
                          child: Image.asset("image/translatoricons.png",height: 60, width: 50,),
                        ),
                      ),

                    ],
                  ),

                ),
              ),

              SizedBox(height: 40),

              InkWell(
                onTap:  (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Weather()));
                  print("is pressed");
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.lightBlue,width: 4.0)
                  ),
                  margin: EdgeInsets.only(left: 20,right: 20),
                  padding: EdgeInsets.only(top: 17.5,bottom: 17.5),

                  child: Row(

                    children: [

                      Expanded(
                        // flex: 1,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          width: 160,
                          height: 40,
                          margin: EdgeInsets.only(left: 35),
                          child : Text("Weather",
                              style: TextStyle(color: Color(0xff263238),fontSize: 20,
                                  fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                        ),
                      ),

                      Expanded(
                        //flex: 1,
                        child: Container(
                          //   alignment: Alignment.centerRight,
                          height: 85,
                          width: 55,
                          margin: EdgeInsets.only(right: 15),
                          child: Image.asset("image/weather.png",height: 65, width: 55,),
                        ),
                      ),

                    ],
                  ),

                ),
              ),


            ],
          ),

      ),

    );
  }

}
