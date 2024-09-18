import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/tmitemodel.dart';
import '../Utils/Apis.dart';


class TMItinerarySL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: TMItinerary(),
    );
  }
}

class TMItinerary extends StatefulWidget {

  @override
  State createState() => MyTMItinerary();
}

class MyTMItinerary extends State<TMItinerary> {

/* String daynumber="";
 String date="";

 String ServiceTypeId="";*/


  String? mylist="";
  String refID="";

  String? voucherUrl="1";

  late SharedPreferences p_refid,preflist;

  int mypos=0;
  String m_tourid="";
  String m_refid="";

  List<DaysIteTM>? daysdatamodel;
  List<ServicesIteTM>? servicedatamodel;

  late DaysIteTM itemslists;

  late ServicesIteTM servicelists;

  String serviceTypeId="Accomodation";
  String  serviceTypeName="Hotel";
  String  serviceCategory="5";
  String  pickuptime="12:00:00 AM";
  String  droptime="12:00:00 PM";
  String  serviceDetail="12:00:00 AM";
  String  serviceDetail01="12:00:00 PM";
  String  feedback="";


  String accomodationimg="hoteliteicon.png";

  String starimg="star5.png";
  bool visibilityStar = true;
  bool visibilitypickup = true;
  bool visibilitydrop = true;
  bool visibilityservicdetail = true;
  bool visibilityservicedetail01 = true;
  Color myimgcolor= Color(0xffffa000);


  String connectstatus="waiting...";

  Connectivity _connectivity = Connectivity();

  void checkConnectivity() async{

    var connnectionResult = await _connectivity.checkConnectivity();

   if(connnectionResult == ConnectivityResult.wifi){
     setState(() {
       connectstatus = "Wifi";
     });

   }
    else if(connnectionResult == ConnectivityResult.mobile){
      setState(() {
        connectstatus = "MobileData";
      });

    }
    else{
      setState(() {
        connectstatus = "Not Connected";
      });
   }
  }


  bool isFeedBackClick= false;

  String feebackvalue="5";

  String excellentplane="ratingwhite.png";
  String vgoodplane="ratingwhite.png";
  String goodplane="ratingwhite.png";
  String avgplane="ratingwhite.png";
  String poorplane="ratingwhite.png";

  bool visibilityFeedblue = true;
  bool visibilityFeedwhite = false;

  getFeedBlue(){
    setState(() {
      visibilityFeedblue = true;
      visibilityFeedwhite = false;
      print("Feed Blue");
    });
  }

  getFeedWhite(){
    setState(() {
      visibilityFeedblue = false;
      visibilityFeedwhite = true;
      print("Feed white");
    });
  }


  void getExcellent(){
      excellentplane="ratingblue.png";
      vgoodplane="ratingwhite.png";
      goodplane="ratingwhite.png";
      avgplane="ratingwhite.png";
      poorplane="ratingwhite.png";
  }

  void getVGood(){
    excellentplane="ratingwhite.png";
    vgoodplane="ratingblue.png";
    goodplane="ratingwhite.png";
    avgplane="ratingwhite.png";
    poorplane="ratingwhite.png";
  }

  void getGood(){
    excellentplane="ratingwhite.png";
    vgoodplane="ratingwhite.png";
    goodplane="ratingblue.png";
    avgplane="ratingwhite.png";
    poorplane="ratingwhite.png";
  }

  void getAvg(){
    excellentplane="ratingwhite.png";
    vgoodplane="ratingwhite.png";
    goodplane="ratingwhite.png";
    avgplane="ratingblue.png";
    poorplane="ratingwhite.png";
  }

  void getPoor(){
    excellentplane="ratingwhite.png";
    vgoodplane="ratingwhite.png";
    goodplane="ratingwhite.png";
    avgplane="ratingwhite.png";
    poorplane="ratingblue.png";
  }


  getMyRefId() async {
    p_refid = await SharedPreferences.getInstance();
    setState(() {
      m_refid = p_refid.getString("refid")!;
      print ("Recieved refid from Home UI : " +m_refid);
    });
  }

  getMyIte() async{
    preflist = await SharedPreferences.getInstance();
    setState(() {
      mylist =  preflist.getString("list")!;
    });
  }

  void checkRealTimeConnection() async{
    _connectivity.onConnectivityChanged.listen((event) {

      if(event == ConnectivityResult.wifi){
        setState(() {
          connectstatus = "Wifi";
          print("Connection is : " +connectstatus);
        });

      }
      else if(event == ConnectivityResult.mobile){
        setState(() {
          connectstatus = "MobileData";
          print("Connection is : " +connectstatus);
        });

      }
      else{
        setState(() {
          connectstatus = "No Internet Connection";
          print("Connection is : " +connectstatus);
           Fluttertoast.showToast(
            msg: connectstatus,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 4,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 12.0,
          );
        });
      }

    });
  }


  @override
  void initState() {
    checkRealTimeConnection();
    getMyRefId();
    getExcellent();
    isFeedBackClick=true;
    feebackvalue="5";
    print(feebackvalue);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    print("Build Function is Called");
    return SafeArea(
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
                  child: Text("Itinerary",
                      style: TextStyle(color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'BebesNeue',
                          fontWeight: FontWeight.w700)),
                )

              ],

            ),
          ),
        ),

        body: Column(
          children: [


            Expanded(

              child: Container(
                margin: EdgeInsets.only(top: 10,bottom: 0),
                child: FutureBuilder(
                    future: getDayIte(),
                    builder:(context, snapshot) {
                      print("Connection status from Itenrary : " + connectstatus);
                      print("Snapshot value is : $snapshot");

                      if(snapshot.hasData) {
                        daysdatamodel= snapshot.data;
                        if (connectstatus == "Wifi" || connectstatus == "MobileData") {
                          print("daymodel value is : $daysdatamodel");

                          return   Container(
                            child: Column(
                              children: [

                                Expanded(
                                  child: ListView.builder(
                                      itemCount: daysdatamodel!.length,
                                      itemBuilder: (context,index){
                                        DaysIteTM  itemslists = daysdatamodel![index];

                                        return Container(
                                          child: Column(
                                              children: [

                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.lightBlueAccent,
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(30),
                                                      topRight: Radius.circular(30),),
                                                  ),
                                                  width: MediaQuery.of(context).size.width,
                                                  // color: Colors.cyan,
                                                  padding: EdgeInsets.only(top: 10,bottom: 10,left: 20),
                                                  child: Text(itemslists.dayNumber.toString()+" : "+itemslists.date.toString(),
                                                      style: TextStyle(color: Colors.white,
                                                          fontSize: 12,
                                                          fontFamily: 'BebesNeue',
                                                          fontWeight: FontWeight.w700)),

                                                ),

                                                Container(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        child: ListView.builder(
                                                            itemCount:itemslists.services!.length,
                                                            physics: ClampingScrollPhysics(),
                                                            shrinkWrap: true,
                                                            itemBuilder: (context,index1) {
                                                              ServicesIteTM  servicelists = itemslists.services![index1];

                                                              /* print("feedback from itenrary is : ${servicelists.feedback!}");
                                                              if(servicelists.feedback=="0"){
                                                                visibilityFeedblue = true;
                                                                visibilityFeedwhite = false;
                                                                print("Feed Blue");
                                                              }else{
                                                                visibilityFeedblue = false;
                                                                visibilityFeedwhite = true;
                                                                print("Feed white");
                                                              }*/

                                                              serviceTypeId=servicelists.serviceTypeId.toString();
                                                              serviceTypeName=servicelists.serviceTypeName.toString();
                                                              serviceCategory=servicelists.serviceCategory.toString();
                                                              pickuptime=servicelists.startTime.toString();
                                                              droptime=servicelists.endTime.toString();
                                                              serviceDetail=servicelists.serviceDetails.toString();
                                                              serviceDetail01=servicelists.serviceDetails01.toString();
                                                            
                                                              if(serviceCategory==5){
                                                                starimg="star5.png";
                                                              }
                                                              else if(serviceCategory==4){
                                                                starimg="star4.png";
                                                              }
                                                              else if(serviceCategory==3){
                                                                starimg="star3final.png";
                                                              }
                                                              else if(serviceCategory==2){
                                                                starimg="star2final.png";
                                                              }
                                                              else if(serviceCategory==1){
                                                                starimg="star1final.png";
                                                              }

                                                              if(serviceTypeId=="Accommodation"){
                                                                accomodationimg="hoteliteicon.png";
                                                                myimgcolor= Color(0xffffa000);
                                                                visibilityStar=true;
                                                                visibilitypickup=false;
                                                                visibilitydrop=false;
                                                                visibilityservicdetail=true;
                                                                visibilityservicedetail01=true;
                                                              }
                                                              else if(serviceTypeId=="Transfer"){
                                                                accomodationimg="transferiteicon.png";
                                                                myimgcolor= Color(0xffef5350);
                                                                visibilityStar=false;
                                                                visibilitypickup=true;
                                                                visibilitydrop=true;
                                                                visibilityservicdetail=true;
                                                                visibilityservicedetail01=false;
                                                              }
                                                              else if(serviceTypeId=="Entrance"){
                                                                accomodationimg="entraneiteicon.png";
                                                                myimgcolor= Color(0xff7cb342);
                                                                visibilityStar=false;
                                                                visibilitypickup=true;
                                                                visibilitydrop=true;
                                                                visibilityservicdetail=false;
                                                                visibilityservicedetail01=false;
                                                              }
                                                              else if(serviceTypeId=="Activity"){
                                                                accomodationimg="activityiteicon.png";
                                                                myimgcolor= Color(0xff3f51bf);
                                                                visibilityStar=false;
                                                              }
                                                              else if(serviceTypeId=="Guide"){
                                                                accomodationimg="guideicon.png";
                                                                myimgcolor= Color(0xffffe082);
                                                                visibilityStar=false;
                                                                visibilitypickup=false;
                                                                visibilitydrop=false;
                                                                visibilityservicdetail=false;
                                                                visibilityservicedetail01=false;
                                                              }
                                                              else if(serviceTypeId=="Train"){
                                                                accomodationimg="trainicon.png";
                                                                myimgcolor= Color(0xffef5350);
                                                                visibilityStar=false;
                                                                visibilitypickup=true;
                                                                visibilitydrop=true;
                                                                visibilityservicdetail=true;
                                                                visibilityservicedetail01=false;
                                                              }
                                                              else if(serviceTypeId=="Flight"){
                                                                accomodationimg="entraneiteicon.png";
                                                                myimgcolor= Color(0xff7cb342);
                                                                visibilityStar=false;
                                                                visibilitypickup=true;
                                                                visibilitydrop=true;
                                                                visibilityservicdetail=true;
                                                                visibilityservicedetail01=true;
                                                              }

                                                              else{
                                                                accomodationimg="hoteliteicon.png";
                                                                myimgcolor= Color(0xffffa000);
                                                                visibilityStar=false;
                                                                visibilitypickup=false;
                                                                visibilitydrop=false;
                                                                visibilityservicdetail=false;
                                                                visibilityservicedetail01=false;
                                                              }



                                                              return Container(
                                                                height: 175,
                                                                child:  Row(children: [

                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Column(
                                                                      children: [
                                                                        Container(height: 25, width: 7,
                                                                          color: myimgcolor,),

                                                                        Container(
                                                                          child: Image.asset("image/"+accomodationimg,
                                                                            height: 50, width: 50,fit: BoxFit.cover,),
                                                                        ),

                                                                        Container(height: 100, width: 7,
                                                                          color: myimgcolor,),
                                                                      ],
                                                                    ),
                                                                  ),

                                                                  Expanded(
                                                                    flex: 3,
                                                                    child: Column(
                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [

                                                                        Container(
                                                                          width: 150,
                                                                          margin: EdgeInsets.only(left: 5,top: 42.5),
                                                                          child: Text(serviceTypeId,
                                                                              style: TextStyle(color: Colors.black,
                                                                                fontSize: 13,
                                                                                fontFamily: 'BebesNeue',
                                                                                fontWeight: FontWeight.w700,)),
                                                                        ),

                                                                        SizedBox(height: 15,),

                                                                        Container(
                                                                          width: 180,
                                                                          child: Text(serviceTypeName,
                                                                              maxLines: 1,
                                                                              style: TextStyle(color: Color(0xff90a4ae),
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  fontSize: 10,
                                                                                  fontFamily: 'BebesNeue',
                                                                                  fontWeight: FontWeight.w700)),
                                                                        ),

                                                                        SizedBox(height: 5,),

                                                                        Row( children: [

                                                                          Visibility(
                                                                            visible: visibilityStar,
                                                                            child:   Container(
                                                                              child: Image.asset("image/"+starimg,
                                                                                height: 10, width: 50,),
                                                                            ),
                                                                          ),
                                                                        ],

                                                                        ),

                                                                        SizedBox(height: 5,),

                                                                        Visibility(
                                                                          visible: visibilityservicdetail,
                                                                          child:   Container(
                                                                            width: 180,
                                                                            child: Text(servicelists.serviceDetails.toString(),
                                                                                style: TextStyle(color: Color(0xff90a4ae),
                                                                                    fontSize: 10,
                                                                                    fontFamily: 'BebesNeue',
                                                                                    fontWeight: FontWeight.w700)),
                                                                          ),
                                                                        ),

                                                                        SizedBox(height: 5,),

                                                                        Visibility(
                                                                          visible: visibilityservicedetail01,
                                                                          child:  Container(
                                                                            width: 180,
                                                                            child: Text(servicelists.serviceDetails01.toString(),
                                                                                style: TextStyle(color: Color(0xff90a4ae),
                                                                                    fontSize: 10,
                                                                                    fontFamily: 'BebesNeue',
                                                                                    fontWeight: FontWeight.w700)),
                                                                          ),
                                                                        ),

                                                                        SizedBox(height: 5,),

                                                                        Visibility(
                                                                          visible: visibilitypickup,
                                                                          child: Container(
                                                                            width: 180,
                                                                            child: Row(
                                                                              children: [
                                                                                Container(
                                                                                  child: Text("Pickup Time : ",
                                                                                      textAlign: TextAlign.left,
                                                                                      style: TextStyle(color: Color(0xff90a4ae),
                                                                                          fontSize: 10,
                                                                                          fontFamily: 'BebesNeue',
                                                                                          fontWeight: FontWeight.w700)),
                                                                                ),

                                                                                Container(
                                                                                  child: Text(servicelists.startTime.toString(),
                                                                                      textAlign: TextAlign.left,
                                                                                      style: TextStyle(color: Color(0xff90a4ae),
                                                                                          fontSize: 10,
                                                                                          fontFamily: 'BebesNeue',
                                                                                          fontWeight: FontWeight.w700)),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),



                                                                        SizedBox(height: 5,),

                                                                        Visibility(
                                                                          visible: visibilitydrop,
                                                                          child: Container(
                                                                            width: 180,
                                                                            child: Row(
                                                                              children: [
                                                                                Container(
                                                                                  child: Text("Drop Time : ",
                                                                                      style: TextStyle(color: Color(0xff90a4ae),
                                                                                          fontSize: 10,
                                                                                          fontFamily: 'BebesNeue',
                                                                                          fontWeight: FontWeight.w700)),
                                                                                ),

                                                                                Container(
                                                                                  child: Text(servicelists.endTime.toString(),
                                                                                      style: TextStyle(color: Color(0xff90a4ae),
                                                                                          fontSize: 10,
                                                                                          fontFamily: 'BebesNeue',
                                                                                          fontWeight: FontWeight.w700)),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),



                                                                  Expanded(
                                                                    flex: 2,
                                                                    child: Column(
                                                                      children: [



                                                                      ],
                                                                    ),
                                                                  )



                                                                ],),
                                                              );
                                                            }
                                                        ),
                                                      )

                                                    ],),
                                                ),
                                              ]
                                          ),
                                        );

                                      }
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        else {
                          return  Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("image/travbg.jpg"),
                                fit: BoxFit.cover,
                              ),),
                            child: Column(
                              children: [

                                Expanded(
                                  child: ListView.builder(
                                      itemCount: daysdatamodel!.length,
                                      itemBuilder: (context,index){

                                        DaysIteTM  itemslists = daysdatamodel![index];

                                        return Container(
                                          child: Column(
                                              children: [

                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.lightBlueAccent,
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(30),
                                                      topRight: Radius.circular(30),),
                                                  ),
                                                  width: MediaQuery.of(context).size.width,
                                                  // color: Colors.cyan,
                                                  padding: EdgeInsets.only(top: 10,bottom: 10,left: 20),
                                                  child: Text(itemslists.dayNumber.toString()+" : "+itemslists.date.toString(),
                                                      style: TextStyle(color: Colors.white,
                                                          fontSize: 12,
                                                          fontFamily: 'BebesNeue',
                                                          fontWeight: FontWeight.w700)),

                                                ),

                                                Container(
                                                  child: ListView.builder(
                                                      itemCount:itemslists.services!.length,
                                                      physics: ClampingScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemBuilder: (context,index1) {
                                                        ServicesIteTM servicelists = itemslists.services![index1];

                                                        /* print("feedback from itenrary is : ${servicelists.feedback!}");
                                                        if(servicelists.feedback=="0"){
                                                          visibilityFeedblue = true;
                                                          visibilityFeedwhite = false;
                                                          print("Feed Blue");
                                                        }else{
                                                          visibilityFeedblue = false;
                                                          visibilityFeedwhite = true;
                                                          print("Feed white");
                                                        }*/

                                                        serviceTypeId=servicelists.serviceTypeId.toString();
                                                        serviceTypeName=servicelists.serviceTypeName.toString();
                                                        serviceCategory=servicelists.serviceCategory.toString();
                                                        pickuptime=servicelists.startTime.toString();
                                                        droptime=servicelists.endTime.toString();
                                                        serviceDetail=servicelists.serviceDetails.toString();
                                                        serviceDetail01=servicelists.serviceDetails01.toString();
                                                        //   servicelist=servicelists.serviceID.toString();
                                                      
                                                        if(serviceCategory==5){
                                                          starimg="star5.png";
                                                        }
                                                        else if(serviceCategory==4){
                                                          starimg="star4.png";
                                                        }
                                                        else if(serviceCategory==3){
                                                          starimg="star3final.png";
                                                        }
                                                        else if(serviceCategory==2){
                                                          starimg="star2final.png";
                                                        }
                                                        else if(serviceCategory==1){
                                                          starimg="star1final.png";
                                                        }

                                                        if(serviceTypeId=="Accommodation"){
                                                          accomodationimg="hoteliteicon.png";
                                                          myimgcolor= Color(0xffffa000);
                                                          visibilityStar=true;
                                                          visibilitypickup=false;
                                                          visibilitydrop=false;
                                                          visibilityservicdetail=true;
                                                          visibilityservicedetail01=true;
                                                        }
                                                        else if(serviceTypeId=="Transfer"){
                                                          accomodationimg="transferiteicon.png";
                                                          myimgcolor= Color(0xffef5350);
                                                          visibilityStar=false;
                                                          visibilitypickup=true;
                                                          visibilitydrop=true;
                                                          visibilityservicdetail=true;
                                                          visibilityservicedetail01=false;
                                                        }
                                                        else if(serviceTypeId=="Entrance"){
                                                          accomodationimg="entraneiteicon.png";
                                                          myimgcolor= Color(0xff7cb342);
                                                          visibilityStar=false;
                                                          visibilitypickup=true;
                                                          visibilitydrop=true;
                                                          visibilityservicdetail=false;
                                                          visibilityservicedetail01=false;
                                                        }
                                                        else if(serviceTypeId=="Activity"){
                                                          accomodationimg="activityiteicon.png";
                                                          myimgcolor= Color(0xff3f51bf);
                                                          visibilityStar=false;
                                                        }
                                                        else if(serviceTypeId=="Guide"){
                                                          accomodationimg="guideicon.png";
                                                          myimgcolor= Color(0xffffe082);
                                                          visibilityStar=false;
                                                          visibilitypickup=false;
                                                          visibilitydrop=false;
                                                          visibilityservicdetail=false;
                                                          visibilityservicedetail01=false;
                                                        }
                                                        else if(serviceTypeId=="Train"){
                                                          accomodationimg="trainicon.png";
                                                          myimgcolor= Color(0xffef5350);
                                                          visibilityStar=false;
                                                          visibilitypickup=true;
                                                          visibilitydrop=true;
                                                          visibilityservicdetail=true;
                                                          visibilityservicedetail01=false;
                                                        }
                                                        else if(serviceTypeId=="Flight"){
                                                          accomodationimg="entraneiteicon.png";
                                                          myimgcolor= Color(0xff7cb342);
                                                          visibilityStar=false;
                                                          visibilitypickup=true;
                                                          visibilitydrop=true;
                                                          visibilityservicdetail=true;
                                                          visibilityservicedetail01=true;
                                                        }

                                                        else{
                                                          accomodationimg="hoteliteicon.png";
                                                          myimgcolor= Color(0xffffa000);
                                                          visibilityStar=false;
                                                          visibilitypickup=false;
                                                          visibilitydrop=false;
                                                          visibilityservicdetail=false;
                                                          visibilityservicedetail01=false;
                                                        }



                                                        return Container(
                                                          height: 175,
                                                          child:  Row(children: [

                                                            Expanded(
                                                              flex: 1,
                                                              child: Column(
                                                                children: [
                                                                  Container(height: 25, width: 7,
                                                                    color: myimgcolor,),

                                                                  Container(
                                                                    child: Image.asset("image/"+accomodationimg,
                                                                      height: 50, width: 50,fit: BoxFit.cover,),
                                                                  ),

                                                                  Container(height: 100, width: 7,
                                                                    color: myimgcolor,),
                                                                ],
                                                              ),
                                                            ),

                                                            Expanded(
                                                              flex: 3,
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [

                                                                  Container(
                                                                    width: 150,
                                                                    margin: EdgeInsets.only(left: 5,top: 42.5),
                                                                    child: Text(serviceTypeId,
                                                                        style: TextStyle(color: Colors.black,
                                                                          fontSize: 13,
                                                                          fontFamily: 'BebesNeue',
                                                                          fontWeight: FontWeight.w700,)),
                                                                  ),

                                                                  SizedBox(height: 15,),

                                                                  Container(
                                                                    width: 180,
                                                                    child: Text(serviceTypeName,
                                                                        maxLines: 1,
                                                                        style: TextStyle(color: Color(0xff90a4ae),
                                                                            overflow: TextOverflow.ellipsis,
                                                                            fontSize: 10,
                                                                            fontFamily: 'BebesNeue',
                                                                            fontWeight: FontWeight.w700)),
                                                                  ),

                                                                  SizedBox(height: 5,),

                                                                  Row( children: [

                                                                    Visibility(
                                                                      visible: visibilityStar,
                                                                      child:   Container(
                                                                        child: Image.asset("image/"+starimg,
                                                                          height: 10, width: 50,),
                                                                      ),
                                                                    ),
                                                                  ],

                                                                  ),

                                                                  SizedBox(height: 5,),

                                                                  Visibility(
                                                                    visible: visibilityservicdetail,
                                                                    child:   Container(
                                                                      width: 180,
                                                                      child: Text(servicelists.serviceDetails.toString(),
                                                                          style: TextStyle(color: Color(0xff90a4ae),
                                                                              fontSize: 10,
                                                                              fontFamily: 'BebesNeue',
                                                                              fontWeight: FontWeight.w700)),
                                                                    ),
                                                                  ),

                                                                  SizedBox(height: 5,),

                                                                  Visibility(
                                                                    visible: visibilityservicedetail01,
                                                                    child:  Container(
                                                                      width: 180,
                                                                      child: Text(servicelists.serviceDetails01.toString(),
                                                                          style: TextStyle(color: Color(0xff90a4ae),
                                                                              fontSize: 10,
                                                                              fontFamily: 'BebesNeue',
                                                                              fontWeight: FontWeight.w700)),
                                                                    ),
                                                                  ),

                                                                  SizedBox(height: 5,),

                                                                  Visibility(
                                                                    visible: visibilitypickup,
                                                                    child: Container(
                                                                      width: 180,
                                                                      child: Row(
                                                                        children: [
                                                                          Container(
                                                                            child: Text("Pickup Time : ",
                                                                                textAlign: TextAlign.left,
                                                                                style: TextStyle(color: Color(0xff90a4ae),
                                                                                    fontSize: 10,
                                                                                    fontFamily: 'BebesNeue',
                                                                                    fontWeight: FontWeight.w700)),
                                                                          ),

                                                                          Container(
                                                                            child: Text(servicelists.startTime.toString(),
                                                                                textAlign: TextAlign.left,
                                                                                style: TextStyle(color: Color(0xff90a4ae),
                                                                                    fontSize: 10,
                                                                                    fontFamily: 'BebesNeue',
                                                                                    fontWeight: FontWeight.w700)),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),



                                                                  SizedBox(height: 5,),

                                                                  Visibility(
                                                                    visible: visibilitydrop,
                                                                    child: Container(
                                                                      width: 180,
                                                                      child: Row(
                                                                        children: [
                                                                          Container(
                                                                            child: Text("Drop Time : ",
                                                                                style: TextStyle(color: Color(0xff90a4ae),
                                                                                    fontSize: 10,
                                                                                    fontFamily: 'BebesNeue',
                                                                                    fontWeight: FontWeight.w700)),
                                                                          ),

                                                                          Container(
                                                                            child: Text(servicelists.endTime.toString(),
                                                                                style: TextStyle(color: Color(0xff90a4ae),
                                                                                    fontSize: 10,
                                                                                    fontFamily: 'BebesNeue',
                                                                                    fontWeight: FontWeight.w700)),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),



                                                            Expanded(
                                                              flex: 2,
                                                              child: Column(
                                                                children: [

                                                                  SizedBox(height: 42.5,),


                                                                ],
                                                              ),
                                                            )



                                                          ],),
                                                        );
                                                      }
                                                  ),
                                                ),
                                              ]
                                          ),
                                        );

                                      }
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
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
            ),
          ],

        ),
      ),
    );
  }

  Future <List<DaysIteTM>> getDayIte() async {

    List<DaysIteTM> daysdata=[];

    try{
     // String newurl = TravApis.ITENERARYFLUTTER + "Refid="+refID;

      String newurl = TravApis.TMITENERARYFLUTTER + "Refid="+m_refid;

      print("Itinerary Url is : "+newurl);

      var url = Uri.parse(newurl);

      print("Loading from api");
      http.Response res = await http.get(url);

      print("Itenrary api response is : "+res.body);

      var datas = jsonDecode(res.body)['Days'] as List;

      daysdata = datas.map((data) => DaysIteTM.fromJson(data)).toList();

     // mylist = jsonEncode(daysdata);
      preflist = await SharedPreferences.getInstance();
      preflist.setString("list",jsonEncode(datas));

      print("the send value of lists is : ${jsonEncode(datas)}");
      //  List datas= jsonDecode(res.body);

      return daysdata;
    }
    catch(SocketException){
      print("No Internet");

      getMyIte();

      print("the received of lists is : $mylist");

      var newdatas = jsonDecode(mylist!) as List;

      print("New DAta are :  $newdatas");

      daysdata = newdatas.map((data) => DaysIteTM.fromJson(data)).toList();


      print("the cache of lists is : $daysdata");

      return daysdata;
    }

  }

 /* Future<List <ResultFeedIte>> getFeedIte() async {
    String newurl = TravApis.FEEDBACKITE + "serviceId="+servicelists.serviceID!+"&serviceType="+servicelists.serviceTypeId!
        +"&quotationId="+itemslists.quotationId!+"&feedback="+feebackvalue;

    List<ResultFeedIte> feeditedata=[];


      print("FeedBack Itenrary URL" +newurl);

      var res = await http.post(
          Uri.parse(newurl),
          body: ({
            'serviceId': servicelists.serviceID,
            'serviceType': servicelists.serviceTypeId,
            'quotationId': itemslists.quotationId,
            'feedback': feebackvalue,
          })
      );

      print("Feedback Itenrary Responsee is " +res.body);

     setState(() {
     });

      var datas = jsonDecode(res.body)['result'] as List;

      feeditedata = datas.map((data) => ResultFeedIte.fromJson(data)).toList();

      String message = feeditedata[0].msg!;

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


      return feeditedata;

  }*/

  feedbackDialog(BuildContext context){
    return showDialog(
        context: context,
        builder: (context){
          return  StatefulBuilder(
            builder: (context, setState) => AlertDialog(

              actions: [

                Column(children: [

                  SizedBox(height: 10,),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left: 30,right: 30),
                    child: Center(
                      child: Text("How Would you rate",
                          // textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'BebesNeue',
                            fontWeight: FontWeight.w700,)),
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left: 30,top: 2.5, right: 30),
                    child: Center(
                      child: Text("our service?",
                          // textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'BebesNeue',
                            fontWeight: FontWeight.w700,)),
                    ),
                  ),

                  SizedBox(height: 5,),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          //  margin: EdgeInsets.only(left: 5,top: 5, right: 5),
                          child: Image.asset("image/ratinglogo.jpg",height: 80, ),
                        ),
                      ),],
                  ),


                  SizedBox(height: 15,),

                  Row(children: [

                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(left: 30,),
                        child: Text("Excellent",
                            style: TextStyle(color: Colors.black,
                              fontSize: 18,
                              /*fontFamily: 'BebesNeue',
                              fontWeight: FontWeight.w700,*/)),
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            getExcellent();
                            isFeedBackClick=true;
                            feebackvalue="5";
                            print(feebackvalue);
                          });
                        },
                        child: Row(
                          children: [

                            Container(
                              //  margin: EdgeInsets.only(left: 5,top: 5, right: 5),
                              child: Image.asset("image/emojiexcellent.png",height: 40,width: 40,),
                            ),
                            SizedBox(width: 12,),
                            Container(
                              //  margin: EdgeInsets.only(left: 5,top: 5, right: 5),
                              child: Image.asset("image/"+excellentplane,height: 20,width: 20,),
                            ),

                          ],),
                      ),




                    ),



                  ],),

                  SizedBox(height: 10,),

                  Row(children: [

                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(left: 30,),
                        child: Text("Very Good",
                            style: TextStyle(color: Colors.black,
                              fontSize: 18,
                              /*fontFamily: 'BebesNeue',
                              fontWeight: FontWeight.w700,*/)),
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            getVGood();
                            isFeedBackClick=true;
                            feebackvalue="4";
                            print(feebackvalue);
                          });

                        },
                        child: Row(
                          children: [

                            Container(
                              //  margin: EdgeInsets.only(left: 5,top: 5, right: 5),
                              child: Image.asset("image/emojivgood.png",height: 40,width: 40,),
                            ),
                            SizedBox(width: 12,),
                            Container(
                              //  margin: EdgeInsets.only(left: 5,top: 5, right: 5),
                              child: Image.asset("image/"+vgoodplane,height: 20,width: 20,),
                            ),

                          ],),
                      ),




                    ),



                  ],),

                  SizedBox(height: 10,),

                  Row(children: [

                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(left: 30,),
                        child: Text("Good",
                            style: TextStyle(color: Colors.black,
                              fontSize: 18,
                              /*fontFamily: 'BebesNeue',
                              fontWeight: FontWeight.w700,*/)),
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            getGood();
                            isFeedBackClick=true;
                            feebackvalue="3";
                            print(feebackvalue);
                          });
                        },
                        child: Row(
                          children: [

                            Container(
                              //  margin: EdgeInsets.only(left: 5,top: 5, right: 5),
                              child: Image.asset("image/emojigood.png",height: 40,width: 40,),
                            ),
                            SizedBox(width: 12,),
                            Container(
                              //  margin: EdgeInsets.only(left: 5,top: 5, right: 5),
                              child: Image.asset("image/"+goodplane,height: 20,width: 20,),
                            ),

                          ],),
                      ),




                    ),



                  ],),

                  SizedBox(height: 10,),

                  Row(children: [

                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(left: 30,),
                        child: Text("Average",
                            style: TextStyle(color: Colors.black,
                              fontSize: 18,
                              /*fontFamily: 'BebesNeue',
                              fontWeight: FontWeight.w700,*/)),
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            getAvg();
                            isFeedBackClick=true;
                            feebackvalue="2";
                            print(feebackvalue);
                          });
                        },
                        child: Row(
                          children: [

                            Container(
                              //  margin: EdgeInsets.only(left: 5,top: 5, right: 5),
                              child: Image.asset("image/emojiavg.png",height: 40,width: 40,),
                            ),
                            SizedBox(width: 12,),
                            Container(
                              //  margin: EdgeInsets.only(left: 5,top: 5, right: 5),
                              child: Image.asset("image/"+avgplane,height: 20,width: 20,),
                            ),

                          ],),
                      ),




                    ),



                  ],),

                  SizedBox(height: 10,),

                  Row(children: [

                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(left: 30,),
                        child: Text("Poor",
                            style: TextStyle(color: Colors.black,
                              fontSize: 18,
                              /*fontFamily: 'BebesNeue',
                              fontWeight: FontWeight.w700,*/)),
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            getPoor();
                            isFeedBackClick=true;
                            feebackvalue="1";
                            print(feebackvalue);
                          });
                        },
                        child: Row(
                          children: [

                            Container(
                              //  margin: EdgeInsets.only(left: 5,top: 5, right: 5),
                              child: Image.asset("image/emojipoor.png",height: 40,width: 40,),
                            ),
                            SizedBox(width: 12,),
                            Container(
                              //  margin: EdgeInsets.only(left: 5,top: 5, right: 5),
                              child: Image.asset("image/"+poorplane,height: 20,width: 20,),
                            ),

                          ],),
                      ),

                    ),



                  ],),

                  SizedBox(height: 30,),

                  InkWell(
                    onTap: (){
                      if (isFeedBackClick) {
                      //  getFeedIte();
                       /* Fluttertoast.showToast(
                            msg: "Submitted ",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 12.0
                        );*/
                        Navigator.of(context).pop();
                      } else {
                        Fluttertoast.showToast(
                            msg: "Please First Select One FeedBack!!!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 12.0
                        );  }
                    },
                    child: Container(
                      width: 120,
                      // margin: EdgeInsets.only(left: 5,right: 10),
                      padding: EdgeInsets.only(top: 12, bottom: 12, left: 15,right: 15),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(5),
                        //   border: Border.all(color: Colors.lightBlue,width: 1.0)
                      ),
                      child: Center(
                        child: Text("Submit",
                            style: TextStyle(color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'BebesNeue',
                              fontWeight: FontWeight.w700,)),
                      ),
                    ),
                  ),


                  SizedBox(height: 20,),
                ],),

              ],

              /* content: Text('Are Your Sure You want to Logout?',style: TextStyle(color: Colors.black,fontSize: 14,
                  fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
*/

              /*actions: [
                FlatButton(
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.of(context).pop();
                //    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {return Login();}));
                    print("is pressed");
                  },
                  child: Container(
                    width: 60,
                    height:30,
                    child: Center(child: Text("Yes",style: TextStyle(color: Colors.white, fontSize: 14,
                        fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,)),
                    decoration: BoxDecoration(color: Colors.blue,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),

                FlatButton(
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 60,
                    height:30,
                    child: Center(child: Text("No",style: TextStyle(color: Colors.white, fontSize: 14,
                        fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,)),
                    decoration: BoxDecoration(color: Colors.blue,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],*/
            ),
          );
        });
  }

}
