import 'dart:async';
import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/profilemodel.dart';
import '../Utils/Apis.dart';
import 'login.dart';
import 'myupdateprofile.dart';



class ProfileSL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Profile(),
    );
  }
}

class Profile extends StatefulWidget {

  @override
  State createState() => MyProfile();
}

class MyProfile extends State<Profile> {

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
                            child: Text("My Profile",
                                style: TextStyle(color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'BebesNeue',
                                    fontWeight: FontWeight.w700)),
                          ),


                        ],

                      ),
                    ),

                    SizedBox(height: 40,),

                    Container(
                      width: 100,
                      height: 80,
                      child: Image.asset("image/profileimg.png"),
                    ),

                    SizedBox(height: 30,),

                    Expanded(
                      child: SingleChildScrollView(

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
                                      child: Text("First Name : ",
                                        style: TextStyle(color: Colors.grey,
                                            fontSize: 13,
                                            fontFamily: 'BebesNeue',
                                            fontWeight: FontWeight.w700),),
                                    ),

                                    SizedBox(height: 5,),

                                    Container(
                                      margin: EdgeInsets.only(left: 10,),
                                      alignment: Alignment.centerLeft,
                                      child: Text(firstname!,
                                        style: TextStyle(color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'BebesNeue',
                                            fontWeight: FontWeight.w700),),

                                    ),

                                    SizedBox(height: 20,),

                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 10,),
                                      child: Text("Last Name",
                                        style: TextStyle(color: Colors.grey,
                                            fontSize: 13,
                                            fontFamily: 'BebesNeue',
                                            fontWeight: FontWeight.w700),),
                                    ),

                                    SizedBox(height: 5,),

                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 10,),
                                      child: Text(lastname!,
                                        style: TextStyle(color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'BebesNeue',
                                            fontWeight: FontWeight.w700),),

                                    ),

                                    SizedBox(height: 20,),

                                    Container(
                                      margin: EdgeInsets.only(left: 10,),
                                      alignment: Alignment.centerLeft,
                                      child: Text("Mobile No",
                                        style: TextStyle(color: Colors.grey,
                                            fontSize: 13,
                                            fontFamily: 'BebesNeue',
                                            fontWeight: FontWeight.w700),),
                                    ),

                                    SizedBox(height: 5,),

                                    Container(

                                      margin: EdgeInsets.only(left: 10,),
                                      alignment: Alignment.centerLeft,
                                      child: Text(mobileNo!,
                                        style: TextStyle(color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'BebesNeue',
                                            fontWeight: FontWeight.w700),),

                                    ),

                                    SizedBox(height: 20,),

                                    Container(
                                      margin: EdgeInsets.only(left: 10,),
                                      alignment: Alignment.centerLeft,
                                      child: Text("DOB",
                                        style: TextStyle(color: Colors.grey,
                                            fontSize: 13,
                                            fontFamily: 'BebesNeue',
                                            fontWeight: FontWeight.w700),),
                                    ),

                                    SizedBox(height: 5,),

                                    Container(
                                      margin: EdgeInsets.only(left: 10,),
                                      alignment: Alignment.centerLeft,
                                      child: Text(dob!,
                                        style: TextStyle(color: Colors.black,
                                            fontSize: 14,
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
                                      child: Text("Email-Id",
                                        style: TextStyle(color: Colors.grey,
                                            fontSize: 13,
                                            fontFamily: 'BebesNeue',
                                            fontWeight: FontWeight.w700),),
                                    ),

                                    SizedBox(height: 5,),

                                    Container(
                                      alignment: Alignment.centerRight,
                                      margin: EdgeInsets.only(right: 10,),
                                      child: Text(emailid!,
                                        style: TextStyle(color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'BebesNeue',
                                            fontWeight: FontWeight.w700),),

                                    ),

                                    SizedBox(height: 20,),

                                    Container(
                                      margin: EdgeInsets.only(right: 10,),
                                      alignment: Alignment.centerRight,
                                      child: Text("Anniversary Date",
                                        style: TextStyle(color: Colors.grey,
                                            fontSize: 13,
                                            fontFamily: 'BebesNeue',
                                            fontWeight: FontWeight.w700),),
                                    ),

                                    SizedBox(height: 5,),

                                    Container(
                                      margin: EdgeInsets.only( right: 10),
                                      alignment: Alignment.centerRight,
                                      child: Text(anniversarydate!,
                                        style: TextStyle(color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'BebesNeue',
                                            fontWeight: FontWeight.w700),),

                                    ),

                                    SizedBox(height: 20,),


                                    Container(
                                      margin: EdgeInsets.only( right: 10),
                                      alignment: Alignment.centerRight,
                                      child: Text("Address",
                                        style: TextStyle(color: Colors.grey,
                                            fontSize: 13,
                                            fontFamily: 'BebesNeue',
                                            fontWeight: FontWeight.w700),),
                                    ),

                                    SizedBox(height: 5,),

                                    Container(
                                      margin: EdgeInsets.only( right: 10),
                                      alignment: Alignment.centerRight,
                                      child: Text(address!,
                                        style: TextStyle(color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'BebesNeue',
                                            fontWeight: FontWeight.w700),),

                                    ),


                                  ],),
                                ),
                              ],
                            ),

                            SizedBox(height: 10),

                            Container(height: 3,
                                color: Colors.lightBlue,
                                margin: EdgeInsets.only(left: 10,right: 10),
                                width:MediaQuery.of(context).size.width),

                          ],
                        ),

                      ),
                    ),

                  ],
                ),

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

    List<ResultsProfile> logindata = datas.map((data) =>
        ResultsProfile.fromJson(data)).toList();

    firstname = logindata[0].firstName!;
    lastname = logindata[0].lastName!;
    mobileNo = logindata[0].mobile!;
    emailid = logindata[0].email!;
    dob = logindata[0].dob!;
    anniversarydate = logindata[0].anniversaryDate!;
    address = logindata[0].address!;
    accomodationpreference = logindata[0].accomodationpreference!;
    holidaypreference = logindata[0].holidaypreference!;
    mealprefernce = logindata[0].mealPreference!;
    specialassistance = logindata[0].specialassistance!;

    prefprofile = await SharedPreferences.getInstance();
    prefprofile.setString("fname", firstname!);
    prefprofile.setString("lname", lastname!);

    print("first name is : $firstname");
    print("last name : $lastname");

    return logindata;
  }

}
