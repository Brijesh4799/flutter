import 'dart:async';
import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/Apis.dart';
import '../main.dart';
import 'login.dart';



class ProfileUpdateSL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: ProfileUpdate(),
    );
  }
}

class ProfileUpdate extends StatefulWidget {

  @override
  State createState() => MyProfileUpdate();
}

class MyProfileUpdate extends State<ProfileUpdate> {

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  var firstnameup = "";
  var lastnameup = "";
  var mobileNoup = "";
  var emailidup = "";
  var dobup = "";
  var anniversarydateup = "";
  var addressup = "";

  var m_fisrtname = TextEditingController();
  var m_lasttname = TextEditingController();
  var m_mobileNo = TextEditingController();
  var m_emailid = TextEditingController();
  var m_dob = TextEditingController();
  var m_anniversarydate = TextEditingController();
  var m_address = TextEditingController();





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

  String? dobValidate(String? value) {
    if (value == null || value.isEmpty)
      return 'Enter a DOB';
    else
      dobup = value;
    print("Password is : " + dobup);
    return null;
  }

  String? aniversaryValidate(String? value) {
    if (value == null || value.isEmpty)
      return 'Enter an Anniversary Date';
    else
      anniversarydateup = value;
    print("Password is : " + anniversarydateup);
    return null;
  }

  String? addressValidate(String? value) {
    if (value == null || value.isEmpty)
      return 'Enter an Address';
    else
      addressup = value;
    print("Password is : " + addressup);
    return null;
  }



  String? emailValidate(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value))
      return 'Enter a valid Email Address';
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
                    child: Text("My Update Profile",
                        style: TextStyle(color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'BebesNeue',
                            fontWeight: FontWeight.w700)),
                  ),


                ],

              ),
            ),



            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 20,bottom: 20),
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("image/profilebackgron.png"),
                  fit: BoxFit.cover,
                ),),
              child: Image.asset("image/profileimg.png", width: 100, height: 80,),
            ),

            SizedBox(height: 20,),

            Expanded(
              child: SingleChildScrollView(

                child: Form(
                  key: formkey,
                  child: Column(
                    children: [

                      SizedBox(height: 10,),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 55,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          controller: m_fisrtname,
                          decoration: InputDecoration(
                              icon: Image.asset("image/profileicon.png", width: 30, height: 30,),
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
                        height: 55,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          controller: m_lasttname,
                          decoration: InputDecoration(
                              icon: Image.asset("image/profileicon.png", width: 30, height: 30,),
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
                              icon: Image.asset("image/mobilereg.png", width: 30,
                                height: 30,),
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
                        height: 55,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          controller: m_emailid,
                          decoration: InputDecoration(
                              icon: Image.asset("image/emailicon.png", width: 25, height: 30,),
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

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 55,
                        margin: EdgeInsets.only(left: 15, right: 20),
                        child: TextFormField(
                          controller: m_dob,
                          decoration: InputDecoration(
                              icon: Image.asset("image/calendericon.png", width: 35, height: 30,),
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              labelText: "DOB",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                              validator: dobValidate,
                        ),

                      ),

                      SizedBox(height: 20,),

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 55,
                        margin: EdgeInsets.only(left: 15, right: 20),
                        child: TextFormField(
                          controller: m_anniversarydate,
                          decoration: InputDecoration(
                              icon: Image.asset("image/calendericon.png", width: 35,
                                height: 30,),
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              labelText: "Anniversary Date",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),

                          ),
                              validator: aniversaryValidate,
                        ),

                      ),

                      SizedBox(height: 20,),

                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 55,
                        margin: EdgeInsets.only(left: 10, right: 20),
                        child: TextFormField(
                          controller: m_address,
                          decoration: InputDecoration(
                              icon: Image.asset("image/addressicon.png", width: 40, height: 40,),
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              labelText: "Address",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),

                          ),
                              validator: addressValidate,
                        ),

                      ),

                      SizedBox(height: 30,),

                      ConstrainedBox(

                        constraints: BoxConstraints.tightFor(
                            height: 40, width: 180),

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


  Future<void> updateProfile() async {
    String url = TravApis.UPDATEPROFILE;
    if (m_fisrtname.text.trim().isNotEmpty && m_lasttname.text.trim().isNotEmpty && m_dob.text.trim().isNotEmpty && m_anniversarydate.text.trim().isNotEmpty
        && m_address.text.trim().isNotEmpty && m_emailid.text.trim().isNotEmpty && m_mobileNo.text.trim().isNotEmpty) {

      var res = await http.post(Uri.parse(url),

          body: ({'firstName': m_fisrtname.text.trim(),
            'lastName': m_lasttname.text.trim(),
            'birthDate': m_dob.text.trim(),
            'anniversaryDate': m_anniversarydate.text.trim(),
            'address1': m_address.text.trim(),
            'email': m_emailid.text.trim(),
            'phoneNo': m_mobileNo.text.trim()})
      );

      print("First Name is : " + m_fisrtname.text.trim());
      print("Last Name is : " + m_lasttname.text.trim());
      print("Email-Id is : " + m_dob.text.trim());
      print("Phone No is : " + m_mobileNo.text.trim());

     /* Fluttertoast.showToast(
          msg: "Profile Updated response is : " + url.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 12.0
      );

      Fluttertoast.showToast(
          msg: "Profile Updated response is : " + res.body,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 12.0
      );*/

      if (res.statusCode == 200) {

      //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {return Profile();}));

        Navigator.of(context).pop();

        Fluttertoast.showToast(
            msg: "Profile Updated Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 12.0
        );
      }

      else {
        Fluttertoast.showToast(
          msg: "Something Went Wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 12.0,
        );
      }
  }

    else {
      print("Please Fills Fields");
    }
  }

  void validate() {
    if (formkey.currentState!.validate()) {
      print("OK");
      updateProfile();
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
     /* Fluttertoast.showToast(
        msg: "Error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0,
      );*/
    }
  }



}
