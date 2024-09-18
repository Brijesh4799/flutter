import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:micetravel/Providers/pickerslanuage.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translator/translator.dart';
import '../Models/itemodel.dart';
import '../Utils/Apis.dart';


class ItineraryLatSL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: ItineraryLat(),
    );
  }
}

class ItineraryLat extends StatefulWidget {

  @override
  State createState() => MyItineraryLat();
}

class MyItineraryLat extends State<ItineraryLat> {

/* String daynumber="";
 String date="";

 String ServiceTypeId="";*/

  GoogleTranslator googleTranslator = GoogleTranslator();
  late Translation translation1,translation2,translation3,translation4,translation5,translation6,translationcategory,translation7,translation8;
  List<String> _languagesCodetts = ['Select Language','Arabic','Bengali','Chinese','English','Frence','German','Hindi','Japanes'];

  String? mylist="";
  String refID="";

  String? voucherUrl="1";

  late SharedPreferences prefRefid,preflist;

  late ScrollController _controller;

  List<DaysIte>? daysdatamodel=[];
  List<ServicesIte>? servicedatamodel=[];

  late DaysIte itemslists;

  late ServicesIte servicelists;

  int pos=0;
  bool loadCircle = false;

  String serviceTypeId="Accomodation";
  String  serviceTypeName="Hotel";
  String  serviceCategory="5";
  String  pickuptime="12:00:00 AM";
  String  droptime="12:00:00 PM";
  String  serviceDetail="12:00:00 AM";
  String  serviceDetail01="12:00:00 PM";

  String  pickuptimeS="Pickup Time :";
  String  droptimeS="Drop Time :";

  String itemDatelat="Accomodation";
  String serviceTypeIdlat="Accomodation";
  String  serviceTypeNamelat="Hotel";
  String  serviceCategorylat="5";
  String  pickuptimelat="12:00:00 AM";
  String  droptimelat="12:00:00 PM";
  String  serviceDetaillat="12:00:00 AM";
  String  serviceDetail01lat="12:00:00 PM";
  String  feedback="";

  String langcode="en";



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

  bool online = true;
  bool offline = false;

  getOnline(){
    setState(() {
      online  = true;
      offline = false;
      print("Online Now");
    });
  }

  getOffline(){
    setState(() {
      online  = false;
      offline = true;
      print("Offlie Now");
    });
  }

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
    prefRefid = await SharedPreferences.getInstance();
    setState(() {
      refID = prefRefid.getString("refid")!;
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
    _controller = ScrollController();
    _controller.addListener(_scrollListener);

    getExcellent();
    isFeedBackClick=true;
    feebackvalue="5";
    print(feebackvalue);
    getOnline();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    print("Build Function is Called");
    return Container(

      child:ModalProgressHUD(
        inAsyncCall: loadCircle,
        progressIndicator: const CircularProgressIndicator(color: Colors.purple,strokeWidth: 5),
        child: Scaffold(
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
                ),
*/

                  Container(
                    //  margin: EdgeInsets.only(left: 15),
                    child: Text("Itinerary",
                        style: TextStyle(color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'BebesNeue',
                            fontWeight: FontWeight.w700)),
                  )

                ],

              ),
            ),
          ),

          body:  Column(children: [

            Visibility(
              visible: online,
              child: Align(
                  alignment: Alignment.centerRight,
                  child:InkWell(
                    onTap: (){
                      setState(() {
                        getOffline();
                      });


                    },
                    child: Container(
                      padding: EdgeInsets.only(left:10,right: 10,top: 7.5,bottom: 7.5),
                      margin: EdgeInsets.only(top: 15,right: 20,bottom: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blueAccent,


                      ),
                      child: Text("Select Languages",
                          style: TextStyle(color: Colors.white,fontSize: 13,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                    ),
                  )
              ),
            ),

            // Offline data

            Visibility(

                visible: offline,
                child: Expanded(
                  child: ChangeNotifierProvider<PickersLanguageProvider>(

                      create: (context) => PickersLanguageProvider(),

                      child: Consumer<PickersLanguageProvider>(
                          builder: (context, provider, child){

                            return Container(

                              child: Column(children: [

                                Container(
                                  //  padding: EdgeInsets.only(top: 20,bottom: 20,left: 20,right: 20),
                                  width: MediaQuery.of(context).size.width,
                                  height: 35.0,
                                  margin: EdgeInsets.only(left: 20,right: 20,bottom: 15,top: 15),
                                  child:DropdownButtonHideUnderline(

                                    child: ButtonTheme(
                                      focusColor: Colors.white,

                                      child: DropdownButton(
                                        dropdownColor: Colors.white,
                                        style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                                        // dropdownColor: Colors.grey,
                                        focusColor: Colors.black,
                                        icon: Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.black,
                                        ),
                                        items: _languagesCodetts.map((String itemnames) {
                                          return DropdownMenuItem<String>(

                                              value: itemnames,
                                              child: Text(itemnames,textAlign: TextAlign.center,style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700))
                                          );
                                        }).toList(),

                                        onChanged: (String? value) async {

                                          try{
                                            PickersLanguageProvider.languageName=value!;

                                            provider.selectLanguage();
                                            langcode=provider.code;

                                            provider.traslateIte(itemslists, pos);

                                            late Translation dateTranslate;


                                            for(DaysIte item in daysdatamodel!) {
                                              setState(() {
                                                loadCircle = true;
                                              });
                                              //  print("translating 1");
                                              dateTranslate = await googleTranslator.translate(item.date!, to: langcode);

                                              for (ServicesIte service in item.services!) {

                                                translation1 = await googleTranslator.translate(service.serviceTypeId!, to: langcode);
                                                translation2 = await googleTranslator.translate(service.serviceTypeName!, to: langcode);
                                                translation3 = await googleTranslator.translate(service.serviceDetails!, to: langcode);
                                                translation4 = await googleTranslator.translate(service.serviceDetails01!, to: langcode);
                                                translation5 = await googleTranslator.translate(service.startTime!, to: langcode);
                                                translation6 = await googleTranslator.translate(service.endTime!, to: langcode);
                                                translation7 = await googleTranslator.translate(pickuptimeS, to: langcode);
                                                translation8 = await googleTranslator.translate(droptimeS, to: langcode);
                                             //   translationcategory = await googleTranslator.translate(service.serviceCategory!, to: langcode);

                                                service.serviceTypeId = translation1.text;
                                                service.serviceTypeName = translation2.text;
                                                service.serviceDetails = translation3.text;
                                                service.serviceDetails01 = translation4.text;
                                                service.startTime = translation5.text;
                                                service.endTime = translation6.text;
                                                pickuptimeS = translation7.text;
                                                droptimeS = translation8.text;
                                            //    service.serviceCategory = translationcategory.text;
                                                print("Translated Id: " + service.serviceTypeId!);
                                                print("Translated Name : " + service.serviceTypeName!);
                                                print("Translated Details : " + service.serviceDetails!);
                                                print("Translated Details01 : " + service.serviceDetails01!);
                                                print("Translated Category : " + service.serviceCategory!);
                                              }
                                            }

                                            setState(() {
                                              loadCircle = false;
                                            });
                                            print("transalted Now");

                                            Fluttertoast.showToast(
                                                msg: "Translated Now",
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 4,
                                                backgroundColor: Colors.black,
                                                textColor: Colors.white,
                                                fontSize: 14.0
                                            );

                                            // loadCircle=false;
                                            if(itemslists!=""){

                                              itemDatelat = dateTranslate.text;
                                              serviceTypeId = translation1.text;
                                              serviceTypeName = translation2.text;
                                              serviceCategory = translationcategory.text;
                                              serviceDetaillat = translation3.text;
                                              serviceDetail01lat = translation4.text;
                                              pickuptimelat = translation5.text;
                                              droptimelat = translation6.text;
                                              pickuptimeS = translation7.text;
                                              droptimeS = translation8.text;

                                              print("After Translated : " + serviceTypeId);
                                              print("After Translated : " + serviceTypeName);
                                              print("After Translated : " + serviceDetail);
                                              print("After Translated : " + serviceDetail01);
                                              print("Translated Category: " + serviceCategory);
                                              provider.notifyListeners();

                                            }else{
                                              print("No data Now");
                                            }

                                          }

                                          catch(e){
                                            print("Can't Translated");
                                            setState(() {
                                              loadCircle = false;
                                            });
                                          }

                                                                                  },
                                        value: PickersLanguageProvider.languageName,
                                      ),


                                    ),
                                  ),

                                  /* decoration: BoxDecoration(

                                                    borderRadius: BorderRadius.circular(5),
                                                    color: Colors.white,

                                                  ),*/
                                ),


                                // OffLine

                                Container(
                                  child: Expanded(
                                    child:ListView.builder(
                                        itemCount: daysdatamodel!.length,
                                        itemBuilder: (context,index){
                                          itemslists = daysdatamodel![index];

                                          return Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage("image/travbg.jpg"),
                                                fit: BoxFit.cover,
                                              ),),
                                            child: Column(
                                                children: [

                                                  Container(
                                                    width: MediaQuery.of(context).size.width,
                                                    color: Colors.lightBlueAccent,
                                                    padding: EdgeInsets.only(top: 5,bottom: 5,left: 5),
                                                    child: Text(itemslists.dayNumber!+" : "+itemDatelat,
                                                        style: TextStyle(color: Colors.black,
                                                            fontSize: 12,
                                                            fontFamily: 'BebesNeue',
                                                            fontWeight: FontWeight.w700)),

                                                  ),

                                                  Container(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          child: ListView.builder(
                                                              controller: _controller,
                                                              itemCount:itemslists.services!.length,
                                                              physics: ClampingScrollPhysics(),
                                                              shrinkWrap: true,
                                                              itemBuilder: (context,index1) {
                                                                pos=index1;
                                                                servicelists = itemslists.services![pos];





                                                                print("feedback from itenrary is : ${servicelists.feedback!}");
                                                                if(servicelists.feedback=="0"){
                                                                  visibilityFeedblue = true;
                                                                  visibilityFeedwhite = false;
                                                                  print("Feed Blue");
                                                                }else{
                                                                  visibilityFeedblue = false;
                                                                  visibilityFeedwhite = true;
                                                                  print("Feed white");
                                                                }

                                                                serviceTypeId= servicelists.serviceTypeId!;
                                                                serviceTypeName=servicelists.serviceTypeName!;
                                                                serviceCategory=servicelists.serviceCategory!;
                                                                pickuptime=servicelists.startTime!;
                                                                droptime=servicelists.endTime!;
                                                                serviceDetail=servicelists.serviceDetails!;
                                                                serviceDetail01=servicelists.serviceDetails01!;
                                                              
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

                                                                if(serviceTypeId=="Accommodation" && serviceTypeId=="إقامة"){
                                                                  accomodationimg="hoteliteicon.png";
                                                                  myimgcolor= Color(0xffffa000);
                                                                  visibilityStar=true;
                                                                  visibilitypickup=false;
                                                                  visibilitydrop=false;
                                                                  visibilityservicdetail=true;
                                                                  visibilityservicedetail01=true;
                                                                }
                                                                else if(serviceTypeId=="Transfer" || serviceTypeId=="Ändern"
                                                                    || serviceTypeId=="変化" || serviceTypeId=="Ändern"
                                                                    || serviceTypeId=="ändern" || serviceTypeId=="移行"
                                                                    ||serviceTypeId=="transferir" || serviceTypeId=="تحويل"
                                                                    ||serviceTypeId=="রূপান্তর" || serviceTypeId=="转型"
                                                                    ||serviceTypeId=="Transformer" || serviceTypeId=="Transformator"
                                                                    ||serviceTypeId=="स्थानांतरण" || serviceTypeId=="Transformator"){
                                                                  accomodationimg="transferiteicon.png";
                                                                  myimgcolor= Color(0xffef5350);
                                                                  visibilityStar=false;
                                                                  visibilitypickup=true;
                                                                  visibilitydrop=true;
                                                                  visibilityservicdetail=true;
                                                                  visibilityservicedetail01=false;
                                                                }

                                                                else if(serviceTypeId=="Transportation" || serviceTypeId=="संचार"
                                                                    || serviceTypeId=="مرور" || serviceTypeId=="যোগাযোগ"
                                                                    || serviceTypeId=="यातायात" || serviceTypeId=="مجال الاتصالات"
                                                                    ||serviceTypeId=="沟通"||serviceTypeId=="communiquer"
                                                                    ||serviceTypeId=="伝える"||serviceTypeId=="informieren"
                                                                    ||serviceTypeId=="交通機関"||serviceTypeId=="Instalaciones de transporte"
                                                                    ||serviceTypeId=="مواصلات"||serviceTypeId=="kommunizieren"){
                                                                  accomodationimg="transferiteicon.png";
                                                                  myimgcolor= Color(0xffef5350);
                                                                  visibilityStar=false;
                                                                  visibilitypickup=true;
                                                                  visibilitydrop=true;
                                                                  visibilityservicdetail=true;
                                                                  visibilityservicedetail01=false;
                                                                }

                                                                else if(serviceTypeId=="Entrance" || serviceTypeId=="प्रवेश"
                                                                    || serviceTypeId=="প্রবেশদ্বার" || serviceTypeId=="入口"
                                                                    || serviceTypeId=="Entrée" || serviceTypeId=="Eingang"
                                                                    || serviceTypeId=="エントリ" || serviceTypeId=="مدخل"
                                                                    || serviceTypeId=="Eintrag" || serviceTypeId=="entrée"
                                                                    || serviceTypeId=="Eintrag" || serviceTypeId=="entrance"
                                                                    || serviceTypeId=="প্রবেশ" || serviceTypeId=="الدخول"
                                                                    || serviceTypeId=="অ্যাক্সেস" || serviceTypeId=="使用权"
                                                                    || serviceTypeId=="Droit d'utiliser" || serviceTypeId=="Recht zu verwenden"
                                                                    || serviceTypeId=="उपयोग करने का अधिकार" || serviceTypeId=="使用権"
                                                                     || serviceTypeId=="使用権"){
                                                                  accomodationimg="entraneiteicon.png";
                                                                  myimgcolor= Color(0xff7cb342);
                                                                  visibilityStar=false;
                                                                  visibilitypickup=true;
                                                                  visibilitydrop=true;
                                                                 // visibilityservicdetail=false;
                                                                 // visibilityservicedetail01=false;
                                                                }
                                                                else if(serviceTypeId=="Activity" || serviceTypeId=="نشاط"
                                                                || serviceTypeId=="فعل" || serviceTypeId=="একটি আইন"
                                                                || serviceTypeId=="一条法律" || serviceTypeId=="Une loi"
                                                                || serviceTypeId=="一条法律" || serviceTypeId=="Une loi"
                                                                || serviceTypeId=="ক্রিয়াকলাপ" || serviceTypeId=="行动"
                                                                || serviceTypeId=="action" || serviceTypeId=="Aktion"
                                                                || serviceTypeId=="アクション" || serviceTypeId=="कार्य"
                                                                || serviceTypeId=="Activité" || serviceTypeId=="Aktivität"
                                                                || serviceTypeId=="アクティビティ" || serviceTypeId=="गतिविधि"
                                                                || serviceTypeId=="কর্ম" || serviceTypeId=="activity"
                                                                || serviceTypeId=="Ein Gesetz" || serviceTypeId=="एक कानून"
                                                                    || serviceTypeId=="法律"){
                                                                  accomodationimg="activityiteicon.png";
                                                                  myimgcolor= Color(0xff3f51bf);
                                                                  visibilityStar=false;
                                                                }
                                                                else if(serviceTypeId=="Guide" || serviceTypeId=="مرشد"
                                                                ||serviceTypeId=="গাইড" || serviceTypeId=="指导"
                                                                ||serviceTypeId=="consultant" || serviceTypeId=="Führung"
                                                                ||serviceTypeId=="ガイド" || serviceTypeId=="मार्गदर्शक"
                                                                ||serviceTypeId=="guide"||serviceTypeId=="Führung"
                                                                ||serviceTypeId=="ガイド"||serviceTypeId=="guide"){
                                                                  accomodationimg="guideicon.png";
                                                                  myimgcolor= Color(0xffffe082);
                                                                  visibilityStar=false;
                                                                  visibilitypickup=false;
                                                                  visibilitydrop=false;
                                                                  visibilityservicdetail=false;
                                                                  visibilityservicedetail01=false;
                                                                }
                                                                else if(serviceTypeId=="Train" || serviceTypeId=="يدرب"
                                                                || serviceTypeId=="ট্রেন" || serviceTypeId=="火车"
                                                                || serviceTypeId=="Former" || serviceTypeId=="訓練"
                                                                || serviceTypeId=="Zug" || serviceTypeId=="रेलगाड़ी"
                                                                || serviceTypeId=="train" || serviceTypeId=="रेलगाड़ी"){
                                                                  accomodationimg="trainicon.png";
                                                                  myimgcolor= Color(0xffef5350);
                                                                  visibilityStar=false;
                                                                  visibilitypickup=true;
                                                                  visibilitydrop=true;
                                                                  visibilityservicdetail=true;
                                                                  visibilityservicedetail01=false;
                                                                }
                                                                else if(serviceTypeId=="Flight" || serviceTypeId=="رحلة جوية"
                                                                || serviceTypeId=="ফ্লাইট" || serviceTypeId=="航班"
                                                                || serviceTypeId=="vol" || serviceTypeId=="Wir"
                                                                || serviceTypeId=="Flug" || serviceTypeId=="वॉल्यूम"
                                                                || serviceTypeId=="フライト" || serviceTypeId=="वॉल्यूम"
                                                                || serviceTypeId=="उड़ान" || serviceTypeId=="Vol"
                                                                || serviceTypeId=="卷" || serviceTypeId=="রোল"
                                                                || serviceTypeId=="لفافة" || serviceTypeId=="flight"){
                                                                  accomodationimg="flightiteicon.png";
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
                                                                  height: 185,
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

                                                                          Container(height: 110, width: 7,
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

                                                                         /* Row( children: [

                                                                              Visibility(
                                                                                  visible: visibilityStar,
                                                                                  child:   Container(
                                                                                    child: Image.asset("image/"+starimg,
                                                                                      height: 10, width: 50,),
                                                                                  ),
                                                                                ),
                                                                          ],

                                                                          ),

                                                                          SizedBox(height: 5,),*/

                                                                          /* Visibility(
                                                                                visible: visibilityservicdetail,
                                                                                child:   Container(
                                                                                  width: 180,
                                                                                  child: Text(serviceDetail,
                                                                                      style: TextStyle(color: Color(0xff90a4ae),
                                                                                          fontSize: 10,
                                                                                          fontFamily: 'BebesNeue',
                                                                                          fontWeight: FontWeight.w700)),
                                                                                ),
                                                                              ),*/

                                                                          Container(
                                                                            width: 180,
                                                                            child: Text(serviceDetail,
                                                                                style: TextStyle(color: Color(0xff90a4ae),
                                                                                    fontSize: 10,
                                                                                    fontFamily: 'BebesNeue',
                                                                                    fontWeight: FontWeight.w700)),
                                                                          ),

                                                                          SizedBox(height: 5,),

                                                                          Container(
                                                                            width: 180,
                                                                            child: Text(serviceDetail01,
                                                                                style: TextStyle(color: Color(0xff90a4ae),
                                                                                    fontSize: 10,
                                                                                    fontFamily: 'BebesNeue',
                                                                                    fontWeight: FontWeight.w700)),
                                                                          ),

                                                                         /* Visibility(
                                                                            visible: visibilityservicedetail01,
                                                                            child:  Container(
                                                                              width: 180,
                                                                              child: Text(serviceDetail01,
                                                                                  style: TextStyle(color: Color(0xff90a4ae),
                                                                                      fontSize: 10,
                                                                                      fontFamily: 'BebesNeue',
                                                                                      fontWeight: FontWeight.w700)),
                                                                            ),
                                                                          ),*/

                                                                          SizedBox(height: 5,),

                                                                          Visibility(
                                                                            visible: visibilitypickup,
                                                                            child: Container(
                                                                              width: 180,
                                                                              child: Row(
                                                                                children: [
                                                                                  Container(
                                                                                    child: Text(pickuptimeS,
                                                                                        textAlign: TextAlign.left,
                                                                                        style: TextStyle(color: Color(0xff90a4ae),
                                                                                            fontSize: 10,
                                                                                            fontFamily: 'BebesNeue',
                                                                                            fontWeight: FontWeight.w700)),
                                                                                  ),

                                                                                  Container(
                                                                                    child: Text(pickuptime,
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
                                                                                    child: Text(droptimeS,
                                                                                        style: TextStyle(color: Color(0xff90a4ae),
                                                                                            fontSize: 10,
                                                                                            fontFamily: 'BebesNeue',
                                                                                            fontWeight: FontWeight.w700)),
                                                                                  ),

                                                                                  Container(
                                                                                    child: Text(droptime,
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



                                                                    /* Expanded(
                                                                                        flex: 2,
                                                                                        child: Column(
                                                                                          children: [

                                                                                            InkWell(
                                                                                              onTap:(){
                                                                                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Evoucherwv(pdf: servicelists.voucherURL!,)));
                                                                                                print("is pressed");
                                                                                              },
                                                                                              child: Container(
                                                                                                width: 60,
                                                                                                margin: EdgeInsets.only(left: 5,top: 42.5),
                                                                                                padding: EdgeInsets.only(top: 3,bottom: 3,),
                                                                                                child: Center(
                                                                                                  child: Text("E-Voucher",
                                                                                                      style: TextStyle(color: Colors.lightBlue,
                                                                                                          fontSize: 10,
                                                                                                          fontFamily: 'BebesNeue',
                                                                                                          fontWeight: FontWeight.w700)),
                                                                                                ),
                                                                                                decoration: BoxDecoration(
                                                                                                    borderRadius: BorderRadius.circular(2.5),
                                                                                                    border: Border.all(color: Colors.lightBlue,width: 2.0)
                                                                                                ),

                                                                                              ),
                                                                                            ),

                                                                                            SizedBox(height: 30,),

                                                                                            Visibility(
                                                                                              visible: visibilityFeedblue,
                                                                                              child: InkWell(
                                                                                                onTap:(){
                                                                                                  feedbackDialog(context);
                                                                                                  print("is pressed");
                                                                                                },
                                                                                                child: Container(
                                                                                                  width: 60,
                                                                                                  margin: EdgeInsets.only(left: 5),
                                                                                                  padding: EdgeInsets.only(top: 3,bottom: 3,),
                                                                                                  child: Center(
                                                                                                    child: Text("FeedBack",
                                                                                                        textAlign: TextAlign.left,
                                                                                                        style: TextStyle(color: Colors.white,
                                                                                                            fontSize: 10,
                                                                                                            fontFamily: 'BebesNeue',
                                                                                                            fontWeight: FontWeight.w700)),
                                                                                                  ),
                                                                                                  decoration: BoxDecoration(
                                                                                                      color: Colors.lightBlue,
                                                                                                      borderRadius: BorderRadius.circular(2.5),
                                                                                                      border: Border.all(color: Colors.lightBlue,width: 2.0)
                                                                                                  ),

                                                                                                ),
                                                                                              ),
                                                                                            ),

                                                                                            Visibility(
                                                                                              visible: visibilityFeedwhite,
                                                                                              child: InkWell(
                                                                                                onTap: (){
                                                                                                  Fluttertoast.showToast(
                                                                                                    msg: "FeedBack Already Submited",
                                                                                                    toastLength: Toast.LENGTH_LONG,
                                                                                                    gravity: ToastGravity.BOTTOM,
                                                                                                    timeInSecForIosWeb: 6,
                                                                                                    backgroundColor: Colors.black,
                                                                                                    textColor: Colors.white,
                                                                                                    fontSize: 12.0,
                                                                                                  );
                                                                                                },
                                                                                                child: Container(
                                                                                                  width: 60,
                                                                                                  margin: EdgeInsets.only(left: 5),
                                                                                                  padding: EdgeInsets.only(top: 3,bottom: 3,),
                                                                                                  child: Center(
                                                                                                    child: Text("FeedBack",
                                                                                                        textAlign: TextAlign.left,
                                                                                                        style: TextStyle(color: Colors.lightBlue,
                                                                                                            fontSize: 10,
                                                                                                            fontFamily: 'BebesNeue',
                                                                                                            fontWeight: FontWeight.w700)),
                                                                                                  ),
                                                                                                  decoration: BoxDecoration(
                                                                                                      color: Colors.white,
                                                                                                      borderRadius: BorderRadius.circular(2.5),
                                                                                                      border: Border.all(color: Colors.lightBlue,width: 2.0)
                                                                                                  ),

                                                                                                ),
                                                                                              ),
                                                                                            )

                                                                                          ],
                                                                                        ),
                                                                                      )*/



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
                                ),

                              ],),
                            );
                          }
                      )


                  ),
                ),
            ),



            // online

            Visibility(
              visible: online,
              child: FutureBuilder(
                  future: getDayIte(),
                  builder:(context, snapshot) {
                    print("Connection status from Itenrary : " + connectstatus);
                    print("Snapshot value is : $snapshot");

                    if(snapshot.hasData) {
                      daysdatamodel= snapshot.data;
                      return Container(
                        child: Expanded(
                          child:ListView.builder(
                              itemCount: daysdatamodel!.length,
                              itemBuilder: (context,index){
                                itemslists = daysdatamodel![index];

                                itemDatelat=itemslists.date!;

                                return Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("image/travbg.jpg"),
                                      fit: BoxFit.cover,
                                    ),),
                                  child: Column(
                                      children: [

                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          color: Colors.lightBlueAccent,
                                          padding: EdgeInsets.only(top: 5,bottom: 5,left: 5),
                                          child: Text(itemslists.dayNumber!+" : "+itemslists.date!,
                                              style: TextStyle(color: Colors.black,
                                                  fontSize: 12,
                                                  fontFamily: 'BebesNeue',
                                                  fontWeight: FontWeight.w700)),

                                        ),

                                        Container(
                                          child: Column(
                                            children: [
                                              Container(
                                                child: ListView.builder(
                                                    controller: _controller,
                                                    itemCount:itemslists.services!.length,
                                                    physics: ClampingScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemBuilder: (context,index1) {
                                                      servicelists = itemslists.services![index1];

                                                      print("feedback from itenrary is : ${servicelists.feedback!}");
                                                      if(servicelists.feedback=="0"){
                                                        visibilityFeedblue = true;
                                                        visibilityFeedwhite = false;
                                                        print("Feed Blue");
                                                      }else{
                                                        visibilityFeedblue = false;
                                                        visibilityFeedwhite = true;
                                                        print("Feed white");
                                                      }

                                                      serviceTypeId=servicelists.serviceTypeId!;
                                                      serviceTypeName=servicelists.serviceTypeName!;
                                                      serviceCategory=servicelists.serviceCategory!;
                                                      pickuptime=servicelists.startTime!;
                                                      droptime=servicelists.endTime!;
                                                      serviceDetail=servicelists.serviceDetails!;
                                                      serviceDetail01=servicelists.serviceDetails01!;
                                                    
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
                                                      else if(serviceTypeId=="Transportation"){
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
                                                        visibilityservicdetail=true;
                                                        visibilityservicedetail01=true;
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
                                                        accomodationimg="flightiteicon.png";
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
                                                        visibilitypickup=true;
                                                        visibilitydrop=true;
                                                        visibilityservicdetail=true;
                                                        visibilityservicedetail01=true;
                                                      }

                                                      /*   int mypos=index1;

                                                                                 provider.selectDays(itemslists,mypos,serviceTypeIdlat,serviceTypeNamelat);

                                                                              serviceTypeIdlat=itemslists.services![mypos].serviceTypeId.toString();
                                                                              serviceTypeNamelat=itemslists.services![mypos].serviceTypeName.toString();

                                                                              provider.traslateIte(itemslists,mypos,serviceTypeIdlat,serviceTypeNamelat);

                                                                              print("In Itenrary ServicetypeId is : " +serviceTypeIdlat);
                                                                              print("In Itenrary ServicetypeName is : " +serviceTypeNamelat);*/


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

                                                             //   SizedBox(height: 5,),

                                                               /* Row( children: [

                                                                  Visibility(
                                                                    visible: visibilityStar,
                                                                    child:   Container(
                                                                      child: Image.asset("image/"+starimg,
                                                                        height: 10, width: 50,),
                                                                    ),
                                                                  ),
                                                                ],

                                                                ),*/

                                                                SizedBox(height: 5,),

                                                               /* Visibility(
                                                                  visible: visibilityservicdetail,
                                                                  child:   Container(
                                                                    width: 180,
                                                                    child: Text(serviceDetail,
                                                                        style: TextStyle(color: Color(0xff90a4ae),
                                                                            fontSize: 10,
                                                                            fontFamily: 'BebesNeue',
                                                                            fontWeight: FontWeight.w700)),
                                                                  ),
                                                                ),*/

                                                                Container(
                                                                  width: 180,
                                                                  child: Text(serviceDetail,
                                                                      style: TextStyle(color: Color(0xff90a4ae),
                                                                          fontSize: 10,
                                                                          fontFamily: 'BebesNeue',
                                                                          fontWeight: FontWeight.w700)),
                                                                ),

                                                                SizedBox(height: 5,),

                                                                Container(
                                                                  width: 180,
                                                                  child: Text(serviceDetail01,
                                                                      style: TextStyle(color: Color(0xff90a4ae),
                                                                          fontSize: 10,
                                                                          fontFamily: 'BebesNeue',
                                                                          fontWeight: FontWeight.w700)),
                                                                ),

                                                               /* Visibility(
                                                                  visible: visibilityservicedetail01,
                                                                  child:  Container(
                                                                    width: 180,
                                                                    child: Text(serviceDetail01,
                                                                        style: TextStyle(color: Color(0xff90a4ae),
                                                                            fontSize: 10,
                                                                            fontFamily: 'BebesNeue',
                                                                            fontWeight: FontWeight.w700)),
                                                                  ),
                                                                ),*/

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
                                                                          child: Text(servicelists.startTime!,
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
                                                                          child: Text(servicelists.endTime!,
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



                                                          /* Expanded(
                                                                            flex: 2,
                                                                            child: Column(
                                                                              children: [

                                                                                InkWell(
                                                                                  onTap:(){
                                                                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Evoucherwv(pdf: servicelists.voucherURL!,)));
                                                                                    print("is pressed");
                                                                                  },
                                                                                  child: Container(
                                                                                    width: 60,
                                                                                    margin: EdgeInsets.only(left: 5,top: 42.5),
                                                                                    padding: EdgeInsets.only(top: 3,bottom: 3,),
                                                                                    child: Center(
                                                                                      child: Text("E-Voucher",
                                                                                          style: TextStyle(color: Colors.lightBlue,
                                                                                              fontSize: 10,
                                                                                              fontFamily: 'BebesNeue',
                                                                                              fontWeight: FontWeight.w700)),
                                                                                    ),
                                                                                    decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.circular(2.5),
                                                                                        border: Border.all(color: Colors.lightBlue,width: 2.0)
                                                                                    ),

                                                                                  ),
                                                                                ),

                                                                                SizedBox(height: 30,),

                                                                                Visibility(
                                                                                  visible: visibilityFeedblue,
                                                                                  child: InkWell(
                                                                                    onTap:(){
                                                                                      feedbackDialog(context);
                                                                                      print("is pressed");
                                                                                    },
                                                                                    child: Container(
                                                                                      width: 60,
                                                                                      margin: EdgeInsets.only(left: 5),
                                                                                      padding: EdgeInsets.only(top: 3,bottom: 3,),
                                                                                      child: Center(
                                                                                        child: Text("FeedBack",
                                                                                            textAlign: TextAlign.left,
                                                                                            style: TextStyle(color: Colors.white,
                                                                                                fontSize: 10,
                                                                                                fontFamily: 'BebesNeue',
                                                                                                fontWeight: FontWeight.w700)),
                                                                                      ),
                                                                                      decoration: BoxDecoration(
                                                                                          color: Colors.lightBlue,
                                                                                          borderRadius: BorderRadius.circular(2.5),
                                                                                          border: Border.all(color: Colors.lightBlue,width: 2.0)
                                                                                      ),

                                                                                    ),
                                                                                  ),
                                                                                ),

                                                                                Visibility(
                                                                                  visible: visibilityFeedwhite,
                                                                                  child: InkWell(
                                                                                    onTap: (){
                                                                                      Fluttertoast.showToast(
                                                                                        msg: "FeedBack Already Submited",
                                                                                        toastLength: Toast.LENGTH_LONG,
                                                                                        gravity: ToastGravity.BOTTOM,
                                                                                        timeInSecForIosWeb: 6,
                                                                                        backgroundColor: Colors.black,
                                                                                        textColor: Colors.white,
                                                                                        fontSize: 12.0,
                                                                                      );
                                                                                    },
                                                                                    child: Container(
                                                                                      width: 60,
                                                                                      margin: EdgeInsets.only(left: 5),
                                                                                      padding: EdgeInsets.only(top: 3,bottom: 3,),
                                                                                      child: Center(
                                                                                        child: Text("FeedBack",
                                                                                            textAlign: TextAlign.left,
                                                                                            style: TextStyle(color: Colors.lightBlue,
                                                                                                fontSize: 10,
                                                                                                fontFamily: 'BebesNeue',
                                                                                                fontWeight: FontWeight.w700)),
                                                                                      ),
                                                                                      decoration: BoxDecoration(
                                                                                          color: Colors.white,
                                                                                          borderRadius: BorderRadius.circular(2.5),
                                                                                          border: Border.all(color: Colors.lightBlue,width: 2.0)
                                                                                      ),

                                                                                    ),
                                                                                  ),
                                                                                )

                                                                              ],
                                                                            ),
                                                                          )*/



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
                      );


                      /* if (connectstatus == "Wifi" || connectstatus == "MobileData") {
                                        print("daymodel value is : $daysdatamodel");



                                      }
                                      else {
                                        return  Container();
                                      }*/
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


          ]),


        ),
      ),

    );

  }

  Future <List<DaysIte>> getDayIte() async {

    List<DaysIte> daysdata=[];

    try{

    //  String newurl = TravApis.ITENERARYFLUTTER;

      String newurl = TravApis.ITENERARYFLUTTER + "Refid="+refID;

    //  String newurl = "https://travcrm.in/mice2.2_dev/Api/App/CLIENT/json_iteneraryquote_flutter_api.php?Refid=R20230416";
   //   String newurl = "https://travcrm.in/travcrm-dev_2.2/Api/App/CLIENT/json_iteneraryquote_flutter_api.php?Refid=R20230518";

     //   String newurl = "https://travcrm.in/mice2.2_dev/Api/App/CLIENT/json_iteneraryquote_flutter_api.php?Refid=R20230414";

      print("Itinerary Url is : "+newurl);

      var url = Uri.parse(newurl);

      print("Loading from api");
      http.Response res = await http.get(url);

      print("Itenrary api response is : "+res.body);

      var datas = jsonDecode(res.body)['Days'] as List;

      daysdata = datas.map((data) => DaysIte.fromJson(data)).toList();

      // mylist = jsonEncode(daysdata);
      preflist = await SharedPreferences.getInstance();
      preflist.setString("list",jsonEncode(datas));

      print("the send value of lists is : ${jsonEncode(datas)}");
      //  List datas= jsonDecode(res.body);

      return daysdata;
    }
    catch(SocketException){
      /* print("No Internet");

      getMyIte();

      print("the received of lists is : $mylist");

      var newdatas = jsonDecode(mylist!) as List;

      print("New DAta are :  $newdatas");

      daysdata = newdatas.map((data) => DaysIte.fromJson(data)).toList();


      print("the cache of lists is : $daysdata");*/

      return daysdata;
    }

  }


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
                     //   getFeedIte();
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


  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {//you can do anything here
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {//you can do anything here
      });
    }
  }

}



