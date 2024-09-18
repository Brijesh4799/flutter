import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/profilemodel.dart';
import '../Utils/Apis.dart';



class QRCodeSL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: QRCode(),
    );
  }
}

class QRCode extends StatefulWidget {

  @override
  State createState() => MyQRCode();
}

class MyQRCode extends State<QRCode> {

  String ID="";
  String type="";

  late SharedPreferences  prefprofile, prefId, preftype;

  String? firstname = "0";
  String? lastname = "0";
  String? mobileNo = "0";
  String? emailid = "0";
  String? dob = "0";
  String? anniversarydate = "0";
  String? address = "0";
  String? accomodationpreference = "0";
  String? holidaypreference = "0";
  String? mealprefernce = "0";
  String? specialassistance = "0";
  String? qrcode = "";

  @override
  void initState() {
    getMyId();
    super.initState();
  }


  getMyId() async {
    prefId = await SharedPreferences.getInstance();
    preftype= await SharedPreferences.getInstance();

    setState(() {
      ID= prefId.getString("id")!;
      type= preftype.getString("type")!;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: FutureBuilder(
          future: getProfile(),
          builder:(context, snapshot) {

          //  snapshot.data![0];

            if(snapshot.hasData) {
              List<ResultsProfile> logindata= snapshot.data as List<ResultsProfile>;

              if(logindata.length==0){
                Fluttertoast.showToast(
                  msg: "No Data Available Now",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 4,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 12.0,
                );
              }else{

                firstname=logindata[0].firstName.toString();
                lastname=logindata[0].lastName.toString();

                //  qrcode = logindata[0].qrcode;

                if(firstname==null||lastname==null||logindata[0].qrcode==null) {

                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 20),
                      child: CircularProgressIndicator(
                        value: 0.8,
                      )
                  );
                  /* Fluttertoast.showToast(
                    msg: "No tour data found for the given Tour Id",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 3,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 12.0
                );*/
                }
                return SafeArea(

                  child: Stack(
                    children: [

                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("image/qrcodebg.png"),
                            fit: BoxFit.cover,
                          ),),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Container(
                              //    width: 200,
                              padding: EdgeInsets.only(top: 17.5, bottom: 17.5),
                              //  color: Colors.lightBlueAccent,
                              child: Row(
                                children: [

                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 15),
                                      child: Image.asset(
                                        "image/leftarrow.png", height: 20, width: 25,),
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text("QR CODE",
                                        style: TextStyle(color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'BebesNeue',
                                            fontWeight: FontWeight.w700)),
                                  ),


                                ],

                              ),
                            ),

                            SizedBox(height: 50,),






                          ],
                        ),
                      ),

                      Align(alignment: Alignment.bottomRight,
                        child: Container(
                          margin: EdgeInsets.only(right: 10,bottom: 20),
                          width: MediaQuery.of(context).size.width,
                          // margin: EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,children: [
                            InkWell(
                              onTap: () {
                                qrcode=logindata[0].qrcode!;
                                shareImage();
                              },child:

                            Container(
                              // width: 150,
                              padding: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
                              /* decoration: BoxDecoration(
                              // color: Colors.grey,
                              border: Border.all(width: 2,color: Colors.blue),
                              borderRadius: BorderRadius.circular(5),

                            ),*/
                              child: Row(
                                children: [

                                  Container(
                                    margin: EdgeInsets.only(left: 10,bottom: 0),
                                    height: 15,
                                    width: 15,
                                    child: Image.asset("image/share.png",),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text("SHARE QR CODE",
                                      style: TextStyle(color: Colors.blue,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700, decoration: TextDecoration.none,
                                        decorationThickness: 0,), ),
                                  ),
                                ],
                              ),
                            ),)
                          ],),
                        ),
                      ),

                      Center(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.white,
                          elevation: 20,
                          margin: EdgeInsets.only(left: 20,right: 20),
                          child: Container(

                            width: MediaQuery.of(context).size.width,
                            height: 500,
                            child: Column(

                              children: [


                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Image.asset(
                                    "image/itslogo.png", height: 150, width: 200,),
                                ),

                                SizedBox(height: 20),

                                Container(
                                  decoration: BoxDecoration(
                                    //  border: Border.all(color: Colors.blue, width: 5.0),
                                    //  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                    image: DecorationImage(
                                      image: AssetImage("image/qrboundy.png"),
                                      //  fit: BoxFit.cover,
                                    ),
                                  ),
                                  margin: EdgeInsets.only(left: 10,right: 10,top: 5),
                                  // color: Colors.blue,
                                  width:150,
                                  height: 150,
                                  // child: Image.asset("image/colombia1.jpg",
                                  child: Container(
                                    margin: EdgeInsets.only(left: 5,right:5,top: 5,bottom: 5),
                                    width: 150,
                                    height: 150,
                                    child: Image.network(logindata[0].qrcode!,
                                      height: 10.0, width: 10,fit: BoxFit.cover,),
                                  ),
                                ),

                                SizedBox(height: 50,),

                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(firstname!+" "+lastname!,
                                    style: TextStyle(color: Colors.black,fontSize: 25,fontFamily: 'Montserrat',fontWeight: FontWeight.w700, decoration: TextDecoration.none,
                                      decorationThickness: 0,), ),
                                ),

                                SizedBox(height: 70),

                              ],
                            ),
                          ),
                        ),
                      ),

                    ],

                  ),

                );

              }

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
      ),);

  }

  Future<List<ResultsProfile>> getProfile() async {
    String newurl = TravApis.CLIENTPROFILE + "id="+ID+ "&type="+type;

    print("Profile Url is : " + newurl.toString());

    var url = Uri.parse(newurl);

    http.Response res = await http.get(url);
    //  List datas= jsonDecode(res.body);

    print("Profile response is : " + res.body);

    var datas = jsonDecode(res.body)['results'] as List;

    List<ResultsProfile> logindata = datas.map((data) => ResultsProfile.fromJson(data)).toList();

    return logindata;
  }

  void shareImage() async {
    final response = await get(Uri.parse(qrcode!));
    final bytes = response.bodyBytes;
    final Directory temp = await getTemporaryDirectory();
    final path= '${temp.path}/image.jpg';
    //File(path).writeAsBytesSync(bytes);
    Share.shareFiles([path], text: "QR CODE",);
  }



}
