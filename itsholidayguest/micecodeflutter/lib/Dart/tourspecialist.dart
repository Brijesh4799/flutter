import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../Models/tourassistancemodel.dart';
import '../Utils/Apis.dart';



class TourSplSL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: TourSpl(),
    );
  }
}

class TourSpl extends StatefulWidget {

  @override
  State createState() => MyTourSpl();
}

class MyTourSpl extends State<TourSpl> {

  bool loadCircle = false;

  String refID="";

  late SharedPreferences prefRefid;

  late List<ResultsTour> tourdata;

  bool iscallshow=false;
  bool iswhatsappshow=false;



  @override
  void initState() {
    super.initState();
    getMyRefId();
  }

  getMyRefId() async {
    prefRefid = await SharedPreferences.getInstance();
    setState(() {
      refID = prefRefid.getString("refid")!;
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //  resizeToAvoidBottomInset: false,


          body: Stack(children: [

            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10,top: 20),
                      child: Image.asset(
                        "image/back.png", height: 20, width: 25,),
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                      Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Text("Tour Manager",
                          style: TextStyle(color: Color(0xFF00ffc2),
                              fontSize: 24,
                              fontFamily: 'BebesNeue',
                              fontWeight: FontWeight.w700),),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text("Contact Information",
                          style: TextStyle(color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'BebesNeue',
                              fontWeight: FontWeight.w700),),
                      ),
                    ],),
                  )




                 /* Container(
                    margin: EdgeInsets.only( top: 15),
                    child: Image.asset("image/fun.png",height: 90, width: 110,),
                  )*/


                ],
              ),

              height: MediaQuery.of(context).size.height / 2.5,
              decoration: BoxDecoration(
                color: Color(0xff0362A6),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40))
              ),
            ),



            Center(
              child: Container(
                height: 415,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 15, right: 15,bottom: 10,top: 180),
                decoration: BoxDecoration(color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),


                child:  FutureBuilder(
                    future: getTourAssitant(),
                    builder:(context, snapshot) {

                      if(snapshot.hasData) {
                        tourdata = snapshot.data as List<ResultsTour>;

                        if(tourdata[0].phoneno==""){
                          iscallshow=false;
                          iswhatsappshow=false;
                        }else{
                          iscallshow=true;
                          iswhatsappshow=true;
                        }

                        if(tourdata.length==0) {

                          /*Fluttertoast.showToast(
                              msg: "No GuestList Now",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 3,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 12.0
                          );
*/
                        }
                        else{
                          /* Fluttertoast.showToast(
            msg: "Updated Now : ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 12.0
        );*/
                        }

                        return  SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [


                              SizedBox(height: 100,),

                              // Name

                              Container(
                                margin: EdgeInsets.only(left: 10,),
                                child: Text("Name",
                                  style: TextStyle(color: Colors.black54,
                                      fontSize: 12,
                                      fontFamily: 'BebesNeue',
                                      fontWeight: FontWeight.w700),),
                              ),

                              SizedBox(height: 5,),

                              Container(
                                margin: EdgeInsets.only(left: 10,),
                                child: Text(tourdata[0].name.toString(),
                                  style: TextStyle(color: Colors.blueAccent,
                                      fontSize: 13,
                                      fontFamily: 'BebesNeue',
                                      fontWeight: FontWeight.w700),),
                              ),

                              SizedBox(height: 7.5,),

                              Container(
                                color: Colors.grey,
                                width: MediaQuery.of(context).size.width,
                                height: 1,
                                child: Text("",
                                  style: TextStyle(color: Colors.grey,
                                      fontSize: 13,
                                      fontFamily: 'BebesNeue',
                                      fontWeight: FontWeight.w700),),
                              ),

                              SizedBox(height: 10,),

                              // Email -ID

                              Container(
                                margin: EdgeInsets.only(left: 10,),
                                child: Text("Email-ID",
                                  style: TextStyle(color: Colors.black54,
                                      fontSize: 12,
                                      fontFamily: 'BebesNeue',
                                      fontWeight: FontWeight.w700),),
                              ),

                              SizedBox(height: 5,),

                              Container(
                                margin: EdgeInsets.only(left: 10,),
                                child: Text(tourdata[0].email.toString(),
                                  style: TextStyle(color: Colors.blueAccent,
                                      fontSize: 13,
                                      fontFamily: 'BebesNeue',
                                      fontWeight: FontWeight.w700),),
                              ),

                              SizedBox(height: 7.5,),

                              Container(
                                color: Colors.grey,
                                width: MediaQuery.of(context).size.width,
                                height: 1,
                                child: Text("",
                                  style: TextStyle(color: Colors.grey,
                                      fontSize: 13,
                                      fontFamily: 'BebesNeue',
                                      fontWeight: FontWeight.w700),),
                              ),

                              SizedBox(height: 10,),

                              // Mobile No -ID

                              Row(mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Column(mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Container(
                                          margin: EdgeInsets.only(left: 10,),
                                          child: Text("Mobile Number",
                                            style: TextStyle(color: Colors.black54,
                                                fontSize: 12,
                                                fontFamily: 'BebesNeue',
                                                fontWeight: FontWeight.w700),),
                                        ),

                                        SizedBox(height: 5,),

                                        Container(
                                          margin: EdgeInsets.only(left: 10,),
                                          child: Text(tourdata[0].phoneno.toString(),
                                            style: TextStyle(color: Colors.blueAccent,
                                                fontSize: 13,
                                                fontFamily: 'BebesNeue',
                                                fontWeight: FontWeight.w700),),
                                        ),

                                      ],),

                                    Spacer(),

                                    Visibility(
                                      visible: iscallshow,
                                      child: InkWell(
                                        onTap: (){
                                          _makingPhoneCall();
                                          print("is pressed");
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only( right: 20),
                                          child: Image.asset("image/calliconpf.png",height: 35, width: 35,),
                                        ),
                                      ),
                                    ),


                                  ]),

                              SizedBox(height: 7.5,),

                              Container(
                                color: Colors.grey,
                                width: MediaQuery.of(context).size.width,
                                height: 1,
                                child: Text("",
                                  style: TextStyle(color: Colors.grey,
                                      fontSize: 13,
                                      fontFamily: 'BebesNeue',
                                      fontWeight: FontWeight.w700),),
                              ),

                              SizedBox(height: 10,),

                              // Whats app No

                              Row(mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Column(mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Container(
                                          margin: EdgeInsets.only(left: 10,),
                                          child: Text("WhatsApp Number",
                                            style: TextStyle(color: Colors.black54,
                                                fontSize: 12,
                                                fontFamily: 'BebesNeue',
                                                fontWeight: FontWeight.w700),),
                                        ),

                                        SizedBox(height: 5,),

                                        Container(
                                          margin: EdgeInsets.only(left: 10,),
                                          child: Text(tourdata[0].phoneno.toString(),
                                            style: TextStyle(color: Colors.blueAccent,
                                                fontSize: 13,
                                                fontFamily: 'BebesNeue',
                                                fontWeight: FontWeight.w700),),
                                        ),

                                      ],),

                                    Spacer(),

                                    Visibility(
                                      visible: iswhatsappshow,
                                      child: InkWell(
                                        onTap: (){
                                          _makingWhatsapp();
                                          print("is pressed");
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only( right: 20),
                                          child: Image.asset("image/whatsiconpf.png",height: 35, width: 35,),
                                        ),
                                      ),
                                    ),


                                  ]),

                              SizedBox(height: 7.5,),

                              Container(
                                color: Colors.grey,
                                width: MediaQuery.of(context).size.width,
                                height: 1,
                                child: Text("",
                                  style: TextStyle(color: Colors.grey,
                                      fontSize: 13,
                                      fontFamily: 'BebesNeue',
                                      fontWeight: FontWeight.w700),),
                              ),

                              SizedBox(height: 10,),

                              // Language

                              Container(
                                margin: EdgeInsets.only(left: 10,),
                                child: Text("Language Known",
                                  style: TextStyle(color: Colors.black54,
                                      fontSize: 12,
                                      fontFamily: 'BebesNeue',
                                      fontWeight: FontWeight.w700),),
                              ),

                              SizedBox(height: 5,),

                              Container(
                                margin: EdgeInsets.only(left: 10,),
                                child: Text(tourdata[0].language.toString(),
                                  style: TextStyle(color: Colors.blueAccent,
                                      fontSize: 13,
                                      fontFamily: 'BebesNeue',
                                      fontWeight: FontWeight.w700),),
                              ),

                              SizedBox(height: 7.5,),

                              Container(
                                color: Colors.grey,
                                width: MediaQuery.of(context).size.width,
                                height: 1,
                                child: Text("",
                                  style: TextStyle(color: Colors.grey,
                                      fontSize: 13,
                                      fontFamily: 'BebesNeue',
                                      fontWeight: FontWeight.w700),),
                              ),






                            ],
                          ),
                        );
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


              ),
            ),

            Center(
              child: Container(
                margin: EdgeInsets.only( bottom: 220),
                child: Image.asset("image/profileiconpf.png",height: 120, width: 150,),
              ),
            )

          ],)

      ),
    );

  }

  Future<List<ResultsTour>> getTourAssitant() async {
    String newurl = TravApis.TOURASSTANT + "RefId="+refID;

    print("Tour Assistant Url is : " + newurl.toString());

    var url = Uri.parse(newurl);

    http.Response res = await http.get(url);
    //  List datas= jsonDecode(res.body);

    print("Tour Assistant response is : " + res.body);

    var datas = jsonDecode(res.body)['results'] as List;

    List<ResultsTour> tourdata = datas.map((data) =>
        ResultsTour.fromJson(data)).toList();

    return tourdata;
  }

  _makingPhoneCall() async {

    //  const url = 'tel:9910910910';

    if(tourdata[0].phoneno==""){
      Fluttertoast.showToast(
        msg: "Can't Call Now",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0,
      );
    }else{
      String url = 'tel:'+tourdata[0].phoneno!;

      if (await launch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  _makingWhatsapp() async {
    // String url = '+919910910910';

    //  await launch('https://wa.me/$url?text=Welcome');

    if(tourdata[0].phoneno==""){
      Fluttertoast.showToast(
        msg: "Can't Sent Message",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0,
      );
    }else{
      String url = tourdata[0].phoneno!;

      await launch("whatsapp://send?phone="+url+"&text=hello");
    }
  }


}
