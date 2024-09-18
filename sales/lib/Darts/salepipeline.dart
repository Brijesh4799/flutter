
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:salescrm/Darts/salepipedetaildata.dart';
import 'package:salescrm/Darts/salepipeheaderdata.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../Apis/apis.dart';
import '../Models/callmodel.dart';
import '../Models/itemodel.dart';
import '../Providers/callprovider.dart';
import 'addcall.dart';
import 'addmeet.dart';
import 'addtask.dart';
import 'calltodaydata.dart';
import 'data.dart';
import 'expensedata.dart';
import 'items.dart';



class SalesPipelineST extends StatefulWidget {
  // ItemDetail({required this.itemlist});

  @override
  State createState() => new MySalesPipelineST();
}

class MySalesPipelineST extends State<SalesPipelineST> {

  List<ResultsCall>? callmodel;

  List<DaysIte>? daysdatamodel;
  List<ServicesIte>? servicedatamodel;
  Color isColorheader=Colors.blue;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("image/callbg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(children: [

              Container(
                height: 75,
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
                        child: Text("Sales Pipeline Report",
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
                          "image/bellicon.png", height: 35, width: 40,),
                      )
                    ],

                  ),
                ),
              ),

              // Call Api

             /* FutureBuilder(
                  future: getDayIte(),
                  builder:(context, snapshot) {

                    if(snapshot.hasData) {
                      daysdatamodel= snapshot.data as List<DaysIte>;
                      return  getCallWidget();

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

              )*/
              getCallWidget()




            ],
            ),
          )
      ),
    );
  }


  Widget getCallWidget(){
    return  Expanded(

      child: Container(

          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
              left: 10, right: 10, top: 20, bottom: 10),
          //height: 275,

          padding: EdgeInsets.only(
              left: 10, right: 10, top: 0, bottom: 15),


          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              /* border: Border(
                            top: BorderSide(color: Colors.white,width: 2.0,style: BorderStyle.solid),
                            bottom: BorderSide(color: Colors.white,width: 2.0,style: BorderStyle.solid),
                            right: BorderSide(color: Colors.white,width: 2.0,style: BorderStyle.solid),
                            left: BorderSide(color: Colors.white,width: 2.0,style: BorderStyle.solid),
                          ),*/
              //  color: Colors.deepOrange,
              gradient: LinearGradient(
                //   begin: Alignment.topLeft,
                //   end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.3),
                  Colors.white.withOpacity(0.3),
                ],
                //  stops: [0.0,1.0]
              )

          ),

          child: Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(
              children: <Widget>[
                Expanded(child: ListView.builder(
                    itemCount: salepipeheaderdata!.length,
                    itemBuilder: (context, index) {
                      SalePipeHeaderData  salesheader= salepipeheaderdata[index];
                      if(salesheader.name.toString()=="Assigned")
                        {
                          isColorheader=Colors.blue;
                        }
                      else if(salesheader.name.toString()=="Reverted")
                      {
                        isColorheader=Colors.deepOrange;
                      }
                      else if(salesheader.name.toString()=="Option Sent")
                      {
                        isColorheader=Colors.orange;
                      }
                      else if(salesheader.name.toString()=="Follow-up")
                      {
                        isColorheader=Color(0xffffd600);
                      }
                      else if(salesheader.name.toString()=="Confirmed")
                      {
                        isColorheader=Colors.lightGreen;
                      }
                      else if(salesheader.name.toString()=="Query Lost")
                      {
                        isColorheader=Color(0xffef5350);
                      }

                return Card(
                  color: isColorheader,
                  elevation: 4,
                  child: ExpansionTile(
                    iconColor: Colors.white,
                    collapsedIconColor: Colors.white,
                    /*trailing: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                      size: 30,
                    ),*/
                    title: Container(
                    //  margin: EdgeInsets.only(right: 100),
                      child: Row(
                        children: [
                          Text(salesheader.name.toString()+" "+"("+salesheader.percent.toString()+")",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'BebesNeue',
                                fontWeight: FontWeight.w700),),
                        ],
                      ),
                    ),
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10,bottom: 10),
                        height:200,
                        color: Colors.white,
                        child: ListView.builder(
                            itemCount: salepipedetaildatassign.length,
                            itemBuilder: (context, index1){
                              SalePipeDetailData itemlist =salepipedetaildatassign![index1];
                              return Column(children: [

                                Container(
                                  margin: EdgeInsets.only(left: 10,top: 10),
                                  child: Row(children: [
                                    Text(itemlist.date.toString()+" "+itemlist.company.toString(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontFamily: 'BebesNeue',
                                          fontWeight: FontWeight.w700),),

                              ],
                              ),
                                ),

                                Container(
                                  margin: EdgeInsets.only(left: 10,top:2.5,bottom: 10),
                                  child: Row(
                                      children: [
                                        Text(itemlist.clientname.toString(),
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10,
                                              fontFamily: 'BebesNeue',
                                              fontWeight: FontWeight.w700),),
                                      ]
                                  ),
                                ),

                                Container(width: MediaQuery.of(context).size.width,height: 1,color: Colors.grey,)
                             ]
                              );
                            }),
                      )
                    ],
                  ),
                );
      })
    )
              ],

            ),
          )

      ),
    );
  }


  Future <List<DaysIte>> getDayIte() async {

    List<DaysIte> daysdata=[];

      String newurl = "https://travcrm.in/travcrm-dev_2.2/Api/App/CLIENT/json_iteneraryquote_flutter_api.php?Refid=R20220058";

      print("Itinerary Url is : "+newurl);

      var url = Uri.parse(newurl);

      print("Itenrary api url is"+newurl);

      http.Response res = await http.get(url);

      print("Itenrary api response is"+res.body);

      var datas = jsonDecode(res.body)['Days'] as List;

      daysdata = datas.map((data) => DaysIte.fromJson(data)).toList();

      return daysdata;
  }

}