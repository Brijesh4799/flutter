import 'dart:async';
import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
//import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_to_text.dart';
import 'package:translator/translator.dart';
import '../Providers/pickerstranslator.dart';

class CurSTT extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CurST(),
    );
  }
}

class CurST extends StatefulWidget {
  @override
  State createState() => MyCurST();
}

class MyCurST extends State<CurST> {


  bool loadCircle = false;

  String pair1="INR";
  String pair2="USD";
  String amount="";
  String msg="You Can Convert only max 3 time in Per Minutes";

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  var amountup = "";
  var m_amount = TextEditingController();

  String? nameValidate(String? value) {
    if (value == null || value.isEmpty || value==0)
      return 'Please Check Currency and Try Again';
    else
      amountup = value;
    print("Name is : " + amountup);
    return null;
  }

  void validate() {
    if (formkey.currentState!.validate()) {

      getCurrency();


      print("OK");

      /* Fluttertoast.showToast(
          msg: "Ok",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 12.0
      );*/

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

  var sendfull={"INDIAN RUPEE","US DOLLAR","BRITISH POUND","JAPANESE YEN","EURO","RUSSIAN RUBLE","POLISH ZLOTY","TURKISH LIRA",
    "NORWEGIAN KRONE","AUSTRALIAN DOLLAR","NEW ZEALAND DOLLAR","CANADIAN DOLLAR","SWISS FRANC","HONG KONG DOLLAR",
    "SINGAPORE DOLLAR","SWEDISH KRONA","MEXICON PESO","DANISH KRONE", "CHINESE YUAN","SOUTH AFRICAN RAND"};

  var recfull={"US DOLLAR","INDIAN RUPEE","BRITISH POUND","JAPANESE YEN","EURO","RUSSIAN RUBLE","POLISH ZLOTY","TURKISH LIRA",
    "NORWEGIAN KRONE","AUSTRALIAN DOLLAR","NEW ZEALAND DOLLAR","CANADIAN DOLLAR","SWISS FRANC","HONG KONG DOLLAR",
    "SINGAPORE DOLLAR","SWEDISH KRONA","MEXICON PESO","DANISH KRONE", "CHINESE YUAN","SOUTH AFRICAN RAND"};

  String sendvalue="INDIAN RUPEE";
  String recvalue="US DOLLAR";






  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loadCircle,
      progressIndicator: const CircularProgressIndicator(color: Colors.purple,strokeWidth: 5),

      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [



            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("image/currencybg.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Text(""),
                ),

            Padding(
              padding:
                  EdgeInsets.only(top: 51, left: 20, right: 20, bottom: 31),

              child: Container(
             //   margin: EdgeInsets.only(top: ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    )),
                child: Column(
                  children: [

                    Expanded(
                      child:
                      SingleChildScrollView(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.0),
                                topRight: Radius.circular(5.0),
                                bottomLeft: Radius.circular(5.0),
                                bottomRight: Radius.circular(5.0),
                              )),
                          child: Form(
                            key: formkey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),

                                Container(
                                  alignment: Alignment.center,
                                  //  padding: EdgeInsets.only(top: 20,bottom: 20,left: 20,right: 20),
                                  width: 250.0,
                                  height: 80.0,
                                  child: DropdownButtonHideUnderline(
                                    child: Theme(
                                      data: Theme.of(context)
                                          .copyWith(canvasColor: Colors.white),
                                      child:  DropdownButton(
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.blue,
                                        ),
                                        focusColor: Colors.white,
                                        style: TextStyle(
                                            fontFamily: 'BebesNeue',
                                            fontWeight: FontWeight.w700,
                                            color: Colors.blue,
                                            fontSize: 16),
                                        items: sendfull
                                            .map((String itemnames) {
                                          return DropdownMenuItem<String>(
                                              value: itemnames,
                                              child: Text(itemnames, textAlign: TextAlign.center,style: TextStyle(color: Colors.blue,fontSize: 18,
                                                  fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),));
                                        }).toList(),
                                        onChanged: (String? value) {
                                          //  PickersTranslatorProvider.languageName=value!;

                                          //  provider.selectLanguage();

                                          sendvalue = value!;

                                          switch (sendvalue) {

                                            case "INDIAN RUPEE":
                                              setState(() {
                                                pair1="INR";
                                                print("send value is "+pair1);
                                              });
                                              break;

                                            case "US DOLLAR":
                                              setState(() {
                                                pair1="USD";
                                                print("send value is "+pair1);
                                              });
                                              break;

                                            case "BRITISH POUND":
                                              setState(() {
                                                pair1="GBP";
                                                print("send value is "+pair1);
                                              });
                                              break;

                                            case "JAPANESE YEN":
                                              setState(() {
                                                pair1="JPY";
                                                print("send value is "+pair1);
                                              });
                                              break;

                                            case "EURO":
                                              setState(() {
                                                pair1="EUR";
                                                print("send value is "+pair1);
                                              });
                                              break;

                                            case "RUSSIAN RUBLE":
                                              setState(() {
                                                pair1="RUB";
                                                print("send value is "+pair1);
                                              });
                                              break;

                                            case "POLISH ZLOTY":
                                              setState(() {
                                                pair1="PLN";
                                                print(pair1);
                                              });
                                              break;

                                            case "TURKISH LIRA":
                                              setState(() {
                                                pair1="TRY";
                                                print(pair1);
                                              });
                                              break;

                                            case "NORWEGIAN KRONE":
                                              setState(() {
                                                pair1="NOK";
                                                print(pair1);
                                              });
                                              break;

                                            case "AUSTRALIAN DOLLAR":
                                              setState(() {
                                                pair1="AUD";
                                                print(pair1);
                                              });
                                              break;

                                            case "NEW ZEALAND DOLLAR":
                                              setState(() {
                                                pair1="NZD";
                                                print(pair1);
                                              });
                                              break;

                                            case "CANADIAN DOLLAR":
                                              setState(() {
                                                pair1="CAD";
                                                print(pair1);
                                              });
                                              break;

                                            case "SWISS FRANC":
                                              setState(() {
                                                pair1="CHF";
                                                print(pair1);
                                              });
                                              break;

                                            case "HONG KONG DOLLAR":
                                              setState(() {
                                                pair1="HKD";
                                                print(pair1);
                                              });
                                              break;

                                            case "SINGAPORE DOLLAR":
                                              setState(() {
                                                pair1="SGD";
                                                print(pair1);
                                              });
                                              break;

                                            case "SWEDISH KRONA":
                                              setState(() {
                                                pair1="SEK";
                                                print(pair1);
                                              });
                                              break;

                                            case "MEXICON PESO":
                                              setState(() {
                                                pair1="MXN";
                                                print(pair1);
                                              });
                                              break;

                                            case "DANISH KRONE":
                                              setState(() {
                                                pair1="DKK";
                                                print(pair1);
                                              });
                                              break;

                                            case "CHINESE YUAN":
                                              setState(() {
                                                pair1="CNH";
                                                print(pair1);
                                              });
                                              break;

                                            case "SOUTH AFRICAN RAND":
                                              setState(() {
                                                pair1="ZAR";
                                                print(pair1);
                                              });
                                              break;
                                          }
                                        },
                                        value: sendvalue,
                                      ),
                                    ),
                                  ),

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                  ),
                                ),

                                SizedBox(
                                  height: 10,
                                ),

                                Container(width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(left: 70, right: 70),
                                  child: TextFormField(
                                    maxLines: 1,
                                    style: TextStyle(color: Colors.blue,fontSize: 18,
                                        fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                                    textAlign: TextAlign.center,
                                    controller: m_amount,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: "Enter Amount",
                                      /*border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(20)
                                                      ),*/

                                    ),
                                    validator: nameValidate,
                                  ),

                                ),

                                SizedBox(height: 20,),

                                Container(
                                  margin: EdgeInsets.only(left: 10, right: 10,bottom: 40),
                                  child: Text(pair1,
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 20,
                                          fontFamily: 'BebesNeue',
                                          fontWeight: FontWeight.w700)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),


                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5.0),
                                bottomRight: Radius.circular(5.0),
                              )),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2,
                          child: Column(
                            children: [
                              SizedBox(height: 50,),


                              Container(
                                margin: EdgeInsets.only(left: 10, right: 10,top: 20),
                                child: Text(pair2,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'BebesNeue',
                                        fontWeight: FontWeight.w700)),
                              ),

                              Container(
                                margin: EdgeInsets.only(left: 10, right: 10,top: 40),
                                child: Text(amount,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: 'BebesNeue',
                                        fontWeight: FontWeight.w700)),
                              ),

                              SizedBox(height: 40,),

                              Container(
                                alignment: Alignment.center,
                                //  padding: EdgeInsets.only(top: 20,bottom: 20,left: 20,right: 20),
                                width: 250.0,
                                height: 80.0,
                                child: DropdownButtonHideUnderline(
                                  child: Theme(
                                    data: Theme.of(context)
                                        .copyWith(canvasColor: Colors.blue),
                                    child:  DropdownButton(
                                      icon: Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.white,
                                      ),
                                      focusColor: Colors.blue,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16),
                                      items: recfull
                                          .map((String itemnames) {
                                        return DropdownMenuItem<String>(
                                            value: itemnames,
                                            child: Text(itemnames,style: TextStyle(fontFamily: 'BebesNeue',
                                                fontWeight: FontWeight.w700),
                                                textAlign:
                                                TextAlign.center));
                                      }).toList(),
                                      onChanged: (String? value) {
                                        //  PickersTranslatorProvider.languageName=value!;

                                        //  provider.selectLanguage();

                                        recvalue = value!;

                                        switch (recvalue) {

                                          case "US DOLLAR":
                                            setState(() {
                                              pair2="USD";
                                              print("rec value is "+pair2);
                                            });
                                            break;

                                          case "INDIAN RUPEE":
                                            setState(() {
                                              pair2="INR";
                                              print("rec value is "+pair2);
                                            });
                                            break;

                                          case "BRITISH POUND":
                                            setState(() {
                                              pair2="GBP";
                                              print("rec value is "+pair2);
                                            });
                                            break;

                                          case "JAPANESE YEN":
                                            setState(() {
                                              pair2="JPY";
                                              print("rec value is "+pair2);
                                            });
                                            break;

                                          case "EURO":
                                            setState(() {
                                              pair2="EUR";
                                              print(pair2);
                                            });
                                            break;

                                          case "RUSSIAN RUBLE":
                                            setState(() {
                                              pair2="RUB";
                                              print(pair2);
                                            });
                                            break;

                                          case "POLISH ZLOTY":
                                            setState(() {
                                              pair2="PLN";
                                              print(pair2);
                                            });
                                            break;

                                          case "TURKISH LIRA":
                                            setState(() {
                                              pair2="TRY";
                                              print(pair2);
                                            });
                                            break;

                                          case "NORWEGIAN KRONE":
                                            setState(() {
                                              pair2="NOK";
                                              print(pair2);
                                            });
                                            break;

                                          case "AUSTRALIAN DOLLAR":
                                            setState(() {
                                              pair2="AUD";
                                              print(pair2);
                                            });
                                            break;

                                          case "NEW ZEALAND DOLLAR":
                                            setState(() {
                                              pair2="NZD";
                                              print(pair2);
                                            });
                                            break;

                                          case "CANADIAN DOLLAR":
                                            setState(() {
                                              pair2="CAD";
                                              print(pair2);
                                            });
                                            break;

                                          case "SWISS FRANC":
                                            setState(() {
                                              pair2="CHF";
                                              print(pair2);
                                            });
                                            break;

                                          case "HONG KONG DOLLAR":
                                            setState(() {
                                              pair2="HKD";
                                              print(pair2);
                                            });
                                            break;

                                          case "SINGAPORE DOLLAR":
                                            setState(() {
                                              pair2="SGD";
                                              print(pair2);
                                            });
                                            break;

                                          case "SWEDISH KRONA":
                                            setState(() {
                                              pair2="SEK";
                                              print(pair2);
                                            });
                                            break;

                                          case "MEXICON PESO":
                                            setState(() {
                                              pair2="MXN";
                                              print(pair2);
                                            });
                                            break;

                                          case "DANISH KRONE":
                                            setState(() {
                                              pair2="DKK";
                                              print(pair2);
                                            });
                                            break;

                                          case "CHINESE YUAN":
                                            setState(() {
                                              pair2="CNH";
                                              print(pair2);
                                            });
                                            break;

                                          case "SOUTH AFRICAN RAND":
                                            setState(() {
                                              pair2="ZAR";
                                              print(pair2);
                                            });
                                            break;
                                        }
                                      },
                                      value: recvalue,
                                    ),
                                  ),
                                ),

                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),

            Center(
              child: Container(
                padding: EdgeInsets.only(top: 30),
                child: InkWell(
                  onTap: () {
                    setState(() {

                      if(m_amount.text.trim()==0){
                        Fluttertoast.showToast(
                            msg: "Please Check Currency And Try Again...",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 12.0
                        );
                      }
                      else{
                        validate();
                      }
                    });
                  },
                  child: Container(
                    height: 80,
                    width: 80,
                    child: Image.asset(
                      "image/convertimg.png",
                      height: 80,
                      width: 80,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> getCurrency() async {

    loadCircle = true;

    String newurl ="https://fcsapi.com/api-v2/forex/converter?pair1="+pair1+"&pair2="+pair2+"&amount="+m_amount.text.trim()+"&access_key=K3ZjdODVU3M8KGA5VSRLx9T7UOx32uCNwW97NAArftPPgAcLIy";


    var url = Uri.parse(newurl);

    /* Fluttertoast.showToast(
        msg: "Weather URL is : " + url.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0
    );*/
    http.Response res = await http.get(url);


    /* Fluttertoast.showToast(
        msg: "currenccy response is : " + res.body,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0
    );*/

    setState(() {
      if(res.statusCode==200){
        loadCircle = false;
        print("OK");
        String data = res.body;
        amount= jsonDecode(data)['response']['total'];

        print("Total Values is : $amount" );

        // amount= total.toString();

      }

      else if(res.statusCode==213){
        loadCircle = false;
        print("OK");
        String data = res.body;
        msg= jsonDecode(data)['msg'];

        print("Message is : $msg" );

        Fluttertoast.showToast(
            msg: msg,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 4,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 12.0
        );

        // amount= total.toString();

      }

      else if (res.statusCode == 500) {
        loadCircle = false;
        Fluttertoast.showToast(
            msg: "Server Not Responding",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 4,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 12.0
        );
      }

      else{
        loadCircle = false;
        print("error");

        Fluttertoast.showToast(
            msg: msg,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 4,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 12.0
        );
      }

    });
    //  List datas= jsonDecode(res.body);

    //  var datas = jsonDecode(res.body)['results'] as List;

    //  List<ResultsFinance> financedata = datas.map((data) =>
    //      ResultsFinance.fromJson(data)).toList();

    /*daynumber = daysdata[0].dayNumber!;
    date = daysdata[0].date!;


    print("Day Number is : $daynumber");
    print("Date is : $date");
*/
    //  return financedata;
  }

}
