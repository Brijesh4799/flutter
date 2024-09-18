
import 'dart:convert';


import 'package:driverapp/Apis/apis.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../Models/loginmodel.dart';
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

  String roleid="2";

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
      child: SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [

                    Container(
                      margin: EdgeInsets.only( top: 20),
                      child:  Image.asset("image/dalogolat.png",height: 50, width: 140,),
                    ),

                    SizedBox(height: 20,),

                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Center(
                        child: Text("LOGIN", style: TextStyle(color: Colors.black, fontSize: 22, fontFamily: 'BebesNeue',
                            fontWeight: FontWeight.w700),),
                      ),


                    ),

                  ],

                ),
              ),


              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 60),
                  height: 290,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [

                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          border: Border.all(
                            color: Colors.blue, //                   <--- border color
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(left: 15, right: 15,),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            SizedBox(height: 25,),

                           /* Container(
                                alignment: Alignment.center,
                                width: 200.0,
                                height: 60.0,
                                child: DropdownButtonHideUnderline(
                                  child: Theme(
                                    data: Theme.of(context)
                                        .copyWith(canvasColor: Colors.white),
                                    child:  DropdownButton(
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.black,
                                      ),
                                      focusColor: Colors.white,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14),
                                      items: role
                                          .map((String itemnames) {
                                        return DropdownMenuItem<String>(
                                            value: itemnames,
                                            child: Text(itemnames, textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 16,
                                            )));
                                      }).toList(),
                                      onChanged: (String? value) {

                                        sendrole = value!;

                                        switch (sendrole) {

                                          case "Tour Manager":
                                            setState(() {
                                              roleid="1";
                                              print("role id is "+roleid!);
                                            });
                                            break;

                                          case "Driver":
                                            setState(() {
                                              roleid="2";
                                              print("role id is "+roleid!);
                                            });
                                            break;

                                          case "Guide":
                                            setState(() {
                                              roleid="3";
                                              print("role id is "+roleid!);
                                            });
                                            break;
                                        }
                                      },
                                      value: sendrole,
                                    ),
                                  ),
                                ),

                                decoration: BoxDecoration(

                                  border: Border.all(
                                    color: Colors.black, //                   <--- border color
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                )

                            ),*/

                            SizedBox(height: 25,),

                            Form(
                              key: formkey,
                              child: Column(
                                children: [

                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 50,
                                    margin: EdgeInsets.only(left: 40, right: 40),

                                    child: TextFormField(
                                      textAlign: TextAlign.start,
                                      keyboardType: TextInputType.number,
                                      maxLength: 10,
                                      controller: m_mobileNo,
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        hintText: "Mobile Number",
                                        icon: Image.asset("image/mobilereg.png", width: 30,
                                          height: 30,),
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

                            Spacer(),

                            InkWell(
                              onTap: (){
                                validate();
                              //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {return Otp();}));
                              },
                              child: Container(
                                  height: 50,
                                  //  margin: EdgeInsets.only(top: 5),
                                  child: Center(
                                    child: Text("LOGIN", style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'BebesNeue',
                                        fontWeight: FontWeight.w700),),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    border: Border.all(
                                      color: Colors.orange, //                   <--- border color
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(7.5),bottomRight: Radius.circular(7.5)),
                                  )

                              ),
                            ),
                          ],

                        ),
                      ),

                      Container(

                        margin: EdgeInsets.only(top: 25),

                        child:Container(
                          margin: EdgeInsets.only( right: 0),
                          child:  Image.asset("image/pwdnew.png",height: 40, width: 140,),
                        )

                        /*Row(
                          children: [

                            Expanded(
                              //   flex: 1,
                              child: Container(
                                margin: EdgeInsets.only(left: 105,top: 5),
                                child:Text("Powered by",
                                    style: TextStyle(color: Colors.black,fontSize: 12,
                                        fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),),),

                            Expanded(
                              //  flex: 1,
                                child: )
                          ],
                        )*/,

                      ),
                    ],

                  ),
                ),
              ),


            ],)

        ),
      ),
    );
  }

  Future<List <ResultsLogin>> getLogin() async {

    setState(() {
      loadCircle = true;
    });


    List<ResultsLogin> logindata=[];

        String newurl = AppNetworkConstants.LOGIN + "mobileNumber=" + m_mobileNo.text.trim() + "&roleId=" + roleid;

        print("Login url is : "+newurl);

      var res = await http.post(
          Uri.parse(newurl),
          body: ({'mobileNumber': m_mobileNo.text.trim()})
      );

    print("Login api Response is  : " +res.body);

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
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) {
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

    } else {
      print("Error");
    }
  }
}