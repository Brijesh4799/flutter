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



class ReferEarnSL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: ReferEarn(),
    );
  }
}

class ReferEarn extends StatefulWidget {

  @override
  State createState() => MyReferEarn();
}

class MyReferEarn extends State<ReferEarn> {

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  var referralnameup = "";
  var relationup = "";
  var mobileNoup = "";
  var emailidup = "";
  var professionbup = "";
  var cityup = "";

  var m_referralname = TextEditingController();
  var m_relation = TextEditingController();
  var m_mobileNo = TextEditingController();
  var m_emailid = TextEditingController();
  var m_profession = TextEditingController();
  var m_city = TextEditingController();





  @override
  void initState() {
    super.initState();
  }

  String? referalnameValidate(String? value) {
    if (value == null || value.isEmpty)
      return 'Enter a Name';
    else
      referralnameup = value;
    print("Password is : " + referralnameup);
    return null;
  }

  String? relationValidate(String? value) {
    if (value == null || value.isEmpty)
      return 'Enter a Relation';
    else
      relationup = value;
    print("Password is : " + relationup);
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

  String? professionValidate(String? value) {
    if (value == null || value.isEmpty)
      return 'Enter a Profession';
    else
      professionbup = value;
    print("Password is : " + professionbup);
    return null;
  }

  String? cityValidate(String? value) {
    if (value == null || value.isEmpty)
      return 'Enter a City';
    else
      cityup = value;
    print("Password is : " + cityup);
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
                    child: Text("Refer And Earn",
                        style: TextStyle(color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'BebesNeue',
                            fontWeight: FontWeight.w700)),
                  ),


                ],

              ),
            ),

             SizedBox(height: 10,),
           
             Container(
              margin: EdgeInsets.only(left: 20,right: 20),
              padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                  border: Border.all(color: Colors.blue,width: 2.0)
              ),

              child: Center(
                child: Text("REFER A FRIEND",
                  style: TextStyle(color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'BebesNeue',
                      fontWeight: FontWeight.w700),),
              ),

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
                        height: 50,
                        margin: EdgeInsets.only(left: 20, right: 20),

                        child: TextFormField(
                          controller: m_referralname,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Referral Name",
                               enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                 borderSide: BorderSide(
                                   color: Colors.blue,
                                   width: 2.0,
                                 )
                            ),

                          ),
                              validator: referalnameValidate,
                        ),

                      ),

                      SizedBox(height: 10,),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        margin: EdgeInsets.only(left: 20, right: 20),

                        child: TextFormField(
                          controller: m_relation,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Relation",
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
                                )
                            ),

                          ),
                          validator: relationValidate,
                        ),

                      ),

                      SizedBox(height: 10,),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 65,
                        margin: EdgeInsets.only(left: 20, right: 20),

                        child: TextFormField(
                          controller: m_mobileNo,
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Mobile No",
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
                                )
                            ),

                          ),
                          validator: mobileValidate,
                        ),

                      ),

                      SizedBox(height: 10,),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        margin: EdgeInsets.only(left: 20, right: 20),

                        child: TextFormField(
                          controller: m_emailid,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Email-id",
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
                                )
                            ),

                          ),
                          validator: emailValidate,
                        ),

                      ),

                      SizedBox(height: 10,),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        margin: EdgeInsets.only(left: 20, right: 20),

                        child: TextFormField(
                          controller: m_profession,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Profession",
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
                                )
                            ),

                          ),
                          validator: professionValidate,
                        ),

                      ),

                      SizedBox(height: 10,),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        margin: EdgeInsets.only(left: 20, right: 20),

                        child: TextFormField(
                          controller: m_city,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "City",
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
                                )
                            ),

                          ),
                          validator: cityValidate,
                        ),

                      ),

                      SizedBox(height: 20,),

                      InkWell(
                          onTap: () {
                            validate();
                          },
                          child: Container(
                            //   height:,
                            width: 140,
                            padding: EdgeInsets.only(top: 15, bottom: 15, left: 10,right: 10),
                            decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(5),
                              //   border: Border.all(color: Colors.lightBlue,width: 1.0)
                            ),
                            child: Center(
                              child: Text("Submit",
                                style: TextStyle(color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'BebesNeue',
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          )
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


  Future<void> getRefer() async {
    String url = TravApis.REFER;
    if (m_referralname.text.trim().isNotEmpty && m_relation.text.trim().isNotEmpty && m_profession.text.trim().isNotEmpty && m_city.text.trim().isNotEmpty
        && m_emailid.text.trim().isNotEmpty && m_mobileNo.text.trim().isNotEmpty) {

      var res = await http.post(Uri.parse(url),

          body: ({'referralName': m_referralname.text.trim(),
            'city': m_city.text.trim(),
            'relation': m_relation.text.trim(),
            'profession': m_profession.text.trim(),
            'email': m_emailid.text.trim(),
            'phoneNo': m_mobileNo.text.trim()})
      );

      print("Referal Name is : " + m_referralname.text.trim());
      print("Relation is : " + m_relation.text.trim());
      print("Email-Id is : " + m_emailid.text.trim());
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
            msg: "success",
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
      getRefer();
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
