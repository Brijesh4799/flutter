import 'dart:async';
import 'dart:convert';


import 'package:driverapp/Models/ProfileModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Apis/apis.dart';
import '../Models/AlertUpdateModel.dart';




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

  bool loadCircle = false;

  late SharedPreferences prefuserid, prefroleId;

  String? UserId="45";
  String? roleId="3";

  String? fullname="1";
  String? mobileno="1";
  String? licence="1";
  String? expirydate="1";
  String car="";



  @override
  void initState() {
    super.initState();
    getUpdate();
    getPrefAll();
  }

  Future getPrefAll() async {
    prefuserid = await SharedPreferences.getInstance();
    prefroleId= await SharedPreferences.getInstance();

    setState(() {
      UserId = prefuserid.getString("userid")!;
      print("my Recieved OTP is : $UserId");

      roleId = prefroleId.getString("roleid")!;
      print("my Recieved Role Id is : $roleId");

    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      progressIndicator: const CircularProgressIndicator(color: Color(0xff1a237e),strokeWidth: 5),
      inAsyncCall: loadCircle,
      child: Scaffold(

          appBar: AppBar(
            backgroundColor: Colors.deepOrange,
            title: Container(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              color: Colors.deepOrange,
              child: Row(
                children: [

                  /* InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Image.asset(
                      "image/back.png", height: 20, width: 25,),
                  ),
                ),*/

                  Container(
                    //   margin: EdgeInsets.only(right: 5),
                    child: Text("Profile",
                        style: TextStyle(color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'BebesNeue',
                            fontWeight: FontWeight.w700)),
                  )

                ],

              ),
            ),
          ),

          body: FutureBuilder(
              future: getProfile(),
              builder:(context, snapshot) {

                //  snapshot.data![0];

                if(snapshot.hasData) {
                  List<ProfileData> logindata= snapshot.data as List<ProfileData>;

                  return SafeArea(

                    child: Stack(
                      children: [

                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: [

                              Container(
                                margin: EdgeInsets.only(top: 15,),
                                child: Image.asset("image/guidelogo.png", height: 50.0, width: 100),
                              ),

                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 180,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("image/guideprofileone.jpg"),
                                    fit: BoxFit.cover,

                                  ),
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
                                ),
                                margin: EdgeInsets.only(top:10,),
                                child: Text(""),
                              ),

                              Expanded(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("image/guidehomebglat.jpg"),
                                      fit: BoxFit.cover,

                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Center(
                                          child:Image.asset("image/guideprofiletwo.png", width: 400, height: 45,),
                                        ),
                                      ),

                                      SizedBox(height: 10,),

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
                                                        child: Text("Full Name : ",
                                                          style: TextStyle(color: Colors.grey,
                                                              fontSize: 13,
                                                              fontFamily: 'BebesNeue',
                                                              fontWeight: FontWeight.w700),),
                                                      ),

                                                      SizedBox(height: 5,),

                                                      Container(
                                                        margin: EdgeInsets.only(left: 10,),
                                                        alignment: Alignment.centerLeft,
                                                        child: Text(fullname!,
                                                          style: TextStyle(color: Colors.black,
                                                              fontSize: 14,
                                                              fontFamily: 'BebesNeue',
                                                              fontWeight: FontWeight.w700),),

                                                      ),

                                                      SizedBox(height: 25,),

                                                      Container(
                                                        alignment: Alignment.centerLeft,
                                                        margin: EdgeInsets.only(left: 10,),
                                                        child: Text("Mobile No",
                                                          style: TextStyle(color: Colors.grey,
                                                              fontSize: 13,
                                                              fontFamily: 'BebesNeue',
                                                              fontWeight: FontWeight.w700),),
                                                      ),

                                                      SizedBox(height: 5,),

                                                      Container(
                                                        alignment: Alignment.centerLeft,
                                                        margin: EdgeInsets.only(left: 10,),
                                                        child: Text(mobileno!,
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
                                                        child: Text("Driving License No",
                                                          style: TextStyle(color: Colors.grey,
                                                              fontSize: 13,
                                                              fontFamily: 'BebesNeue',
                                                              fontWeight: FontWeight.w700),),
                                                      ),

                                                      SizedBox(height: 5,),

                                                      Container(
                                                        alignment: Alignment.centerRight,
                                                        margin: EdgeInsets.only(right: 10,),
                                                        child: Text(licence!,
                                                          style: TextStyle(color: Colors.black,
                                                              fontSize: 14,
                                                              fontFamily: 'BebesNeue',
                                                              fontWeight: FontWeight.w700),),

                                                      ),

                                                      SizedBox(height: 25,),

                                                      Container(
                                                        margin: EdgeInsets.only(right: 10,),
                                                        alignment: Alignment.centerRight,
                                                        child: Text("DL Expiry Date",
                                                          style: TextStyle(color: Colors.grey,
                                                              fontSize: 13,
                                                              fontFamily: 'BebesNeue',
                                                              fontWeight: FontWeight.w700),),
                                                      ),

                                                      SizedBox(height: 5,),

                                                      Container(
                                                        margin: EdgeInsets.only( right: 10),
                                                        alignment: Alignment.centerRight,
                                                        child: Text(expirydate!,
                                                          style: TextStyle(color: Colors.black,
                                                              fontSize: 14,
                                                              fontFamily: 'BebesNeue',
                                                              fontWeight: FontWeight.w700),),

                                                      ),

                                                      SizedBox(height: 20,),



                                                    ],),
                                                  ),
                                                ],
                                              ),

                                              SizedBox(height: 10),

                                              Container(
                                                color: Colors.transparent,

                                                child: Row(
                                                  children: [

                                                    Expanded(
                                                      //   flex: 1,
                                                      child: Container(
                                                        margin: EdgeInsets.only(left: 95),
                                                        child: Image.asset("image/guidetour.png",height: 70, width: 70,),),),

                                                    Expanded(
                                                      //  flex: 1,
                                                        child: Container(
                                                          margin: EdgeInsets.only( right: 75),
                                                          child:  Image.asset("image/guiderating.png",height: 70, width: 70,),
                                                        ))
                                                  ],
                                                ),

                                              ),

                                              Container(
                                                color: Colors.transparent,
                                                margin: EdgeInsets.only(top: 10),

                                                child: Row(
                                                  children: [

                                                    Container(
                                                      margin: EdgeInsets.only(left: 120,),
                                                      child:Text("100",
                                                          style: TextStyle(color: Colors.red,fontSize: 14,
                                                              fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),),

                                                    Spacer(),

                                                    Container(
                                                      margin: EdgeInsets.only(right: 105,),
                                                      child: Row(
                                                        children: [

                                                          Container(
                                                            child:  Text("4.9 ",
                                                                style: TextStyle(color: Colors.orange,fontSize: 14,
                                                                    fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                                                          ),

                                                          Container(
                                                            child:  Image.asset("image/guidestar.png",height: 15, width: 15,),),
                                                        ],
                                                      ),
                                                    )

                                                  ],
                                                ),

                                              ),

                                              Container(
                                                color: Colors.transparent,
                                                margin: EdgeInsets.only(top: 10),

                                                child: Row(
                                                  children: [

                                                    Container(
                                                      margin: EdgeInsets.only(left: 85,),
                                                      child:Text("Completed Tours",
                                                          style: TextStyle(color: Colors.red,fontSize: 11.5,
                                                              fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),),

                                                   Spacer(),

                                                    Container(
                                                      margin: EdgeInsets.only(right: 95,),
                                                      child: Row(
                                                        children: [

                                                          Container(
                                                            child:  Text("Total Rating",
                                                                style: TextStyle(color: Colors.orange,fontSize: 11.5,
                                                                    fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                                                          ),
                                                        ],
                                                      ),
                                                    )

                                                  ],
                                                ),

                                              ),

                                            ],
                                          ),

                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            ],

                          ),
                        ),


                        Positioned(
                          top: 180,left: 10,

                          child: ClipRect(
                              child: Image.asset("image/driver_ass_user_icon.png", height: 90.0, width: 100)),
                        ),


                      ],)

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

          ),

      ),
    );


  }

  Future<List<ProfileData>> getProfile() async {

    String newurl = AppNetworkConstants.PROFILE + "driverId=" +UserId!+ "&roleId=" + roleId!;

    print("Profile url is : " +newurl);

    var url = Uri.parse(newurl);

    http.Response res = await http.get(url);

    print("Profile Response is : " +res.body);

    //  List datas= jsonDecode(res.body);

    var datas = jsonDecode(res.body)['profileData'] as List;

    List<ProfileData> logindata = datas.map((data) =>
        ProfileData.fromJson(data)).toList();

    fullname = logindata[0].fullName!;
    mobileno = logindata[0].mobile!;
    licence = logindata[0].license!;
    expirydate = logindata[0].expiryDate!;

    return logindata;
  }

  Future<List<AlertDetailsUpdate>> getUpdate() async {

    String newurl = AppNetworkConstants.ALERTUPDATE + "roleId=" + roleId!;

    print("Alert Update url is : "+newurl);

    var url = Uri.parse(newurl);

    http.Response res = await http.get(url);
    //  List datas= jsonDecode(res.body);

    print("Alert Update Response is : " +res.body);

    var datas = jsonDecode(res.body)['alertDetails'] as List;

    List<AlertDetailsUpdate> alertDetailsUpdate = datas.map((data) =>
        AlertDetailsUpdate.fromJson(data)).toList();

    return alertDetailsUpdate;
  }

}
