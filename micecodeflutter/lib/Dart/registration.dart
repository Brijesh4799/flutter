import 'dart:async';
import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/Apis.dart';
import 'login.dart';



class ResgistrationSL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Resgistration(),
    );
  }
}

class Resgistration extends StatefulWidget {

  @override
  State createState() => MyResgistration();
}

class MyResgistration extends State<Resgistration> {

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  var firstnameup = "";
  var lastnameup = "";
  var mobileNoup = "";
  var emailidup = "";

  var m_fisrtname = TextEditingController();
  var m_lasttname = TextEditingController();
  var m_mobileNo = TextEditingController();
  var m_emailid = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  String? firstValidate(String? value) {
    if (value == null || value.isEmpty)
      return 'Enter a First Name';
    else
      firstnameup = value;
    print("Password is : " + firstnameup);
    return null;
  }

  String? lastValidate(String? value) {
    if (value == null || value.isEmpty)
      return 'Enter a Last Name';
    else
      lastnameup = value;
    print("Password is : " + firstnameup);
    return null;
  }

  String? mobileValidate(String? value) {
    if (value == null || value.isEmpty)
      return 'Enter a Mobile No';
    else
      mobileNoup = value;
    print("Password is : " + mobileNoup);
    return null;
  }



  String? emailValidate(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value))
      return 'Enter a valid email address';
    else
      emailidup = value;
    print("Email Id is : " + emailidup);
    return null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(

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
                    child: Text("Registration",
                        style: TextStyle(color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'BebesNeue',
                            fontWeight: FontWeight.w700)),
                  ),


                ],

              ),
            ),

            SizedBox(height: 20,),

            Container(
              width: 100,
              height: 80,
              child: Image.asset("image/profileimg.png"),
            ),

            SizedBox(height: 10,),

            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Center(
                child: Text("Please Enter the Name, Mobile No & Email-ID",
                  style: TextStyle(color: Colors.lightBlueAccent,
                      fontSize: 14,
                      fontFamily: 'BebesNeue',
                      fontWeight: FontWeight.w700)),
              ),

            ),

            SizedBox(height: 2.5,),

            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Center(
                child: Text("the Field below to Registration.",
                    style: TextStyle(color: Colors.lightBlueAccent,
                        fontSize: 14,
                        fontFamily: 'BebesNeue',
                        fontWeight: FontWeight.w700)),
              ),

            ),

            SizedBox(height: 15,),

            Expanded(
              child: SingleChildScrollView(

                child: Form(
                  key: formkey,
                  child: Column(
                    children: [

                      SizedBox(height: 15,),

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 40,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          controller: m_fisrtname,
                          decoration: InputDecoration(
                              icon: Image.asset("image/profileicon.png", width: 25, height: 25,),
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              labelText: "First Name",
                               border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),

                          ),
                              validator: firstValidate,
                        ),

                      ),

                      SizedBox(height: 20,),

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 40,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          controller: m_lasttname,
                          decoration: InputDecoration(
                              icon: Image.asset("image/profileicon.png", width: 25,
                                height: 25,),
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              labelText: "Last Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                              validator: lastValidate,
                        ),

                      ),

                      SizedBox(height: 20,),

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 55,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          controller: m_mobileNo,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          decoration: InputDecoration(
                              icon: Image.asset("image/mobilereg.png", width: 25,
                                height: 25,),
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              labelText: "Mobile No",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),

                          ),
                              validator: mobileValidate,
                        ),

                      ),

                      SizedBox(height: 20,),

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 40,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          controller: m_emailid,
                          decoration: InputDecoration(
                              icon: Image.asset("image/emailicon.png", width: 22, height: 25,),
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              labelText: "Email-ID",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                              validator: emailValidate,
                        ),

                      ),

                      SizedBox(height: 20,),

                      SizedBox(height: 10,),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(left: 15, right: 15),
                        child: Center(
                          child: Text("By Registry in, You agree to company &",
                              style: TextStyle(color: Colors.lightBlueAccent,
                                  fontSize: 14,
                                  fontFamily: 'BebesNeue',
                                  fontWeight: FontWeight.w700)),
                        ),

                      ),

                      SizedBox(height: 2.5,),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(left: 15, right: 15),
                        child: Center(
                          child: Text("Representative to Contact you.",
                              style: TextStyle(color: Colors.lightBlueAccent,
                                  fontSize: 14,
                                  fontFamily: 'BebesNeue',
                                  fontWeight: FontWeight.w700)),
                        ),

                      ),

                      SizedBox(height: 15,),

                      ConstrainedBox(

                        constraints: BoxConstraints.tightFor(
                            height: 40, width: 200),

                        child: ElevatedButton(
                          onPressed: () {
                            /*firstnameup= m_fisrtname.text.trim();
                            lastnameup= m_lasttname.text.trim();
                            dobup= m_dob.text.trim();
                            anniversarydateup= m_anniversarydate.text.trim();
                            addressup= m_address.text.trim();
                            emailidup = m_emailid.text.trim();
                            mobileNoup= m_mobileNo.text.trim();*/

                             validate();
                          //  updateProfile();
                          },
                          child: Text("Submit", style: TextStyle(fontSize: 16)),
                        ),
                      ),

                      SizedBox(height: 30,),

                    ],
                  ),
                ),
              ),
            )

          ],
        ),

      ),

    );
  }


  Future<void> getRegistered() async {
    String url = TravApis.REGISTRATION;

    print("Registration Url is "+url);

    if (m_fisrtname.text.trim().isNotEmpty && m_lasttname.text.trim().isNotEmpty &&
         m_emailid.text.trim().isNotEmpty && m_mobileNo.text.trim().isNotEmpty) {

      var res = await http.post(Uri.parse(url),

          body: ({'firstName': m_fisrtname.text.trim(),
            'lastName': m_lasttname.text.trim(),
            'email': m_emailid.text.trim(),
            'phoneNo': m_mobileNo.text.trim()})
      );

      print("Registration response is "+res.body);

      print("First Name is : " + m_fisrtname.text.trim());
      print("Last Name is : " + m_lasttname.text.trim());
      print("Email-Id is : " + m_emailid.text.trim());
      print("Phone No is : " + m_mobileNo.text.trim());

      Fluttertoast.showToast(
          msg: "Thank you registering with us, we will get back you shortly",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 12.0
      );
      Navigator.pop(context);

  }

    else {
      print("Please Fills Fields");
    }
  }

  void validate() {
    if (formkey.currentState!.validate()) {
      print("Ok");
      print("Thank you registering with us, we will get back you shortly");
      getRegistered();
      //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyBottomNavigationBar()));
    } else {
      print("Error");
    }
  }



}
