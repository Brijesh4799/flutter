import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../Models/profilemodel.dart';
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
    return ModalProgressHUD(
      progressIndicator: const CircularProgressIndicator(color: Color(0xff1a237e),strokeWidth: 5),
      inAsyncCall: loadCircle,
      child: Scaffold(



          body: FutureBuilder(
              future: getTourAssitant(),
              builder:(context, snapshot) {

                //  snapshot.data![0];

                if(snapshot.hasData) {
                  tourdata= snapshot.data as List<ResultsTour>;

                  return SafeArea(

                      child: Column(
                        children: [

                          Container(

                            padding: EdgeInsets.only(top: 17.5, bottom: 17.5),
                            color: Color(0xff263238),
                            child: Row(
                              children: [

                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 15),
                                    child: Image.asset(
                                      "image/back.png", height: 20, width: 25,),
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text("Tour Assistant",
                                      style: TextStyle(color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: 'BebesNeue',
                                          fontWeight: FontWeight.w700)),
                                ),


                              ],

                            ),
                          ),


                          Expanded(
                            child: SingleChildScrollView(
                              child: Stack(
                                children: [

                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    child: Column(
                                      children: [

                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: 250,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage("image/guideprofileone.jpg"),
                                              fit: BoxFit.cover,

                                            ),
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
                                          ),
                                          margin: EdgeInsets.only(top:15,),
                                          child: Text(""),
                                        ),

                                        Expanded(
                                          child: SingleChildScrollView(
                                            child: Container(
                                              width: MediaQuery.of(context).size.width,
                                              height: MediaQuery.of(context).size.height,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage("image/guidehomebg.jpg"),
                                                  fit: BoxFit.cover,

                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    child: Center(
                                                      child:Image.asset("image/guideprofiletwo.png", width: 400, height: 45,),
                                                    ),
                                                  ),

                                                  SizedBox(height: 15,),

                                                  SingleChildScrollView(

                                                    child: Column(
                                                      children: [

                                                        Row(
                                                          children: [

                                                            Expanded(
                                                              flex: 1,
                                                              child: Column(children: [
                                                                Container(
                                                                  margin: EdgeInsets.only(left: 10,),
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Text("Full Name : ",
                                                                    style: TextStyle(color: Colors.grey,
                                                                        fontSize: 12,
                                                                        fontFamily: 'BebesNeue',
                                                                        fontWeight: FontWeight.w700),),
                                                                ),

                                                                SizedBox(height: 5,),

                                                                Container(
                                                                  margin: EdgeInsets.only(left: 10,),
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Text(tourdata[0].name!,
                                                                    style: TextStyle(color: Colors.black,
                                                                        fontSize: 13,
                                                                        fontFamily: 'BebesNeue',
                                                                        fontWeight: FontWeight.w700),),

                                                                ),

                                                                SizedBox(height: 25,),

                                                                Container(
                                                                  alignment: Alignment.centerLeft,
                                                                  margin: EdgeInsets.only(left: 10,),
                                                                  child: Text("Mobile No : ",
                                                                    style: TextStyle(color: Colors.grey,
                                                                        fontSize: 12,
                                                                        fontFamily: 'BebesNeue',
                                                                        fontWeight: FontWeight.w700),),
                                                                ),

                                                                SizedBox(height: 5,),

                                                                Container(
                                                                  alignment: Alignment.centerLeft,
                                                                  margin: EdgeInsets.only(left: 10,),
                                                                  child: Text(tourdata[0].phoneno!,
                                                                    style: TextStyle(color: Colors.black,
                                                                        fontSize: 13,
                                                                        fontFamily: 'BebesNeue',
                                                                        fontWeight: FontWeight.w700),),

                                                                ),

                                                                SizedBox(height: 20,),

                                                              ],),

                                                            ),

                                                            Expanded(
                                                              flex: 1,
                                                              child: Column(children: [

                                                                Container(
                                                                  alignment: Alignment.centerRight,
                                                                  margin: EdgeInsets.only(right: 10,),
                                                                  child: Text("Languages Known : ",
                                                                    style: TextStyle(color: Colors.grey,
                                                                        fontSize: 12,
                                                                        fontFamily: 'BebesNeue',
                                                                        fontWeight: FontWeight.w700),),
                                                                ),

                                                                SizedBox(height: 5,),

                                                                Container(
                                                                  alignment: Alignment.centerRight,
                                                                  margin: EdgeInsets.only(right: 10,),
                                                                  child: Text(tourdata[0].language!,
                                                                    style: TextStyle(color: Colors.black,
                                                                        fontSize: 13,
                                                                        fontFamily: 'BebesNeue',
                                                                        fontWeight: FontWeight.w700),),

                                                                ),

                                                                SizedBox(height: 25,),

                                                                Container(
                                                                  margin: EdgeInsets.only(right: 10,),
                                                                  alignment: Alignment.centerRight,
                                                                  child: Text("Email : ",
                                                                    style: TextStyle(color: Colors.grey,
                                                                        fontSize: 12,
                                                                        fontFamily: 'BebesNeue',
                                                                        fontWeight: FontWeight.w700),),
                                                                ),

                                                                SizedBox(height: 5,),

                                                                Container(
                                                                  margin: EdgeInsets.only( right: 10),
                                                                  alignment: Alignment.centerRight,
                                                                  child: Text(tourdata[0].email!,
                                                                    style: TextStyle(color: Colors.black,
                                                                        fontSize: 13,
                                                                        fontFamily: 'BebesNeue',
                                                                        fontWeight: FontWeight.w700),),

                                                                ),

                                                                SizedBox(height: 20,),



                                                              ],),
                                                            ),
                                                          ],
                                                        ),

                                                        SizedBox(height: 30),

                                                        Container(
                                                          color: Colors.transparent,

                                                          child: Row(
                                                            children: [

                                                              Expanded(
                                                                //   flex: 1,
                                                                child: InkWell(
                                                                  onTap:(){
                                                                    _makingPhoneCall();
                                                                  },
                                                                  child: Container(
                                                                    margin: EdgeInsets.only(left: 55),
                                                                    child: Image.asset("image/callicon.png",height: 65, width: 65,),),
                                                                ),),

                                                              Expanded(
                                                                //  flex: 1,
                                                                  child: InkWell(
                                                                    onTap: (){
                                                                      _makingWhatsapp();
                                                                    },
                                                                    child: Container(
                                                                      margin: EdgeInsets.only( right: 55),
                                                                      child:  Image.asset("image/whatsreficon.png",height: 65, width: 65,),
                                                                    ),
                                                                  ))
                                                            ],
                                                          ),

                                                        ),



                                                      ],
                                                    ),

                                                  ),


                                                ],
                                              ),
                                            ),
                                          ),
                                        ),

                                      ],

                                    ),
                                  ),


                                  Positioned(
                                    top: 190,left: 10,

                                    child: ClipRect(
                                        child: Image.asset("image/driver_ass_user_icon.png", height: 90.0, width: 100)),
                                  ),


                                ],),
                            ),
                          ),
                        ],
                      )

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

      if (await canLaunch(url)) {
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
