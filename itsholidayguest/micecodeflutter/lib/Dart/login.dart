
import 'dart:async';
import 'dart:convert';


import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:micetravel/Dart/otp.dart';
import 'package:micetravel/Dart/privacywv.dart';
import 'package:micetravel/Dart/termswv.dart';
import 'package:micetravel/Models/loginmcmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:google_sign_in/google_sign_in.dart';


import 'package:http/http.dart' as http;

import '../Utils/Apis.dart';


class Login extends StatefulWidget {
  // ItemDetail({required this.itemlist});

  @override
  State createState() => new MyLogin();


}

class MyLogin extends State<Login> {

  late SharedPreferences prefsotp, prefRefid, prefId,prefquotationId,preftype,prefqueryId,prefadhaar,prefpan,prefpass,prefvacine,prefphno,prefagenda;

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
  String? phoneno = "";

  String? dob = "YY-MM-DD";
  String? username = "Guest Name";

  String connectstatus="Wifi";

  Connectivity _connectivity = Connectivity();

  var dobno = "";

  var dobNo = TextEditingController();

  var mobilenumber = "";

  var tourID = TextEditingController();
  var mobNo = TextEditingController();

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

  //  timer = Timer.periodic(Duration(seconds: 3),(Timer t) => getAuto());
  }


  /*String? tourIDValidate(String? value) {
    if (value == null || value.isEmpty)
      return "Enter a Guest-Id";
    else
      refid = value;
    print("Email Id is : " + refid);
    return null;
  }*/

  String? tourIDValidate(String? value) {
    if (value == null || value.isEmpty)
      return "Enter Your Tour-Id";
    else
      refid = value;
    print("Email Id is : " + refid);
    return null;
  }

  String? mobNoValidate(String? value) {
    if (value == null || value.isEmpty)
      return "Enter Your Mobile No";
    else
      mobilenumber = value;
    print("Mobile No is : " + mobilenumber);
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

            Container(

              child: Text(""),
              width:MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height ,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("image/funbg.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),

            Row(mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                 // color: Colors.black54,
                margin: EdgeInsets.only( top: 60),
                child: Image.asset("image/itslogo.png",height: 150, width: 150,),
              ),],
            ),
          //  SizedBox(height: 100,),

            Align(
              alignment: Alignment.bottomCenter,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.white,
                elevation: 20,
                margin: EdgeInsets.only(left: 20,right: 20,bottom: 105),
                child: Container(
                  height: 415,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 15, right: 15,bottom: 0),
                //  margin: EdgeInsets.only(top:50),
                 // margin: EdgeInsets.only(left: 15, right: 15,bottom: 10),
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

                              /*Container(
                                margin: EdgeInsets.only(top: 10),
                                height: 80,
                                width: 95,
                                child: Image.asset("image/fun.png",height: 30, width: 35,),
                              ),*/

                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Text("LOGIN",
                                  style: TextStyle(color: Color(0xFF59CB09),
                                      fontSize: 24,
                                      fontFamily: 'BebesNeue',
                                      fontWeight: FontWeight.w700),),
                              ),

                              SizedBox(height: 25,),

                             /* Container(
                                margin: EdgeInsets.only(left: 2.5, right: 2.5),
                                child: Text("Enter Your Mobile No and Tour ID ",
                                  style: TextStyle(color: Color(0xFF6c899b),
                                      fontSize: 13,
                                      fontFamily: 'BebesNeue',
                                      fontWeight: FontWeight.w700),),
                              ),
*/


                             /* Container(
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
                              ),*/


                             /* Container(
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
                                  ],
                                ),
                              ),*/

                              Container(
                                margin: EdgeInsets.only(left: 5, right: 5),
                                decoration: BoxDecoration(
                                  color: Color(0xffffffff),
                                  border: Border.all(
                                    color: Color(0xFF6c899b), //                   <--- border color
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(15),

                                ),
                                child: Row(
                                  children: [

                                    /*Container(
                                      margin: EdgeInsets.only(left: 15,bottom: 5),
                                      height: 25,
                                      width: 25,
                                      child: Image.asset("image/mobilereg.png",),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(left: 10,bottom: 7),
                                      child:Text("+91",
                                        style: TextStyle(color: Color(0xFF6c899b),fontSize: 16,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700, decoration: TextDecoration.none,
                                          decorationThickness: 0,), ),
                                    ),*/

                                    Container(
                                     // color: Colors.blue,
                                      width: 200,
                                      margin: EdgeInsets.only(left: 20, right: 10),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        maxLines: 1,
                                        maxLength: 10,
                                        textAlign: TextAlign.start,
                                        controller: mobNo,
                                        style: TextStyle(color: Color(0xFF6c899b),fontSize: 16,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700,),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          counter: Offstage(),
                                          hintText: "Enter Your Mobile No",
                                          hintStyle: TextStyle(color: Color(0xFF6c899b),fontSize: 16,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700,),
                                        ),
                                        validator: mobNoValidate,
                                      ),

                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 20,),

                              Container(

                                decoration: BoxDecoration(
                                  // color: Colors.grey,
                                  border: Border.all(width: 2,color: Color(0xFF6c899b)),
                                  borderRadius: BorderRadius.circular(15),

                                ),
                                width: MediaQuery.of(context).size.width,
                                height: 55,
                                margin: EdgeInsets.only(left: 5, right: 5),
                                padding: EdgeInsets.only(left: 20),
                                child: TextFormField(
                                  textAlign: TextAlign.start,
                                  controller: tourID,
                                  style: TextStyle(color: Color(0xFF6c899b),fontSize: 16,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    // fillColor: Colors.grey.shade100,
                                    //  filled: true,
                                    hintText: "Enter Your Reference Id",
                                    hintStyle: TextStyle(color: Color(0xFF6c899b),fontSize: 16,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                                    /*border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                ),*/

                                  ),
                                  validator: tourIDValidate,
                                ),

                              ),


                              SizedBox(height: 20,),

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
                                            fontSize: 9,
                                            fontFamily: 'BebesNeue',
                                            decoration: TextDecoration.underline,
                                            decorationColor: Color(0xFFffc20e),
                                            decorationStyle: TextDecorationStyle.solid,
                                            decorationThickness: 3,
                                            fontWeight: FontWeight.w700),),
                                    ),
                                  ),

                                  InkWell(
                                    onTap: () {

                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 5, right: 5),
                                      child: Text("&",
                                        style: TextStyle(color: Color(0xFFffc20e),
                                            fontSize: 9,
                                            fontFamily: 'BebesNeue',
                                            decoration: TextDecoration.underline,
                                            decorationColor: Color(0xFFffc20e),
                                            decorationStyle: TextDecorationStyle.solid,
                                            decorationThickness: 3,
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
                                            fontSize: 9,
                                            fontFamily: 'BebesNeue',
                                            decoration: TextDecoration.underline,
                                            decorationColor: Color(0xFFffc20e),
                                            decorationStyle: TextDecorationStyle.solid,
                                            decorationThickness: 3,
                                            fontWeight: FontWeight.w700),),
                                    ),
                                  ),


                                ],),



                              SizedBox(height: 25,),

                              InkWell(

                                onTap: () {
                                  validate();
                                  //   myMessage();
                                },
                                child: Container(
                                  width: 120,
                                  // margin: EdgeInsets.only(left: 5,right: 10),
                                  padding: EdgeInsets.only(top: 12.5, bottom: 12.5, left: 0,right: 0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFA6D131),
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
                              ),

                              SizedBox(height: 30,),



                              Container(
                                // color: Color(0x62ffffff),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 0),
                                  child: Row(
                                    children: [

                                      Expanded(
                                        //   flex: 1,
                                        child: Container(
                                          margin: EdgeInsets.only(left: 75,top: 5),
                                          child:Text("Powered by",maxLines: 1,
                                              style: TextStyle(color: Colors.black54,fontSize:13,
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

                              ),

                              SizedBox(height: 10,),

                            ],
                          ),
                        ),
                      ),
                    ],

                    ),
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

 /* Future<List <ResultsLogin>> getLogin() async {

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

     }*/



  Future<List <ResultsLoginmc>> getLogin() async {
    String newurl = TravApis.GUESTLOGIN + "mobRefId=" + tourID.text.trim()+"&mobile="+mobNo.text.toString();

    List<ResultsLoginmc> logindata=[];

    try{
      print("Login URL : " +newurl);

      var res = await http.post(
          Uri.parse(newurl),
          body: (
              {
                'mobRefId': tourID.text.trim(),
                'mobile': mobNo.text.trim()
              }
          )
      );

      print("Login Responsee is " +res.body);

      var datas = jsonDecode(res.body)['results'] as List;

      logindata = datas.map((data) => ResultsLoginmc.fromJson(data)).toList();

      MobRefid = logindata[0].mobRefId;
      Error = logindata[0].error;
      Otppin = logindata[0].otp;
      Id = logindata[0].id;
      type = logindata[0].type;
      quotationId = logindata[0].quotationId;
      queryId = logindata[0].queryId;

      print("Mobile Red Id  is $MobRefid" );
      print("Quation Id  is $quotationId" );


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

        preftype = await SharedPreferences.getInstance();
        preftype.setString("type", type!);

        prefqueryId = await SharedPreferences.getInstance();
        prefqueryId.setString("queryId", queryId!);

        prefadhaar = await SharedPreferences.getInstance();
        prefadhaar.setString("adhaar", logindata[0].adhaar!);

         prefpan = await SharedPreferences.getInstance();
        prefpan.setString("pan", logindata[0].pan!);

        prefpass = await SharedPreferences.getInstance();
        prefpass.setString("pass", logindata[0].pass!);

         prefvacine= await SharedPreferences.getInstance();
         prefvacine.setString("vacine", logindata[0].vacc!);

        prefphno= await SharedPreferences.getInstance();
        prefphno.setString("phone", logindata[0].mobile!);


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

}