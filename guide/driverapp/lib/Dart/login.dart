
import 'dart:convert';


import 'package:driverapp/Apis/apis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../Models/ProfileModel.dart';
import '../Models/loginmodel.dart';
import '../main.dart';
import 'otp.dart';


class Login extends StatefulWidget {
  // ItemDetail({required this.itemlist});

  @override
  State createState() => new MyLogin();


}

class MyLogin extends State<Login> {

  late SharedPreferences prefsotp, prefmobno, prefroleid;

  bool loadCircle = false;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();


  // String url = "https://travcrm.in/travcrm-dev_1.5/Api/App/mobile_login_action.php";

  // String url = TravApis.LOGIN+"mobRefId="+mobile!;

  var mobileNoup = "";
  var m_mobileNo = TextEditingController();

  var role={"Tour Manager","Driver","Guide"};

  String roleid="3";

  String sendrole="Tour Manager";

  String? UserOtp = "1";
  String? MobNumber = "1";
  String? Message = "1";

  @override
  void initState() {
    super.initState();

  }

  String? mobileValidate(String? value) {
    if (value == null || value.isEmpty || value.length!=10)
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
        //  resizeToAvoidBottomInset: false,
          body: Stack(
            children: [

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
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 110,),
                  height: 410,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [

                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          border: Border.all(
                            color: Colors.white, //                   <--- border color
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              //   begin: Alignment.topLeft,
                              //   end: Alignment.bottomRight,
                              colors: [
                                Colors.black45.withOpacity(0.15),
                                Colors.black45.withOpacity(0.15),
                              ],
                              //  stops: [0.0,1.0]
                            )
                        ),
                        height: 410,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(left: 15, right: 15,),

                        child: Column(
                          children: [

                            Container(
                              margin: EdgeInsets.only(top: 10),
                              height: 45,
                              width: 100,
                              child: Image.asset("image/deboxwhite.png",),
                            ),

                            SizedBox(height: 155,),


                            Container(
                              child: Center(
                                child: Text("To Login,Please Enter your Registered",
                                  style: TextStyle(color: Colors.white,fontSize: 13,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700), ),
                              ),
                            ),

                            SizedBox(height: 10,),

                            Container(
                              child: Center(
                                child: Text("Mobile Number to Authenticate your Account",
                                  style: TextStyle(color: Colors.white,fontSize: 13,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700), ),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 20,right: 20,top: 10),
                              padding: EdgeInsets.only(top:10,bottom: 10),
                              width: MediaQuery.of(context).size.width,
                              height: 92,
                              decoration: BoxDecoration(
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
                                      Colors.black45.withOpacity(0.15),
                                      Colors.black45.withOpacity(0.15),
                                    ],
                                    //  stops: [0.0,1.0]
                                  )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                            //    crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                Container(
                                  margin: EdgeInsets.only(left: 15,bottom: 5),
                                  height: 25,
                                  width: 25,
                                  child: Image.asset("image/mobicon.png",),
                                ),

                                Container(
                                  margin: EdgeInsets.only(left: 10,bottom: 7),
                                  child:Text("+91",
                                    style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700), ),
                                ),

                                Expanded(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                 //  height: 200,
                                  //  color: Colors.blueAccent,
                                      margin: EdgeInsets.only(left: 5,top: 15),
                                      child: Form(
                                        key: formkey,
                                        child: TextFormField(
                                          //  textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          maxLength: 10,
                                          style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w700),
                                          controller: m_mobileNo,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            filled: true,
                                            hintText: "Mobile Number",
                                            hintStyle: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w700),

                                          ),
                                          validator: mobileValidate,
                                        ),
                                      ),
                                    ),
                                ),
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

              Center(
                child: Container(
                    width: 115,
                    height: 80,
                    margin: EdgeInsets.only(top: 520),

                    child: SingleChildScrollView(

                      child: Column(children: [

                        InkWell(

                          onTap: () {
                            validate();
                          },
                          child: Container(
                            child: Image.asset("image/loginbutton.png", height: 80.0, width: 115),
                          ),
                        )
                      ],),
                    )
                ),

              ),


          ],)

      ),
    );
  }

  Future<List <ResultsLogin>> getLogin() async {

    setState(() {
      loadCircle = true;
    });


    List<ResultsLogin> logindata=[];

        String newurl = AppNetworkConstants.LOGIN + "mobileNumber=" + m_mobileNo.text.trim() + "&roleId=" + roleid;

        print("login url is : "+newurl);

      var res = await http.post(
          Uri.parse(newurl),
          body: ({'mobileNumber': m_mobileNo.text.trim()})
      );

      var datas = jsonDecode(res.body)['results'] as List;
      setState(() {
        loadCircle = false;
      });

      logindata = datas.map((data) => ResultsLogin.fromJson(data)).toList();

      UserOtp = logindata[0].userotp;
      Message = logindata[0].message;
      MobNumber = logindata[0].mobileNumber;

      print("My latest Mobile Number is: $MobNumber");
      print("My latest Message is: $Message");

      if (MobNumber == null) {

        Fluttertoast.showToast(
          msg: "$Message",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 12.0,
        );

      }
      else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return Otp();
        }));

        prefsotp = await SharedPreferences.getInstance();
        prefsotp.setString("otp", UserOtp!);

        prefroleid = await SharedPreferences.getInstance();
        prefroleid.setString("roleid", roleid);

        prefmobno = await SharedPreferences.getInstance();
        prefmobno.setString("mobile", MobNumber!);
      }

      print("Mobile Number is : $MobNumber");
      print("Message is : $Message");

      return logindata;
  }


  void validate() {
    if (formkey.currentState!.validate()) {
      print("OK");
      getLogin();

      //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyBottomNavigationBar()));
    } else {
      print("Error");
    }
  }
}