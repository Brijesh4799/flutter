import 'dart:async';
import 'dart:convert';

import 'package:driverapp/Dart/BottomNavHome.dart';
import 'package:driverapp/Models/otpmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Apis/apis.dart';
import '../Models/NotificationModel.dart';
import '../Models/ProfileModel.dart';
import '../Models/loginmodel.dart';
import '../main.dart';




class OtpSL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Otp(),
    );
  }
}

class Otp extends StatefulWidget {

  @override
  State createState() => MyOtp();
}

class MyOtp extends State<Otp> {

  bool loadCircle = false;

  static const maxSeconds = 60;
  int seconds = maxSeconds;

  Timer? timer;



  late SharedPreferences prefsotp, prefmobno, prefroleid, prefuserid, prefrolename, prefstatus,preffullname,prefnotification;


  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  var mobileNoup = "";
  var m_mobileNo = TextEditingController();


  String roleid = "0";
  String? UserOtp = "";
  String? MobNumber = "1";
  String? MobileNo = "1";
  String? Message = "1";
  String? RoleName = "1";
  String? fullname ="1";


  String myotp = "1234";
  String fillotp = "";

  String? UserId = "1";
  String? Role = "1";
  String? OnlineStatus = "1";

  bool isEditable=true;
  bool isChangable=false;
  bool isOTPVisible=true;
  bool isResendVisible=true;
  bool isEditBlack=false;
  bool isEditRed=true;

  bool isResendBlack=false;
  bool isResendRed=true;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (seconds == 0) {
          timer?.cancel();
          seconds = 60;
          setState(() {
            UserOtp="0";
            print(" OTP is clear : $UserOtp");
          });
          getOTPTimerInVisible();
          getEditBlackVisible();
          getResendBlackVisible();
        }
        else {
          getEditRedVisible();
          getResendRedVisible();
          getOTPTimerVisible();
          seconds--;
        }
      });
    });
  }

  getEditBlackVisible(){
    setState(() {
      isEditBlack=true;
      isEditRed=false;
      print("is clicked false");
    });
  }

  getEditRedVisible(){
    setState(() {
      isEditBlack=false;
      isEditRed=true;
      print("is clicked false");
    });
  }

  getResendBlackVisible(){
    setState(() {
      isResendBlack=true;
      isResendRed=false;
      print("is clicked false");
    });
  }

  getResendRedVisible(){
    setState(() {
      isResendBlack=false;
      isResendRed=true;
      print("is clicked false");
    });
  }



  getOTPTimerInVisible(){
    setState(() {
      isOTPVisible=false;
      print("is clicked false");
    });
  }

  getOTPTimerVisible(){
    setState(() {
      isOTPVisible=true;
      print("is clicked false");
    });
  }

  getOTPVisible(){
    if(UserOtp==null){
      setState(() {
        isOTPVisible=false;
        print("is clicked false");
      });

    }
    else{
      setState(() {
        isOTPVisible=true;
        print("is clicked true");
      });
    }
  }

  getResendVisible(){
    setState(() {
      isResendVisible=true;
      print("is clicked false");
    });
  }

  getResendInVisible(){
    setState(() {
      isResendVisible=false;
      print("is clicked false");
    });
  }

  getEdit(){
    setState(() {
      isEditable=false;
      isChangable=true;
    });
  }

  getChange(){
    setState(() {
      isEditable=true;
      isChangable=false;
      getOTPVisible();
    });
  }


  @override
  void initState() {
    super.initState();
    startTimer();
    getPrefUserOtp();
    getPrefRoleID();
    getPrefMobile();
  }

  Future getPrefRoleID() async {
    prefroleid = await SharedPreferences.getInstance();
    setState(() {
      roleid = prefroleid.getString("roleid")!;
      print("my Recieved roleid is : $roleid");
    });
  }

  Future getPrefMobile() async {
    prefmobno = await SharedPreferences.getInstance();
    setState(() {
      MobileNo = prefmobno.getString("mobile")!;
      print("my Recieved mobile no is : $MobileNo");
    });
  }

  Future getPrefUserOtp() async {
    prefsotp = await SharedPreferences.getInstance();
    setState(() {
      UserOtp = prefsotp.getString("otp")!;
      print("my Recieved OTP is : $UserOtp");
    });
  }

  String? mobileValidate(String? value) {
    if (value == null || value.isEmpty || value.length != 10)
      return 'Enter a Mobile No';
    else
      mobileNoup = value;
    print("Password is : " + mobileNoup);
    return null;
  }


  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      progressIndicator: const CircularProgressIndicator(color: Color(0xff1a237e),strokeWidth: 5),
      inAsyncCall: loadCircle,
      child: Scaffold(
        resizeToAvoidBottomInset: false,



        body: Stack(children: [

          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: EdgeInsets.all(0),
              child:   Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("image/loginbglat.png"),
                    fit: BoxFit.cover,
                  ),
                ),

              ),
            ),


          ),

         
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 50),
               height: 340,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [

                  Container(
                    decoration:BoxDecoration(
                        color: Color(0xffffffff),
                        border: Border.all(
                          color: Colors.white, //                   <--- border color
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          //   begin: Alignment.topLeft,
                          //   end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.85),
                            Colors.white.withOpacity(0.85),
                          ],
                          //  stops: [0.0,1.0]
                        )
                    ),
                    height: 340,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    margin: EdgeInsets.only(left: 15, right: 15,),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        SizedBox(height: 10,),

                        Container(
                          child: Center(
                            child: Text("Please Enter OTP Which Was Sent On Below",
                              style: TextStyle(color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'BebesNeue',
                                  fontWeight: FontWeight.w700),),
                          ),
                        ),

                        SizedBox(height: 2.5,),

                        Container(
                          child: Center(
                            child: Text("Mobile Number",
                              style: TextStyle(color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'BebesNeue',
                                  fontWeight: FontWeight.w700),),
                          ),
                        ),


                        SizedBox(height: 10,),


                        Visibility(
                          visible: isEditable,
                          child: Container(
                            margin: EdgeInsets.only(top: 15),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Container(
                                //  margin: EdgeInsets.only(left: 75,),
                                  child: Text(MobileNo!,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontFamily: 'BebesNeue',
                                          fontWeight: FontWeight.w700)),),

                                SizedBox(width: 10),

                                Visibility(
                                  visible: isEditBlack,
                                  child: InkWell(
                                    onTap: (){
                                      getEdit();
                                      getResendRedVisible();
                                      // getResendInVisible();
                                    },
                                    child: Container(
                                      width: 70,
                                      padding: EdgeInsets.only(top: 2.5, bottom: 2.5,),
                                      decoration: BoxDecoration(
                                        color: Color(0xffffffff),
                                        border: Border.all(
                                          color: Colors.black,
                                          //                   <--- border color
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    //  margin: EdgeInsets.only(right: 75),
                                      child: Center(
                                        child: Text("Edit",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13,
                                                fontFamily: 'BebesNeue',
                                                fontWeight: FontWeight.w700)),
                                      ),),
                                  ),
                                ),

                                Visibility(
                                  visible: isEditRed,
                                  child:InkWell(
                                    onTap: (){
                                      //  getEdit();
                                      //  getResendInVisible();
                                    },
                                    child: Container(
                                      width: 70,
                                      padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
                                      decoration: BoxDecoration(
                                        color: Color(0xffd50000),
                                        border: Border.all(
                                          color: Color(0xffd50000),
                                          //                   <--- border color
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                     // margin: EdgeInsets.only(right: 75),
                                      child: Center(
                                        child: Text("Edit",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontFamily: 'BebesNeue',
                                                fontWeight: FontWeight.w700)),
                                      ),),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ),



                        Visibility(
                          visible: isChangable,
                          child: Container(
                            child: Row(
                              children: [

                                Form(
                                  key: formkey,
                                  child: Column(
                                    children: [

                                      Container(
                                        width: 200,
                                        height: 50,
                                        margin: EdgeInsets.only(left: 20,),

                                        child: TextFormField(
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          maxLength: 10,
                                          controller: m_mobileNo,
                                          style: TextStyle(color: Colors.black),
                                          decoration: InputDecoration(
                                            hintStyle: TextStyle(color: Colors.black),
                                            border: InputBorder.none,
                                            fillColor: Colors.transparent,
                                            filled: true,
                                            hintText: "Mobile Number",
                                            icon: Image.asset(
                                              "image/mobilereg.png", width: 25,
                                              height: 25,),
                                            /*enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                    color: Colors.blue,
                                                    width: 2.0,
                                                  )
                                              ),*/

                                          ),
                                          validator: mobileValidate,
                                        ),

                                      ),

                                      SizedBox(height: 15,)],
                                  ),
                                ),


                                InkWell(
                                  onTap: () {
                                    validate();

                                    //  getResendVisible();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10, bottom: 30),
                                    padding: EdgeInsets.only(
                                        top: 2.5, bottom: 2.5, left: 10, right: 10),
                                    decoration: BoxDecoration(
                                      color: Color(0xffffffff),
                                      border: Border.all(
                                        color: Colors.black,
                                        //                   <--- border color
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text("Change",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 13,
                                              fontFamily: 'BebesNeue',
                                              fontWeight: FontWeight.w700)),
                                    ),),
                                ),
                              ],

                            ),
                          ),
                        ),

                        SizedBox(height: 25,),

                        Container(
                          child: Center(
                            child: Text(" Enter OTP",
                              style: TextStyle(color: Colors.black,
                                fontSize: 13,),),
                          ),
                        ),

                        SizedBox(height: 20,),

                        Container(
                          margin: EdgeInsets.only(left: 70, right: 70),
                          child: PinCodeTextField(
                            appContext: context,
                            length: 4,
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.black,
                            // enabled: false,
                            // controller: TextEditingController(text: UserOtp),
                            onChanged: (value) {
                              print("OTP Values from box : $UserOtp");
                            },
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 45,
                              fieldWidth: 40,
                              borderWidth: 1,
                              inactiveColor: Colors.black,
                              activeColor: Colors.black,
                            ),
                            onCompleted: (value) {
                              setState(() {
                                fillotp = value;
                                if (fillotp == UserOtp) {
                                  print("Valid No");
                                }
                                else {
                                  print("Invalid No");
                                }
                              });
                            },
                          ),
                        ),


                        Container(
                          margin: EdgeInsets.only(top: 15),

                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Container(
                                margin: EdgeInsets.only(left: 10,),
                                child: Text("00:" + seconds.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: 'BebesNeue',
                                        fontWeight: FontWeight.w700)),),

                              SizedBox(width: 10),

                              Visibility(
                                visible: isResendBlack,
                                child: InkWell(
                                  onTap: () {
                                    startTimer();
                                    getLoginResend();
                                  },
                                  child: Container(
                                    width: 105,
                                    padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
                                    decoration: BoxDecoration(
                                      color: Color(0xffffffff),
                                      border: Border.all(
                                        color: Colors.black,
                                        //                   <--- border color
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  //  margin: EdgeInsets.only(right: 70),
                                    child: Center(
                                      child: Text("Resend OTP",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 13,
                                              fontFamily: 'BebesNeue',
                                              fontWeight: FontWeight.w700)),
                                    ),),
                                ),
                              ),

                              Visibility(
                                visible: isResendRed,
                                child: InkWell(
                                  onTap: () {
                                    //   startTimer();
                                    //   getLoginResend();
                                  },
                                  child: Container(
                                    width: 105,
                                    padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
                                    decoration: BoxDecoration(
                                      color: Color(0xffd50000),
                                      border: Border.all(
                                        color: Color(0xffd50000),
                                        //                   <--- border color
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                 //   margin: EdgeInsets.only(right: 70),
                                    child: Center(
                                      child: Text("Resend OTP",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontFamily: 'BebesNeue',
                                              fontWeight: FontWeight.w700)),
                                    ),),
                                ),
                              ),

                            ],
                          ),
                        ),

                        SizedBox(height: 10,),

                        Visibility(
                          visible: isOTPVisible,
                          child: Container(
                            width: 100,
                            padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
                            child: Center(
                              child: Text("OTP : " + UserOtp!,
                                style: TextStyle(color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'BebesNeue',
                                    fontWeight: FontWeight.w700),),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              border: Border.all(
                                color: Colors.green,
                                //                   <--- border color
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),

                        Spacer(),

                      ],

                    ),
                  ),


                ],

              ),
            ),
          ),

          Center(
            child: Container(
                width: 115,
                height: 80,
                margin: EdgeInsets.only(top: 390),

                child: SingleChildScrollView(

                  child: Column(children: [

                    InkWell(

                      onTap: () {
                        getOtp();
                      },
                      child: Container(
                        child: Image.asset("image/loginbutton.png", height: 80.0, width: 115),
                      ),
                    )
                  ],),
                )
            ),

          ),
        ],

        ),

      ),
    );
  }




  Future<List <ResultsLogin>> getLogin() async {

    setState(() {
      loadCircle = true;
    });

    List<ResultsLogin> logindata=[];

      String newurl = AppNetworkConstants.LOGIN + "mobileNumber=" +
          m_mobileNo.text.trim() + "&roleId=" + roleid;

      print(newurl);

      var res = await http.post(
          Uri.parse(newurl),
          body: ({'mobileNumber': m_mobileNo.text.trim()})
      );

      var datas = jsonDecode(res.body)['results'] as List;

    setState(() {
      loadCircle = false;
    });

      logindata = datas.map((data) => ResultsLogin.fromJson(data)).toList();

      Message = logindata[0].message;
      UserOtp = logindata[0].userotp;
      MobNumber = logindata[0].mobileNumber;

      print("My latest USEROTP is : $UserOtp");
    print("My latest MOBILENO is : $MobNumber");

      if(UserOtp==null){
        getOTPVisible();
        UserOtp="0";
       // MobNumber="0";

        print("My Updated latest USEROTP is : $UserOtp");
     //   print("My Updated latest MOBILENO is : $MobNumber");

        Fluttertoast.showToast(
          msg: "Please Enter Valid Number",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 12.0,
        );
      }

      print("My latest Mobile Number is: $MobNumber");
      print("My latest Message is: $Message");

      if (MobNumber == null) {
      //   getChange();
        Fluttertoast.showToast(
          msg: "$Message",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 12.0,
        );
      }
      else {
        getChange();
        startTimer();
        getResendBlackVisible();
        prefsotp = await SharedPreferences.getInstance();
        prefsotp.setString("otp", UserOtp!);

        prefroleid = await SharedPreferences.getInstance();
        prefroleid.setString("roleid", roleid);

        prefmobno = await SharedPreferences.getInstance();
        prefmobno.setString("mobile", MobNumber!);
        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {return Otp();}));
      }

      print("Mobile Number is : $MobNumber");
      print("Message is : $Message");



      return logindata;

  }


  void validate() {
    if (formkey.currentState!.validate()) {
      print("OK");
      getLogin();
      /* Fluttertoast.showToast(
          msg: "Ok",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 12.0
      );*/
      //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyBottomNavigationBar()));
    } else {
      print("Error");
    }
  }

  Future<List <ResultsLogin>> getLoginResend() async {

    setState(() {
      loadCircle = true;
    });

    List<ResultsLogin> logindata=[];

    String newurl = AppNetworkConstants.LOGIN + "mobileNumber=" + MobileNo! + "&roleId=" + roleid;

    print(newurl);

    var url = Uri.parse(newurl);

    print("Loading from api");
    http.Response res = await http.get(url);


    /* var res = await http.post(
        Uri.parse(newurl),
        body: ({'mobileNumber': m_mobileNo.text.trim()})
    );*/

    var datas = jsonDecode(res.body)['results'] as List;

    setState(() {
      loadCircle = false;
    });

    logindata = datas.map((data) => ResultsLogin.fromJson(data)).toList();

    Message = logindata[0].message;
    UserOtp = logindata[0].userotp;
    MobNumber = logindata[0].mobileNumber;

    print("My latest USEROTP is : $UserOtp");
    print("My latest MOBILENO is : $MobNumber");

    if(UserOtp==null){
      getOTPVisible();
      UserOtp="0";
      // MobNumber="0";

      print("My Updated latest USEROTP is : $UserOtp");
      //   print("My Updated latest MOBILENO is : $MobNumber");

      Fluttertoast.showToast(
        msg: "Please Enter Valid Number",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0,
      );
    }

    print("My latest Mobile Number is: $MobNumber");
    print("My latest Message is: $Message");

    if (MobNumber == null) {
      //   getChange();
      Fluttertoast.showToast(
        msg: "$Message",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0,
      );
    }
    else {
      getChange();
      prefsotp = await SharedPreferences.getInstance();
      prefsotp.setString("otp", UserOtp!);

      prefroleid = await SharedPreferences.getInstance();
      prefroleid.setString("roleid", roleid);

      prefmobno = await SharedPreferences.getInstance();
      prefmobno.setString("mobile", MobNumber!);
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {return Otp();}));
    }

    print("Mobile Number is : $MobNumber");
    print("Message is : $Message");



    return logindata;

  }

  Future<List <PolicyOtp>> getOtp() async {

    List<PolicyOtp> logindata=[];

   if(fillotp!="") {


     print("My latest fillotp is : $fillotp");

     String newurl = AppNetworkConstants.OTP + "mobileNumber=" + MobileNo! +
         "&myotp=" + fillotp + "&userotp=" + UserOtp! + "&roleId=" + roleid;

     print("OTP url is : " + newurl);

     var res = await http.post(
         Uri.parse(newurl),
         body: ({'userotp': fillotp})
     );


     var datas = jsonDecode(res.body)['policy'] as List;

     setState(() {
       loadCircle = false;
     });

     logindata = datas.map((data) =>
         PolicyOtp.fromJson(data)).toList();


     UserId = logindata[0].userid!;
     Role = logindata[0].role!;
     OnlineStatus = logindata[0].onlineStatus!;

     prefuserid = await SharedPreferences.getInstance();
     prefuserid.setString("userid", UserId!);

    prefrolename = await SharedPreferences.getInstance();
    prefrolename.setString("rolename", Role!);

    prefstatus = await SharedPreferences.getInstance();
    prefstatus.setString("status", OnlineStatus!);


     if (UserId != null) {

       if (fillotp == UserOtp) {
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {return MyBottomNavigationBar();}));
         print("OTP matched");
       } else {
         print("OTP Doesn't matched");

         Fluttertoast.showToast(
           msg: "OTP not matched",
           toastLength: Toast.LENGTH_SHORT,
           gravity: ToastGravity.CENTER,
           timeInSecForIosWeb: 4,
           backgroundColor: Colors.black,
           textColor: Colors.white,
           fontSize: 12.0,
         );
       }
     }
     else {
       Fluttertoast.showToast(
         msg: "OTP not matched",
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.CENTER,
         timeInSecForIosWeb: 4,
         backgroundColor: Colors.black,
         textColor: Colors.white,
         fontSize: 12.0,
       );
       print("OTP not matched");
     }

     print("OTP is : $UserOtp");
     print("Message is : $Message");

     setState(() {
       loadCircle = true;
     });


     return logindata;
   }


   else{
     Fluttertoast.showToast(
       msg: "Please Enter OTP",
       toastLength: Toast.LENGTH_SHORT,
       gravity: ToastGravity.CENTER,
       timeInSecForIosWeb: 4,
       backgroundColor: Colors.black,
       textColor: Colors.white,
       fontSize: 12.0,
     );
     return logindata;
   }
  }

}
