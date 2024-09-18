

import 'package:flutter/material.dart';
//import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../Utils/Apis.dart';
//import 'package:flutter_inappwebview/flutter_inappwebview.dart';



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

// late InAppWebViewController _controller;

  String pdf="1";
  double _progress=0;

  getMyRefId() async {
    prefquotationId = await SharedPreferences.getInstance();
    setState(() {
      quationID = prefquotationId.getString("quotationId")!;

      //pdf = "https://itsholidayscrm.com/live/PreviewFiles/crm_proposal.php?propNum=4&id=VGtSbk5BPT0=";

   //   pdf = "https://funnfunholidays.in/live/PreviewFiles/crm_proposal.php?id=VFZFOVBRPT0=";

  //    pdf= "https://inboundcrm.in/travcrm-mice_2.2/PreviewFiles/crm_proposal.php?propNum=4&q_token=&id=VFdwSmVFNW5QVDA9";

    //  pdf = TravApis.BASEURLPLAIN+"PreviewFiles/crm_proposal.php?propNum=4&q_token=&id="+quationID;
     // pdf = "https://travcrm.in/mice2.2_dev/PreviewFiles/crm_proposal.php?propNum=4&q_token=VGtSSmVVOUVVWGhOVkdzOQ==&id=VFZSWmVFMTNQVDA9";

    //  pdf="https://travcrm.in/travcrm-dev_1.5/Elegant/Home/VFdwRk1nPT0=";

      pdf = TravApis.BASEURLPLAIN+"PreviewFiles/crm_proposal.php?propNum=4&id="+quationID;

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
            backgroundColor: Colors.lightBlueAccent,
            title:  Container(
              padding: EdgeInsets.only(top: 17.5, bottom: 17.5),
              color: Colors.lightBlueAccent,
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

        body:

       /* Container(
            child: Column(children: <Widget>[
              Expanded(
                  child: InAppWebView(
                   initialUrlRequest: URLRequest(url: Uri.parse("https://funnfunholidays.in/live/PreviewFiles/crm_proposal.php?id=VFZFOVBRPT0=")),
                  //  initialHeaders: {},
                    initialOptions: InAppWebViewGroupOptions(
                        android: AndroidInAppWebViewOptions(
                            useHybridComposition: true,
                          offscreenPreRaster: true,
                         // overScrollMode: ,
                            useWideViewPort: true,
                            clearSessionCache: true,
                            textZoom: 100 ,
                          // it makes 2 times bigger
                        ),
                      crossPlatform: InAppWebViewOptions(

                      //    debuggingEnabled: true,
                          preferredContentMode: UserPreferredContentMode.DESKTOP),
                    ),
                    onWebViewCreated: (InAppWebViewController controller) {
                      _controller = controller;
                    },



                    onProgressChanged: (InAppWebViewController controller,int progress){
                     setState(() {
                  //    _progress=progress/100;
                     });
                    },
                  ))
            ])),*/

        Container(
        //  width: MediaQuery.of(context).size.width,
        //  height: 200,
  //  margin: EdgeInsets.only(top: 20),
      child: WebView(
        /*onPageStarted: (url) {
          loadCircle=true;
        },*/
          userAgent: "random",
        initialUrl: pdf,
      javascriptMode: JavascriptMode.unrestricted,
      initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,

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
