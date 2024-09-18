import 'dart:async';
import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/feedexpmodel.dart';
import '../Utils/Apis.dart';



class ExperienceSL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Experience(),
    );
  }
}

class Experience extends StatefulWidget {

  @override
  State createState() => MyExperience();
}

class MyExperience extends State<Experience> {

  late SharedPreferences prefRefid;

  String refID="";

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  var m_fisrtname = TextEditingController();

  var firstnameup = "";

  String? firstValidate(String? value) {
    if (value == null || value.isEmpty)
      return 'Enter a First Name';
    else
      firstnameup = value;
    print("Password is : " + firstnameup);
    return null;
  }

  getMyRefId() async {
    prefRefid = await SharedPreferences.getInstance();
    setState(() {
      refID = prefRefid.getString("refid")!;
    });
  }

  @override
  void initState() {
    getMyRefId();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color(0xff263238),
        title:  Container(
          padding: EdgeInsets.only(top: 17.5, bottom: 17.5),
          color: Color(0xff263238),
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
              //    margin: EdgeInsets.only(left: 15),
                child: Text("EXPERIENCE",
                    style: TextStyle(color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'BebesNeue',
                        fontWeight: FontWeight.w700)),
              )

            ],

          ),
        ),
      ),

      body:Container(

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("image/splashbg.jpeg"),
            fit: BoxFit.cover,
          ),),

     //   margin: EdgeInsets.only(bottom: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 60,right: 60,top: 30),
            child: Center(
              child: Text("How was your experience?",
                  // textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.blueAccent,
                    fontSize: 14,
                    fontFamily: 'BebesNeue',
                    fontWeight: FontWeight.w700,)),
            ),
          ),


          SizedBox(height: 50,),

             Form(
              key: formkey,

              child: Expanded(

                child: SingleChildScrollView(

                  child: Container(

                    child: Column(
                      children: [

                        SizedBox(height: 15,),

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.lightBlue,width: 2.0),
                          ),
                          width: MediaQuery.of(context).size.width,
                         // height: 40,
                          margin: EdgeInsets.only(left: 20, right: 20),
                      //    padding: EdgeInsets.only(top: 40,),
                          child: TextFormField(
                            maxLines: 12,
                            controller: m_fisrtname,
                            decoration: InputDecoration(
                            //  contentPadding: const EdgeInsets.symmetric(vertical: 100.0),
                              filled: true,
                              hintText: "Describe your experience here...",


                            ),
                            validator: firstValidate,
                          ),

                        ),



                        SizedBox(height: 20,),

                        InkWell(
                          onTap: (){
                            if (m_fisrtname.text.trim().isNotEmpty){

                             /* Fluttertoast.showToast(
                                  msg: "Submitted ",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 12.0
                              );*/

                              getExpFeed();

                              Navigator.of(context).pop();
                            }
                            else {
                              Fluttertoast.showToast(
                                  msg: "Please Fills Your Experience",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 12.0
                              );  }
                          },
                          child: Container(
                            width: 160,
                            // margin: EdgeInsets.only(left: 5,right: 10),
                            padding: EdgeInsets.only(top: 15, bottom: 15, left: 20,right: 20),
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
                                    fontWeight: FontWeight.w700,)),
                            ),
                          ),
                        ),

                        SizedBox(height: 20,),


                      ],
                    ),
                  ),
                ),
              ),
            ),

        ],),
      ),




    );
  }

  Future<List <ResultExp>> getExpFeed() async {
    String newurl = TravApis.FEEDBACKEXP + "experience="+m_fisrtname.text.trim()+"&refid="+refID;

    List<ResultExp> expdata=[];


    print("FeedBack Experince URL" +newurl);

    var res = await http.post(
        Uri.parse(newurl),
        body: ({
          'experience': m_fisrtname.text.trim(),
          'refid': refID,
        })
    );

    print("Feedback Experince Responsee is " +res.body);

    var datas = jsonDecode(res.body)['result'] as List;

    expdata = datas.map((data) => ResultExp.fromJson(data)).toList();

    String message = expdata[0].msg!;

    print("Message  is $message" );


    Fluttertoast.showToast(
      msg: "$message",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 6,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 12.0,
    );


    return expdata;

  }

}
