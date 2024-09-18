
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salescrm/Models/alertduedetailmodel.dart';
import 'package:salescrm/Models/alertmeetmodel.dart';
import 'package:salescrm/Models/alerttaskdetailmodel.dart';
import 'package:salescrm/Models/itemodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../Apis/apis.dart';
import '../Models/alertmeetdetailmodel.dart';
import '../Models/callmodel.dart';
import 'data.dart';
import 'expensedata.dart';
import 'items.dart';


class AlertTaskDetailST extends StatefulWidget {
  // ItemDetail({required this.itemlist});

  @override
  State createState() => new MyAlertTaskDetailST();
}

class MyAlertTaskDetailST extends State<AlertTaskDetailST> {

  List<ResultAlertTaskDetail>? alerttaskdetailmodels;

  String callnumber="";
  String whatsappnumber="";

  String time="";
  String contactPerson="";
  String Date="";
  String company="";
  String product="";
  String subject="";
  String id="";
  bool isNumber=true;

  late SharedPreferences prefid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefName();
  }

  Future getPrefName() async {
    prefid = await SharedPreferences.getInstance();

    setState(() {

      id = prefid.getString("id")!;
      print("my Recieved ID  is : $id");
    });
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(

          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Container(
              padding: EdgeInsets.only(top: 12.5, bottom: 12.5),
              color: Colors.blue,
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
                    child: Text("Alert Task Details",
                        style: TextStyle(color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'BebesNeue',
                            fontWeight: FontWeight.w700)),
                  )

                ],

              ),
            ),
          ),

          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("image/callbg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /* Container(
              //  height: 150,
                margin: EdgeInsets.only(top: 0, bottom: 0),
                color: Colors.white,
                child: Container(
                  margin: EdgeInsets.only(top: 0, bottom: 0),
                  padding: EdgeInsets.only(bottom: 20, top: 0),
                  child: Row(
                    children: [

                      InkWell(
                        onTap:(){
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 5, left: 15),
                          child: Image.asset(
                            "image/back.png", height: 20, width: 25,),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 5, left: 15, right: 20),
                        child: Text("Alert Details",
                          style: TextStyle(color: Colors.blue,
                              fontSize: 20,
                              fontFamily: 'BebesNeue',
                              fontWeight: FontWeight.w700),),
                      ),

                      Spacer(),

                      Container(
                        margin: EdgeInsets.only(top: 12, left: 0, right: 0),
                        child: Text("",
                          style: TextStyle(color: Colors.blue,
                              fontSize: 22,
                              fontFamily: 'BebesNeue',
                              fontWeight: FontWeight.w700),),
                      ),


                      Container(
                        margin: EdgeInsets.only(top: 5, right: 12.5),
                        child: Image.asset(
                          "image/bell.png", height: 35, width: 40,),
                      )
                    ],

                  ),
                ),
              ),*/

                Container(
                  color: Colors.white,
                  child: Column(children: [

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: 35,
                      padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
                      margin: EdgeInsets.only(top: 20, left: 0, right: 0),
                      child: Row(children: [

                      ],
                      ),

                    ),
                  ],

                  ),
                ),


                Container(
                  margin: EdgeInsets.only(
                      left: 20, top: 50),

                  child: Text("TASK ALERTS",
                    style: TextStyle(color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'BebesNeue',
                        fontWeight: FontWeight.w700),),
                ),


                // Call Api

                FutureBuilder(
                    future: getAlertsTaskDetail(),
                    builder:(context,  snapshot) {

                      if(snapshot.hasData) {

                        alerttaskdetailmodels = snapshot.data as List<ResultAlertTaskDetail>?;

                        time = alerttaskdetailmodels![0].time.toString();
                        contactPerson = alerttaskdetailmodels![0].contactPerson.toString();
                        Date = alerttaskdetailmodels![0].date.toString();
                        company = alerttaskdetailmodels![0].company.toString();
                        product = alerttaskdetailmodels![0].product.toString();
                        subject = alerttaskdetailmodels![0].subject.toString();
                        callnumber = alerttaskdetailmodels![0].number.toString();
                        whatsappnumber = alerttaskdetailmodels![0].number.toString();

                        print(time);
                        print(contactPerson);

                        if(callnumber==""){
                          isNumber=false;
                        }else{
                          isNumber=true;
                        }


                        return getDetailWidget();
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




              ],
            ),
          )
      ),
    );
  }


  Widget getDetailWidget(){
    return  Expanded(

      child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
              left: 10, right: 10, top:15, bottom: 10),
          //height: 275,

          padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 15),


          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),

              gradient: LinearGradient(

                colors: [
                  Colors.white.withOpacity(0.3),
                  Colors.white.withOpacity(0.3),
                ],
                //  stops: [0.0,1.0]
              )

          ),

          child: Column(
            children: [

              Container(
                margin: EdgeInsets.only(top: 25,bottom: 7.5),
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),

                  //  color: Colors.deepOrange,


                ),
                child: Column(children: [

                  Container(
                    margin: EdgeInsets.only(left: 10, top: 20),
                    child: Row(children: [

                      Container(
                        child: Text("Name : ",
                            style: TextStyle(color: Colors.black54,
                                fontSize: 12,
                                fontFamily: 'BebesNeue',
                                fontWeight: FontWeight.w700),maxLines: 1),
                      ),

                      Container(
                        child: Text(contactPerson,
                          style: TextStyle(color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'BebesNeue',
                              fontWeight: FontWeight.w700),),
                      ),
                    ],

                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 10, top: 5),
                    child: Row(children: [

                      Container(
                        child: Text("Company Name : ",
                            style: TextStyle(color: Colors.black54,
                                fontSize: 12,
                                fontFamily: 'BebesNeue',
                                fontWeight: FontWeight.w700),maxLines: 1),
                      ),

                      Container(
                        child: Text(company,
                          style: TextStyle(color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'BebesNeue',
                              fontWeight: FontWeight.w700),),
                      ),
                    ],

                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 10, top: 15),
                    child: Row(children: [

                      Container(
                        child: Text("Subject : ",
                            style: TextStyle(color: Colors.black54,
                                fontSize: 12,
                                fontFamily: 'BebesNeue',
                                fontWeight: FontWeight.w700),maxLines: 1),
                      ),

                      Container(
                        child: Text(subject,
                          style: TextStyle(color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'BebesNeue',
                              fontWeight: FontWeight.w700),),
                      ),
                    ],

                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 10, top: 5),
                    child: Row(children: [

                      Container(
                        child: Text("Product : ",
                            style: TextStyle(color: Colors.black54,
                                fontSize: 12,
                                fontFamily: 'BebesNeue',
                                fontWeight: FontWeight.w700),maxLines: 1),
                      ),

                      Container(
                        child: Text(product,
                          style: TextStyle(color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'BebesNeue',
                              fontWeight: FontWeight.w700),),
                      ),
                    ],

                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 10, top: 5),
                    child: Row(children: [

                      Container(
                        child: Text("Date : ",
                            style: TextStyle(color: Colors.black54,
                                fontSize: 12,
                                fontFamily: 'BebesNeue',
                                fontWeight: FontWeight.w700),maxLines: 1),
                      ),

                      Container(
                        child: Text(Date,
                          style: TextStyle(color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'BebesNeue',
                              fontWeight: FontWeight.w700),),
                      ),

                    ],

                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 10, top: 5),
                    child: Row(children: [

                      Container(
                        child: Text("Time : ",
                            style: TextStyle(color: Colors.black54,
                                fontSize: 12,
                                fontFamily: 'BebesNeue',
                                fontWeight: FontWeight.w700),maxLines: 1),
                      ),

                      Container(
                        child: Text(time,
                          style: TextStyle(color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'BebesNeue',
                              fontWeight: FontWeight.w700),),
                      ),

                    ],

                    ),
                  ),



                  Visibility(
                    visible: isNumber,
                    child: Container(
                      margin: EdgeInsets.only(right: 20,top: 35),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 0, top: 0),
                              child: Center(
                                child: Text("+91-"+callnumber,
                                    style: TextStyle(color: Colors.grey,
                                        fontSize: 11,
                                        fontFamily: 'BebesNeue',
                                        fontWeight: FontWeight.w700),maxLines: 1),
                              ),
                            ),

                            InkWell(
                              onTap:(){
                                _makingPhoneCall();
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: 0, left: 20),
                                child: Image.asset(
                                  "image/callblue.png", height: 20,
                                  width: 20,),
                              ),
                            ),

                            InkWell(
                              onTap:(){
                                _makingWhatsapp();
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: 0, left: 15),
                                child: Image.asset(
                                  "image/whatsapp.png", height: 22,
                                  width: 22,),
                              ),
                            ),

                          ]),
                    ),
                  ),


                ],),
              )




            ],

          )


      ),
    );
  }

  Future<List <ResultAlertTaskDetail>> getAlertsTaskDetail() async{

   // String newurl = "https://inboundcrm.in/travcrm-dev_2.2/Api/App/nikhil/json_taskdetail.php?id="+id;

      String newurl=AppNetworkConstants.ALERTSTASKDETAIL + "?id=" +id;

    print("Alerts Task Detail url is : "+newurl);

    var url= Uri.parse(newurl);


    http.Response res = await http.get(url);
    //  List datas= jsonDecode(res.body);

    print("Alerts Task Detail response is : "+res.body);

    var datas= jsonDecode(res.body)['result'] as List;

    List<ResultAlertTaskDetail> dashdata = datas.map((data) => ResultAlertTaskDetail.fromJson(data)).toList();

    return dashdata;
  }

  _makingPhoneCall() async {

    //  const url = 'tel:9910910910';

    String url = 'tel:'+callnumber!;

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _makingWhatsapp() async {
    // String url = '+919910910910';

    //  await launch('https://wa.me/$url?text=Welcome');

    String url = whatsappnumber;

    await launch("whatsapp://send?phone="+url+"&text=hello");
  }

}

