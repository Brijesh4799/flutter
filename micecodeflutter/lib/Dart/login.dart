
import 'dart:async';
import 'dart:convert';


import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:micetravel/Dart/otp.dart';
import 'package:micetravel/Dart/privacywv.dart';
import 'package:micetravel/Dart/termswv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';


import 'package:http/http.dart' as http;

import '../Models/automodel.dart';
import '../Models/loginmodel.dart';
import '../Utils/Apis.dart';
import '../main.dart';


class Login extends StatefulWidget {
  // ItemDetail({required this.itemlist});

  @override
  State createState() => new MyLogin();


}

class MyLogin extends State<Login> {

  late SharedPreferences prefsotp, prefRefid, prefId,prefquotationId,preftype,prefqueryId;

  Timer? timer;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  GlobalKey<FormState> formkeydob = GlobalKey<FormState>();

  var refid = "";
  String? MobRefid = "";
  String? Error = "";
  String? Otppin = "";
  String? quotationId = "";
  String? queryId = "";
  String? Id = "";
  String? type = "";

  String? dob = "YY-MM-DD";
  String? username = "Guest Name";

  String connectstatus="Wifi";

  Connectivity _connectivity = Connectivity();

  var tourID = TextEditingController();

  var dobno = "";

  var dobNo = TextEditingController();

  String? dobValidate(String? value) {
    if (value == null || value.isEmpty)
      return "Enter a DOB";
    else
      dobno = value;
    print("Email Id is : " + dobno);
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkRealTimeConnection();
    print("init state is working");

    timer = Timer.periodic(Duration(seconds: 3),(Timer t) => getAuto());
  }


  String? tourIDValidate(String? value) {
    if (value == null || value.isEmpty)
      return "Enter a Guest-Id";
    else
      refid = value;
    print("Email Id is : " + refid);
    return null;
  }

  void checkRealTimeConnection() async{
    _connectivity.onConnectivityChanged.listen((event) {

      if(event == ConnectivityResult.wifi){
        setState(() {
          connectstatus = "Wifi";
          print("Connection is : " +connectstatus);
        });

      }
      else if(event == ConnectivityResult.mobile){
        setState(() {
          connectstatus = "MobileData";
          print("Connection is : " +connectstatus);
        });

      }
      else{
        setState(() {
          connectstatus = "No Internet Connection";
          print("Connection is : " +connectstatus);
          Fluttertoast.showToast(
            msg: connectstatus,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 4,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 12.0,
          );
        });
      }

    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
     //  resizeToAvoidBottomInset: false,
        /*  appBar: AppBar(
          title: Text('Login'),
          textTheme: TextTheme(
              headlineSmall: TextStyle(color: Colors.blue, fontSize: 6,)),
          elevation: 15,),*/


          body: Stack(children: [

          /*  Container(
              color: Color(0x62ffffff),
              child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Container(
                        child: Text("Powered by",
                          style: TextStyle(color: Colors.grey,
                              fontSize: 10,
                              fontFamily: 'BebesNeue',
                              fontWeight: FontWeight.w700),),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Image.asset("image/deboxicon.png",height: 30, width: 50,),
                      )

                    ],
                  ),
                ),
              ),

            ),*/

            Container(

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                    margin: EdgeInsets.only( top: 15),
                    child: Image.asset("image/micelogo.png",height: 80, width: 100,),
                  )

                  /*Expanded(
                      flex: 1,
                      child: Visibility(
                        visible: false,
                        child: Container(
                          //  margin: EdgeInsets.only( top: 5),
                          child: Image.asset("image/deboxicon.png",height: 30, width: 35,),
                        ),
                      )),
                  
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        SizedBox(height: 10,),

                        Container(
                          child: Image.asset("image/ebixmice.png",height: 70, width: 180,),
                         // margin: EdgeInsets.only(top: 20,),
                        ),

                        Container(
                         // margin: EdgeInsets.only(left: 2.5, right: 2.5),
                          child: Text("TRAVEL COMPANY",
                            style: TextStyle(color: Color(0xFF6c899b),
                                fontSize: 9,
                                fontFamily: 'BebesNeue',
                                fontWeight: FontWeight.w700),),
                        ),

                      ],
                    ),
                  ),

                  Expanded(
                      flex: 1,
                      child: Container(
                          margin: EdgeInsets.only( top: 15),
                        child: Image.asset("image/micelogo.png",height: 30, width: 35,),
                      ))*/
                ],
              ),

              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("image/loginbglatmice.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 375,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 15, right: 15,bottom: 10),
                decoration: BoxDecoration(color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),


                child: SingleChildScrollView(
                  child: Column(children: [


                    Form(
                      key: formkey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [

                            Container(
                              margin: EdgeInsets.only(top: 10),
                              height: 50,
                              width: 95,
                              child: Image.asset("image/deboxicon.png",height: 30, width: 35,),
                            ),

                           /* InkWell(
                              onTap: (){
                              //  googleSignIn();
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 10),
                                height: 50,
                                width: 95,
                                child: Image.asset("image/infosysmice.png",),
                              ),
                            ),*/


                           /* Container(
                              margin: EdgeInsets.only(left: 2.5, right: 2.5),
                              child: Text("CORPPERATE LOGO",
                                style: TextStyle(color: Color(0xFF6c899b),
                                    fontSize: 10,
                                    fontFamily: 'BebesNeue',
                                    fontWeight: FontWeight.w700),),
                            ),*/

                            SizedBox(height: 10,),


                            Container(
                              margin: EdgeInsets.only(left: 2.5, right: 2.5),
                              child: Text(" To Login, Please Enter Your Guest ID ",
                                style: TextStyle(color: Color(0xFF6c899b),
                                    fontSize: 13,
                                    fontFamily: 'BebesNeue',
                                    fontWeight: FontWeight.w700),),
                            ),


                            SizedBox(height: 5,),

                            Container(
                              margin: EdgeInsets.only(left: 60,right: 60,top: 7.5),
                              // padding: EdgeInsets.only(bottom: 10),
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                                border: Border.all(
                                  color: Color(0xFF6c899b), //                   <--- border color
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(30),

                              ),
                              child: Row(children: [

                                Container(
                                  margin: EdgeInsets.only(left: 30),
                                  height: 25,
                                  width: 25,
                                  child: Image.asset("image/guestid.png",),
                                ),

                                Expanded(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.only(left: 30, right: 10),
                                    child: TextFormField(
                                      // textAlign: TextAlign.center,
                                      controller: tourID,
                                      decoration: InputDecoration(

                                        // fillColor: Colors.grey.shade100,
                                        //   filled: true,
                                        hintText: "Guest ID",
                                        border: InputBorder.none,

                                      ),
                                      validator: tourIDValidate,
                                    ),

                                  ),
                                ),
                              ],

                              ),
                            ),

                            SizedBox(height: 15,),

                            Container(
                              // margin: EdgeInsets.only(left: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Container(
                                    margin: EdgeInsets.only(left:2.5, right: 2.5),
                                    child: Text("Welcome ,",
                                      style: TextStyle(color: Color(0xFF0097a5),
                                          fontSize: 14,
                                          fontFamily: 'BebesNeue',
                                          fontWeight: FontWeight.w700),),
                                  ),

                                  Container(
                                    width: 90,
                                    margin: EdgeInsets.only(left: 2.5, right: 2.5),
                                    child: Text(username.toString(),
                                      style: TextStyle(color: Color(0xFF0097a5),
                                        //  decoration: TextDecoration.underline,
                                          fontSize: 14,
                                          fontFamily: 'BebesNeue',
                                          fontWeight: FontWeight.w700),maxLines: 1),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              height: 2,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              margin: EdgeInsets.only(left: 85, right:82.5),
                              color: Color(0xFF0097a5),
                            ),

                            SizedBox(height: 10,),

                            Container(
                              // margin: EdgeInsets.only(left: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Container(
                                    height: 20,
                                    width: 20,
                                    child: Image.asset("image/dob.png",),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(left: 10, ),
                                    child: Text(dob.toString(),
                                      style: TextStyle(color:  Color(0xFF6c899b),
                                          fontSize: 14,
                                          fontFamily: 'BebesNeue',
                                          fontWeight: FontWeight.w700),),
                                  ),

                                 /* Container(
                                    margin: EdgeInsets.only(top: 2.5,left: 10),
                                    width: 100,
                                    height: 30,
                                    child: Form(
                                      key: formkeydob,
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        controller: dobNo,
                                        style: TextStyle(fontSize: 12),
                                        decoration: InputDecoration(
                                          hintText: "Enter Your DOB",
                                          hintStyle: TextStyle(fontSize: 12,color: Color(0xFF6c899b)),
                                          border: InputBorder.none,

                                        ),
                                        validator: dobValidate,
                                      ),
                                    ),

                                  ),*/
                                ],
                              ),
                            ),


                            SizedBox(height: 30,),

                            Text("By Logging in, You agree to our",
                              style: TextStyle(color: Color(0xFF6c899b),
                                  fontSize: 11,
                                  fontFamily: 'BebesNeue',
                                  fontWeight: FontWeight.w700),),

                            SizedBox(height: 7.5,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [


                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Termswv()));
                                    print("is clicked");
                                  },
                                  child: Container(
                                    child: Text("Terms and Conditions",
                                      style: TextStyle(color: Color(0xFFffc20e),
                                          fontSize: 12,
                                          fontFamily: 'BebesNeue',
                                          fontWeight: FontWeight.w700),),
                                  ),
                                ),

                                InkWell(
                                  onTap: () {

                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 2.5, right: 2.5),
                                    child: Text(" & ",
                                      style: TextStyle(color: Color(0xFFffc20e),
                                          fontSize: 12,
                                          fontFamily: 'BebesNeue',
                                          fontWeight: FontWeight.w700),),
                                  ),
                                ),

                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Privacywv()));
                                  },
                                  child: Container(
                                    child: Text(" Privacy Policy",
                                      style: TextStyle(color: Color(0xFFffc20e),
                                          fontSize: 12,
                                          fontFamily: 'BebesNeue',
                                          fontWeight: FontWeight.w700),),
                                  ),
                                ),


                              ],),

                            Container(
                              height: 2,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              margin: EdgeInsets.only(left: 55, right: 55),
                              color: Color(0xFFffc20e),
                            ),

                            SizedBox(height: 20,),

                            InkWell(

                              onTap: () {
                                validate();
                                //   myMessage();
                              },
                              child: Container(
                                width: 120,
                                // margin: EdgeInsets.only(left: 5,right: 10),
                                padding: EdgeInsets.only(top: 10, bottom: 10, left: 0,right: 0),
                                decoration: BoxDecoration(
                                  color: Color(0xFF6c899b),
                                  borderRadius: BorderRadius.circular(5),
                                  //   border: Border.all(color: Colors.lightBlue,width: 1.0)
                                ),
                                child: Center(
                                  child: Text("LOG IN",
                                      style: TextStyle(color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'BebesNeue',
                                        fontWeight: FontWeight.w700,)),
                                ),
                              ),
                            )

                          ],
                        ),
                      ),
                    ),
                  ],

                  ),
                ),

              ),
            ),
            
          ],)

      ),
    );
  }

  void validate() {
    if (formkey.currentState!.validate()) {
      print("OK");
      if(connectstatus == "Wifi" || connectstatus == "MobileData"){
        getLogin();
      }else{
        print("No Connected");
        Fluttertoast.showToast(
          msg: connectstatus,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 12.0,
        );
      }


     // login();

    } else {
      print("Error");
    }
  }

  Future<void> login() async {
    if (tourID.text.trim().isNotEmpty) {



      var res = await http.post(
          Uri.parse(TravApis.LOGIN + "mobRefId=" + tourID.text.trim()),
          body: ({'username': tourID.text.trim()})
      );

      print("Tour Id are : " + tourID.text.trim());

      if (res.statusCode == 500) {
       /* Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {return MyBottomNavigationBar();}));*/
        /* Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => MyBottomNavigationBar()));*/

        Fluttertoast.showToast(
            msg: "Server Not Responding",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 12.0
        );
      }
      /*else {
        Fluttertoast.showToast(
          msg: "$Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 12.0,
        );
      }
    } else {
      print("User'Id and  Password Doesn't  Exists");
    }*/
    }
  }


  void myMessage() {
    Fluttertoast.showToast(
        msg: "is Clicked",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0
    );
  }

  Future<List <ResultsLogin>> getLogin() async {

    var output = tourID.text.trim().replaceAll("GU","");

    String newurl = TravApis.LOGIN + "guestId=" + output;

    List<ResultsLogin> logindata=[];

    try{
      print("Login URL" +newurl);

      var res = await http.post(
          Uri.parse(newurl),
          body: ({'guestId': output})
      );

      print("Login Responsee is " +res.body);

      var datas = jsonDecode(res.body)['results'] as List;

       logindata = datas.map((data) => ResultsLogin.fromJson(data)).toList();

      MobRefid = logindata[0].Refid;
      Error = logindata[0].username;
      Otppin = logindata[0].otp;
      Id = logindata[0].quotationId;
      type = logindata[0].type;
      quotationId = logindata[0].quotationId;
      queryId = logindata[0].queryId;
      Error = logindata[0].error;

      print("Mobile Red Id  is $MobRefid" );
      print("Quation Id  is $quotationId" );
      print("Query Id  is $queryId" );
      print("Error  is $Error" );


      if (MobRefid==null) {
        Fluttertoast.showToast(
          msg: "$Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 12.0,
        );
      }

     else if (MobRefid=="") {
        Fluttertoast.showToast(
          msg: "Reference Id Does Not Exist",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 12.0,
        );
      }

      else {

        prefsotp = await SharedPreferences.getInstance();
        prefsotp.setString("otp", Otppin!);

        prefRefid = await SharedPreferences.getInstance();
        prefRefid.setString("refid", MobRefid!);

        prefId = await SharedPreferences.getInstance();
        prefId.setString("id", Id!);

        prefquotationId = await SharedPreferences.getInstance();
        prefquotationId.setString("quotationId", quotationId!);

        prefqueryId = await SharedPreferences.getInstance();
        prefqueryId.setString("queryId", queryId!);

        preftype = await SharedPreferences.getInstance();
        preftype.setString("type", type!);

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {return Otp();}));

        Fluttertoast.showToast(
            msg: "OTP : $Otppin",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 6,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 12.0
        );
      }

      print("Mob ref id is : $MobRefid");
      print("Error is : $Error");


      return logindata;

    }catch(SocketException){
      Fluttertoast.showToast(
        msg: "No Internet Connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0,
      );
      return logindata;
    }

     }

  Future<List <ResultsAuto>> getAuto() async {

    var output = tourID.text.trim().replaceAll("GU","");

    String newurl = TravApis.AUTOFILL + "guestId=" + output;

    List<ResultsAuto> autodata=[];

    try{
      print("AutoFill URL" +newurl);

      var res = await http.post(
          Uri.parse(newurl),
          body: ({'guestId': tourID.text.trim()})
      );

      print("AutoFill Responsee is " +res.body);

      var datas = jsonDecode(res.body)['results'] as List;

      autodata = datas.map((data) => ResultsAuto.fromJson(data)).toList();

      username = autodata[0].username;
      dob = autodata[0].dob;
      Error = autodata[0].error;

      print("UserName Id  is $username" );
      print("Dob Id  is $dob" );
      print("Error  is $Error" );


      if (username==null) {
       username="Guest Name";
       dob="YY-MM-DD";
       print("UserName is : "+username.toString());
       print("DOB is : "+dob.toString());
      }

      else if (username=="") {
       /* Fluttertoast.showToast(
          msg: "Guest Id Does Not Exist",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 12.0,
        );*/
      }

      else{

      }

      return autodata;

    }catch(SocketException){

      print("No Internet Connection from Autofill ");
     /* Fluttertoast.showToast(
        msg: "No Internet Connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0,
      );*/
      return autodata;
    }

  }

  void googleSignIn() async{
    print("Google method is called");

    GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      var result = await _googleSignIn.signIn();

      print("result : $result");

      Fluttertoast.showToast(
        msg: "$result",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0,
      );

    } catch (error) {
      print(error);
    }
  }

}