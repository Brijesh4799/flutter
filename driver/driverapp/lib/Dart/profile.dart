import 'dart:async';
import 'dart:convert';


import 'package:driverapp/Models/ProfileModel.dart';
import 'package:flutter/material.dart';
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

  String? UserId="1";
  String? roleId="1";

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
            backgroundColor: Color(0xff1a237e),
            title: Container(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              color: Color(0xff1a237e),
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

                              /* Container(
                      // child: Image.asset("image/colombia1.jpg",
                      child: Image.network(ServiceImage!,
                        height: 200, width: MediaQuery.of(context).size.width,fit:BoxFit.fill,),
                    ),*/

                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                    border: Border.all(
                                        color: Colors.blue,
                                        width: 2.0
                                    )
                                ),
                                margin: EdgeInsets.only(left: 15,top: 40),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child:Image.asset("image/profilemenulat.jpg",height: 80, width: 80,)),
                              ),

                            ],

                          ),
                        ),


                        Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 100),
                            height: 250,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: [

                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xffffffff),
                                    border: Border.all(
                                      color: Colors.blue, //                   <--- border color
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  height: 165,
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(left: 15, right: 15,),

                                  child: Column(
                                    children: [

                                      SizedBox(height: 20,),

                                      Row(children: [

                                        Expanded(
                                          //   flex: 1,
                                          child: Container(
                                            margin: EdgeInsets.only(left: 25,),
                                            child:Text("Full Name :",
                                                style: TextStyle(color: Colors.black,fontSize:15,
                                                    fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),),),

                                        Expanded(
                                          //   flex: 1,
                                          child: Container(
                                            margin: EdgeInsets.only(right: 20),
                                            child:Text(fullname!,
                                                style: TextStyle(color: Colors.black,fontSize: 15,
                                                    fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),),),

                                      ],),

                                      SizedBox(height: 15,),

                                      Row(children: [

                                        Expanded(
                                          //   flex: 1,
                                          child: Container(
                                            margin: EdgeInsets.only(left: 25,),
                                            child:Text("Mobile No :",
                                                style: TextStyle(color: Colors.black,fontSize:15,
                                                    fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),),),

                                        Expanded(
                                          //   flex: 1,
                                          child: Container(
                                            margin: EdgeInsets.only(right: 20),
                                            child:Text(mobileno!,
                                                style: TextStyle(color: Colors.black,fontSize: 15,
                                                    fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),),),

                                      ],),

                                      SizedBox(height: 15,),

                                      Row(children: [

                                        Expanded(
                                          //   flex: 1,
                                          child: Container(
                                            margin: EdgeInsets.only(left: 25,),
                                            child:Text("Driving License No:",
                                                style: TextStyle(color: Colors.black,fontSize:15,
                                                    fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),),),

                                        Expanded(
                                          //   flex: 1,
                                          child: Container(
                                            margin: EdgeInsets.only(right: 20),
                                            child:Text(licence!,
                                                style: TextStyle(color: Colors.black,fontSize: 15,
                                                    fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),),),

                                      ],),

                                      SizedBox(height: 15,),

                                      Row(children: [

                                        Expanded(
                                          //   flex: 1,
                                          child: Container(
                                            margin: EdgeInsets.only(left: 25,),
                                            child:Text("LIC Expiry Date :",
                                                style: TextStyle(color: Colors.black,fontSize:15,
                                                    fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),),),

                                        Expanded(
                                          //   flex: 1,
                                          child: Container(
                                            margin: EdgeInsets.only(right: 20),
                                            child:Text(expirydate!,
                                                style: TextStyle(color: Colors.black,fontSize: 15,
                                                    fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),),),

                                      ],),

                                      SizedBox(height: 15,),

                                     /* Row(children: [

                                        Expanded(

                                          child: Container(
                                            margin: EdgeInsets.only(left: 35,),
                                            child:Text("Car :",
                                                style: TextStyle(color: Colors.black,fontSize:15,
                                                    fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),),),

                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(right: 25),
                                            child:Text("",
                                                style: TextStyle(color: Colors.black,fontSize: 15,
                                                    fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),),),

                                      ],),*/

                                    ],

                                  ),
                                ),


                              ],

                            ),
                          ),
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

   /* setState(() {
      loadCircle = true;
    });*/

    String newurl = AppNetworkConstants.PROFILE + "driverId=" +UserId!+ "&roleId=" + roleId!;

    var url = Uri.parse(newurl);

    /* Fluttertoast.showToast(
        msg: "Profile url is : " + url.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0
    );*/

    http.Response res = await http.get(url);
    //  List datas= jsonDecode(res.body);

    var datas = jsonDecode(res.body)['profileData'] as List;

    /*setState(() {
      loadCircle = false;
    });*/

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
