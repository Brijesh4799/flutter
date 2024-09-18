import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Voucherwv extends StatelessWidget {

  //String pdf="https://travcrm.in/travcrm-hajj/loadcreatevoucher_client.php?module=ClientVoucher&quotationId=215&apiurl=1";
  String pdf="";

  Voucherwv({required this.pdf});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

       /* appBar: AppBar(
          backgroundColor: Color(0xff263238),
          title:  Container(
            padding: EdgeInsets.only(top: 17.5, bottom: 17.5),
            color: Color(0xff263238),
            child: Row(
              children: [

                *//* InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Image.asset(
                    "image/back.png", height: 20, width: 25,),
                ),
              ),
*//*

                Container(
                  //  margin: EdgeInsets.only(left: 15),
                  child: Text("Voucher",
                      style: TextStyle(color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'BebesNeue',
                          fontWeight: FontWeight.w700)),
                )

              ],

            ),
          ),
        ),*/

      body:Container(
        margin: EdgeInsets.only(top: 20),
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: pdf,
        ),
      )

    );
  }
}
