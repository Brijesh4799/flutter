import 'dart:async';
import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../Utils/Apis.dart';



class DetatilItineraryVoucherwvSL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: DetatilItineraryw(),
    );
  }
}

class DetatilItineraryw extends StatefulWidget {

  @override
  State createState() => MyDetatilItineraryw();
}

class MyDetatilItineraryw extends State<DetatilItineraryw> {

  bool loadCircle = true;

  String quationID="";

  late SharedPreferences prefquotationId;

  String pdf="1";

  getMyRefId() async {
    prefquotationId = await SharedPreferences.getInstance();
    setState(() {
      quationID = prefquotationId.getString("quotationId")!;

      pdf = TravApis.BASEURLPLAIN+"Elegant/Home/"+quationID;
     // pdf = "https://travcrm.in/mice2.2_dev/PreviewFiles/crm_proposal.php?propNum=4&q_token=VGtSSmVVOUVVWGhOVkdzOQ==&id=VFZSWmVFMTNQVDA9";

    //  pdf="https://travcrm.in/travcrm-dev_1.5/Elegant/Home/VFdwRk1nPT0=";

      print("Detail Itenrary link is " +pdf);
    });
  }

  //Voucherwv({required this.pdf});

  @override
  void initState() {

    getMyRefId();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      progressIndicator: const CircularProgressIndicator(color: Color(0xff1a237e),strokeWidth: 5),
      inAsyncCall: loadCircle,
      child: Scaffold(

          appBar: AppBar(
            backgroundColor: Color(0xff263238),
            title:  Container(
              padding: EdgeInsets.only(top: 17.5, bottom: 17.5),
              color: Color(0xff263238),
              child: Row(
                children: [

                 /*  InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Image.asset(
                      "image/back.png", height: 20, width: 25,),
                  ),
                ),
*/
                  Container(
                    //  margin: EdgeInsets.only(left: 15),
                    child: Text("Detailed Itinerary",
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
  //  margin: EdgeInsets.only(top: 20),
      child: WebView(
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl: pdf,
      onPageFinished: (finished){
        setState(() {
          loadCircle=false;
        });
      }
      ),
        )
      ),
    );
  }
}
