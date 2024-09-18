
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salescrm/Apis/apis.dart';
import 'package:salescrm/Models/alertduedetailmodel.dart';
import 'package:salescrm/Models/alerttaskdetailmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';


class AlertOverDueDetailST extends StatefulWidget {
  // ItemDetail({required this.itemlist});

  @override
  State createState() => new MyAlertOverDueDetailST();
}

class MyAlertOverDueDetailST extends State<AlertOverDueDetailST> {

  List<ResultAlertDueDetail>? alertduedetailmodels;

  String callnumber="";
  String whatsappnumber="";

  String tourid="";
  String traveldate="";
  String agentname="";
  String contactperson="";
  String agenttotalamount="";
  String paymentduedate="";
  String overdueamount="";
  String aging="";
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
                    child: Text("Alert OverDue Details",
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

                  child: Text("OVER DUE ALERTS",
                    style: TextStyle(color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'BebesNeue',
                        fontWeight: FontWeight.w700),),
                ),


                // Call Api

                FutureBuilder(
                    future: getAlertsDueDetail(),
                    builder:(context,  snapshot) {

                      if(snapshot.hasData) {

                        alertduedetailmodels = snapshot.data as List<ResultAlertDueDetail>?;

                        tourid = alertduedetailmodels![0].tourid.toString();
                        traveldate = alertduedetailmodels![0].traveldate.toString();
                        agentname = alertduedetailmodels![0].agentname.toString();
                        contactperson = alertduedetailmodels![0].contactperson.toString();
                        aging = alertduedetailmodels![0].aging.toString();
                        agenttotalamount = alertduedetailmodels![0].agenttotalamount.toString();
                        paymentduedate = alertduedetailmodels![0].paymentduedate.toString();
                        overdueamount = alertduedetailmodels![0].overdueamount.toString();
                        callnumber = alertduedetailmodels![0].contactnumber.toString();
                        whatsappnumber = alertduedetailmodels![0].contactnumber.toString();


                        print(""+tourid);
                        print(""+traveldate);
                        print(""+agentname);

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
                height: 270,
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
                        child: Text("Agent Name : ",
                            style: TextStyle(color: Colors.black54,
                                fontSize: 12,
                                fontFamily: 'BebesNeue',
                                fontWeight: FontWeight.w700),maxLines: 1),
                      ),

                      Container(
                        child: Text(agentname,
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
                        child: Text("Tour Id : ",
                            style: TextStyle(color: Colors.black54,
                                fontSize: 12,
                                fontFamily: 'BebesNeue',
                                fontWeight: FontWeight.w700),maxLines: 1),
                      ),

                      Container(
                        child: Text(tourid,
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
                        child: Text("Travel Date : ",
                            style: TextStyle(color: Colors.black54,
                                fontSize: 12,
                                fontFamily: 'BebesNeue',
                                fontWeight: FontWeight.w700),maxLines: 1),
                      ),

                      Container(
                        child: Text(traveldate,
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
                        child: Text("Agent : ",
                            style: TextStyle(color: Colors.black54,
                                fontSize: 12,
                                fontFamily: 'BebesNeue',
                                fontWeight: FontWeight.w700),maxLines: 1),
                      ),

                      Container(
                        child: Text(agentname,
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
                        child: Text("contact Person: ",
                            style: TextStyle(color: Colors.black54,
                                fontSize: 12,
                                fontFamily: 'BebesNeue',
                                fontWeight: FontWeight.w700),maxLines: 1),
                      ),

                      Container(
                        child: Text(contactperson,
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
                        child: Text("Agent Amount : ",
                            style: TextStyle(color: Colors.black54,
                                fontSize: 12,
                                fontFamily: 'BebesNeue',
                                fontWeight: FontWeight.w700),maxLines: 1),
                      ),

                      Container(
                        child: Text(agenttotalamount,
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
                        child: Text("Payment Due Date : ",
                            style: TextStyle(color: Colors.black54,
                                fontSize: 12,
                                fontFamily: 'BebesNeue',
                                fontWeight: FontWeight.w700),maxLines: 1),
                      ),

                      Container(
                        child: Text(paymentduedate,
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
                        child: Text("OverDue Amount : ",
                            style: TextStyle(color: Colors.black54,
                                fontSize: 12,
                                fontFamily: 'BebesNeue',
                                fontWeight: FontWeight.w700),maxLines: 1),
                      ),

                      Container(
                        child: Text(overdueamount,
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
                        child: Text("Aging : ",
                            style: TextStyle(color: Colors.black54,
                                fontSize: 12,
                                fontFamily: 'BebesNeue',
                                fontWeight: FontWeight.w700),maxLines: 1),
                      ),

                      Container(
                        child: Text(aging,
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

  Future<List <ResultAlertDueDetail>> getAlertsDueDetail() async{

 //  String newurl = "https://inboundcrm.in/travcrm-dev_2.2/Api/App/nikhil/json_overdueamountdetail.php?id="+id;

    String newurl= AppNetworkConstants.ALERTSDUEDETAIL + "?id=" +id;

    print("Alerts OverDue Detail url is : "+newurl);

    var url= Uri.parse(newurl);


    http.Response res = await http.get(url);
    //  List datas= jsonDecode(res.body);

    print("Alerts OverDue Detail response is : "+res.body);

    var datas= jsonDecode(res.body)['result'] as List;

    List<ResultAlertDueDetail> dashdata = datas.map((data) => ResultAlertDueDetail.fromJson(data)).toList();

    print(""+dashdata[0].agentname.toString());
    print(""+dashdata[0].agenttotalamount.toString());
    print(""+dashdata[0].tourid.toString());

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

