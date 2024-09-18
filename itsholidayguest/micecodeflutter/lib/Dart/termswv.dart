import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';



class Termswv extends StatelessWidget {
  //String pdf="https://travcrm.in/travcrm-hajj/loadcreatevoucher_client.php?module=ClientVoucher&quotationId=215&apiurl=1";

  late WebViewController _webViewController;
  String filepath='files/terms.html';

//  Voucherwv({required this.pdf});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:Column(children: [
        SizedBox(height: 30,),

         Container(
              width: MediaQuery.of(context).size.width,
              height: 20,
              margin: EdgeInsets.only(top: 20),
              child: Center(
                child: Text("Terms and Conditions", style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'BebesNeue',
                      fontWeight: FontWeight.w700),),
              ),
            ),

        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(top: 20,left: 15,right: 15,bottom: 20),
            child: WebView(
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController){
                _webViewController=webViewController;
                loadFromFiles();
              },
              initialUrl: '',
            ),
          ),
        ),
      ],


      ),

    );
  }

  loadFromFiles() async{
    String myurl= await rootBundle.loadString(filepath);
    _webViewController.loadUrl(Uri.dataFromString(myurl,mimeType: 'text/html',encoding: Encoding.getByName('utf-8')).toString());
  }
}