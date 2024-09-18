import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:micetravel/Dart/chat.dart';
import 'package:micetravel/Dart/qrcode.dart';
import 'package:micetravel/Dart/tmitinerary.dart';
import 'package:micetravel/Dart/tourspecialist.dart';
import 'package:micetravel/Dart/translatest.dart';
import 'package:micetravel/Dart/utilities.dart';
import 'package:micetravel/Models/profilemodel.dart';
import 'package:micetravel/Models/tourassistancemodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/Apis.dart';
import '../main.dart';
import 'detailitnraryvoucher.dart';
import 'login.dart';
import 'myprofile.dart';
import 'package:http/http.dart' as http;


class HomeSL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Home(),
    );
  }
}

class Home extends StatefulWidget {

  @override
  State createState() => MyHome();
}

class MyHome extends State<Home> {

  late SharedPreferences preflog_in_out, prefprofile,prefId,preftype,prefRefid,prefquotationId,prefguestid,prefguestmobile,p_mgrmobile,
      preftmid,preftmphone,prefphno,prefagenda ;

  String fname="";
  String lname="";
  String refID="";
  String ID="";
  String Type="";
  String Guestid="";
  String Guestmobile="";
  String Guestname="";
  String mgrmobileno="";


  String m_tmphone="";
  String m_tmid="";

  String seen="";
  String mobno="";

  GlobalKey<ScaffoldState> _drawerkey= GlobalKey<ScaffoldState>();

  bool isSeenShow=false;

  Timer? timer,timer2;

  @override
  void initState() {

    getMyLoginValue();
    getPrefProfile();
    getMyRefId();
    getMyId();

    timer2 = Timer.periodic(Duration(seconds: 1),(Timer t) async {
      print("repeat");

      setState(() {});
      getProfile();
      timer2?.cancel();

      // getSeen();
      // timer2?.cancel();
    });
    super.initState();
  }

  getMyRefId() async {
    prefphno= await SharedPreferences.getInstance();
    prefRefid = await SharedPreferences.getInstance();
    prefquotationId = await SharedPreferences.getInstance();
    preftype = await SharedPreferences.getInstance();
    prefId = await SharedPreferences.getInstance();
    prefguestid = await SharedPreferences.getInstance();
    prefguestmobile = await SharedPreferences.getInstance();
    prefprofile = await SharedPreferences.getInstance();
    p_mgrmobile = await SharedPreferences.getInstance();
    preftmid = await SharedPreferences.getInstance();
    preftmphone = await SharedPreferences.getInstance();
    prefagenda= await SharedPreferences.getInstance();

    setState(() {
      mobno = prefphno.getString("phone")!;
      refID = prefRefid.getString("refid")!;
      prefquotationId.getString("quotationId")!;
      Type=preftype.getString("type")!;
      ID = prefId.getString("id")!;

      getTourAssitant();

     // getAgenda();
      getProfile();
    });
  }

  getMyId() async {
    prefId = await SharedPreferences.getInstance();

    setState(() {
      ID = prefId.getString("id")!;
    });
  }


  getPrefProfile() async {
    prefprofile = await SharedPreferences.getInstance();

    setState(() {
      fname =  prefprofile.getString("fname")!;
      lname =  prefprofile.getString("lname")!;
      print("Shared Recieved firstname is : $fname");
      print("Shared Recieved lastname is : $lname");
    });
  }

  getMyLoginValue() async {
    preflog_in_out = await SharedPreferences.getInstance();
    preflog_in_out.setBool("ID",true);
  }

  createDialog(BuildContext context){
    return showDialog(
        context: context,
        builder: (context){
          return  AlertDialog(

            content: Text('Are Your Sure You want to Logout?',style: TextStyle(color: Colors.black,fontSize: 14,
                fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),

            actions: [

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  InkWell(
                    onTap: () {
                      preflog_in_out.clear();
                      prefprofile.clear();
                      prefRefid.clear();
                      prefId.clear();
                      prefquotationId.clear();
                      prefguestid.clear();
                      prefguestmobile.clear();
                      p_mgrmobile.clear();
                      preftmid.clear();
                      preftmphone.clear();
                      prefphno.clear();
                      prefagenda.clear();
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {return Login();}));
                      print("is pressed");
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
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

                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      width: 60,
                      height:30,
                      child: Center(child: Text("No",style: TextStyle(color: Colors.white, fontSize: 14,
                          fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),textAlign: TextAlign.center,)),
                      decoration: BoxDecoration(color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),


                ],),

              SizedBox(height: 10,)
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      key: _drawerkey,

      drawer: Drawer(

        backgroundColor: Colors.white,

        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
             //   color: Colors.lightBlueAccent
                image: DecorationImage(
                  image: AssetImage("image/menubg.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  Container(
                 //   margin: EdgeInsets.only(left: 55),
                    child: Image.asset("image/profileiconpf.png", width: 60, height: 60,),
                  ),

                  SizedBox(height: 15,),

                  Container(
                    child: Center(
                      child: Text(fname+" "+lname,
                        style: TextStyle(color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'BebesNeue',
                            fontWeight: FontWeight.w700),),
                    ),
                  ),

                  SizedBox(height: 15,),

                  Container(
                    child: Center(
                      child: Text("Version - 1.0",
                        style: TextStyle(color: Colors.black,
                            fontSize: 13,
                            fontFamily: 'BebesNeue',
                            fontWeight: FontWeight.w700),),
                    ),
                  ),

                  SizedBox(height: 0,),

                 /* InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ProfileUpdate()));
                    },

                      child: Container(
                        width: 50,
                        padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7.5),
                            border: Border.all(color: Colors.blue,width: 2.0)
                        ),

                        child: Center(
                          child: Text("Edit",
                            style: TextStyle(color: Colors.blue,
                                fontSize: 10,
                                fontFamily: 'BebesNeue',
                                fontWeight: FontWeight.w700),),
                        ),

                      ),
                  ),*/

                ],),

            ),

            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,

              child: Column(
                children: [

                  InkWell(
                    onTap:  (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> MyBottomNavigationBar()));
                      print("is pressed");
                    },

                    child: Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Image.asset("image/homemenu.png",height: 22, width: 22,),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 25),
                            child : Text("Home",
                                style: TextStyle(color: Colors.black,fontSize: 13,
                                    fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                          )
                        ],
                      ),
                    ),
                  ),

                 /* Container(
                    margin: EdgeInsets.only(top: 15),
                    child: ListTile(
                      title: Text("Sales",
                          style: TextStyle(color: Colors.white,fontSize: 13,
                              fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                    ),
                  ),*/

                  InkWell(
                    onTap:  (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Profile()));
                      print("is pressed");
                    },

                    child: Container(
                      margin: EdgeInsets.only(top: 25),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Image.asset("image/profilemenucolor.png",height: 22, width: 22,),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 25),
                            child : Text("My Profile",
                                style: TextStyle(color: Colors.black,fontSize: 13,
                                    fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                          )
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap:  (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TMItinerary()));
                      print("is pressed");
                    },

                    child: Container(
                      margin: EdgeInsets.only(top: 25),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Image.asset("image/mytripmenu.png",height: 22, width: 22,),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 25),
                            child : Text("My Trip Itinerary",
                                style: TextStyle(color: Colors.black,fontSize: 13,
                                    fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                          )
                        ],
                      ),
                    ),
                  ),

                 /* InkWell(
                    onTap:  (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Document()));
                      print("is pressed");
                    },

                    child: Container(
                      margin: EdgeInsets.only(top: 25),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Image.asset("image/documentsmenu.png",height: 22, width: 22,),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 25),
                            child : Text("Travel Documents",
                                style: TextStyle(color: Colors.black,fontSize: 13,
                                    fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                          )
                        ],
                      ),
                    ),
                  ),*/

                 /* InkWell(
                    onTap:  (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Agendaw()));
                      print("is pressed");
                    },

                    child: Container(
                      margin: EdgeInsets.only(top: 25),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Image.asset("image/calendarmice.png",height: 22, width: 22,),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 25),
                            child : Text("Agenda",
                                style: TextStyle(color: Colors.black,fontSize: 13,
                                    fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                          )
                        ],
                      ),
                    ),
                  ),*/

                  InkWell(
                    onTap:  (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TranslateST()));
                      print("is pressed");
                    },

                    child: Container(
                      margin: EdgeInsets.only(top: 25),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Image.asset("image/mic.png",height: 22, width: 22,),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 25),
                            child : Text("Translator",
                                style: TextStyle(color: Colors.black,fontSize: 13,
                                    fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                          )
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap:  (){
                      createDialog(context);
                      print("is pressed");
                    },

                    child: Container(
                      margin: EdgeInsets.only(top: 25),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: Image.asset("image/logout.png",height: 22, width: 22,),
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 25),
                            child : Text("Logout",
                                style: TextStyle(color: Colors.black,fontSize: 13,
                                    fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                          )
                        ],
                      ),
                    ),
                  ),

                  Container(
                    // color: Color(0x62ffffff),
                    child: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Row(
                        children: [

                          Expanded(
                            //   flex: 1,
                            child: Container(
                              margin: EdgeInsets.only(left: 85,top: 5),
                              child:Text("Powered by",maxLines: 1,
                                  style: TextStyle(color: Colors.black,fontSize:11,
                                      fontFamily: 'BebesNeue',fontWeight: FontWeight.w700,)),),),

                          Expanded(
                            //  flex: 1,
                              child: Container(
                                margin: EdgeInsets.only( right: 85),
                                child:  Image.asset("image/deboxicon.png",height: 30, width: 35,),
                              ))
                        ],
                      ),
                    ),

                  ),
                ],
              ),
            )
          ],
        ),


      ),

      body: SafeArea(

        child: Container(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(

                child: Row(
                  children: [

                    Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: (){
                            _drawerkey.currentState?.openDrawer();
                            print("drawer is pressed");
                          },
                          child: Container(
                            margin: EdgeInsets.only(top:5),
                            child: Image.asset("image/menumice.png",height: 25, width: 28,),
                          ),
                        )),

                    Expanded(
                        flex: 2,
                        child: Container(
                         // color: Colors.black54,
                          margin: EdgeInsets.only(top: 0,left: 20,right: 20),
                          child: Image.asset("image/itslogo.png",height: 120, width: 150,),
                        )),

                    Expanded(
                        flex: 1,
                        child: Container(
                          height: 30,
                          width: 35,
                        //  margin: EdgeInsets.only( top: 5),
                          child: Text(""),
                        ))
                  ],

                ),
              ),

            //  SizedBox(height: 5,),

              Expanded(
                child: SingleChildScrollView(

                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      margin: EdgeInsets.only(left: 10,right: 10,top: 0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.lightBlueAccent,width: 1,style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          image: AssetImage("image/homebglatmice.jpg"),
                          fit: BoxFit.cover,
                        ),),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                       //   SizedBox(height: 20,),

                          SizedBox(height: 30,),

                          // first Row

                          Row(children: [

                            InkWell(
                              onTap: (){
                                 Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context)=>TMItinerary()));
                               /* Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context)=>ItineraryAll()));*/
                                //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Pdfview()));
                              },
                              child: Container(
                                width: 150,
                                height: 140,
                              //  width: 150,
                              //  height: 115,
                                margin: EdgeInsets.only(left: 10,),
                                child: Image.asset("image/itineraryall.png",),
                              ),
                            ),

                            Spacer(),

                            // Travel

                            InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetatilItineraryw()));
                              },
                              child: Container(
                                width: 150,
                                height: 140,
                                margin: EdgeInsets.only(right: 10),
                                child: Image.asset("image/detailedite.png",),
                              ),
                            ),

                          ],),

                        //  SizedBox(height: 12.5,),

                          SizedBox(height: 30,),

                          // Second Row

                         /* Row(children: [

                            InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Document()));
                              },
                              child: Container(
                                width: 150,
                                height: 115,
                                margin: EdgeInsets.only(left: 10,),
                                child: Image.asset("image/travdoc.png",),
                              ),
                            ),

                            Spacer(),

                            // Agenda

                            InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Agendaw()),).then((value) =>{ getAgenda()});

                                //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Agendaw()));
                              },
                              child: Container(
                                width: 150,
                                height: 115,
                                margin: EdgeInsets.only(right: 10),
                                child: Image.asset("image/agenda.png",),
                              ),
                            ),

                          ],),

                          SizedBox(height:12.5,),*/

                          Row(children: [

                            // tour assitant

                            InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TourSpl()));
                              },
                              child: Container(
                                width: 150,
                                height: 140,
                                margin: EdgeInsets.only(left: 10,),
                                child: Image.asset("image/tourassistant.png",),
                              ),
                            ),

                            Spacer(),

                            InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>QRCode()));
                              },
                              child: Container(
                                width: 150,
                                height: 140,
                                margin: EdgeInsets.only(right: 10,),
                                child: Image.asset("image/qrcodeicon.png",),
                              ),
                            )

                          ],),

                          SizedBox(height: 32,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                               // Travel Utilites

                            InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Utilies()));
                              },
                              child: Container(
                                width: 150,
                                height: 140,
                                margin: EdgeInsets.only(left: 10),
                                child: Image.asset("image/travuti.png",),
                              ),
                            ),

                              Spacer(),
                              // chat

                              InkWell(
                                onTap: () async {

                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChatST()));
                                },
                                child: Container(
                                  width: 150,
                                  height: 140,
                                    margin: EdgeInsets.only(right: 10,),
                                  child: Image.asset("image/chaticonr.png",),
                                ),
                              ),
                          ],),


                        //  SizedBox(height: 30,),

                       //   SizedBox(height: 30,),
                        ],),
                    ),
                  ),
                ),
              )
            ],
          ),
        )

      ),

    );
  }

  Future<List<ResultsTour>> getTourAssitant() async {
    String newurl = TravApis.TOURASSTANT + "RefId="+refID;

    print("Tour Assistant Url is : " + newurl.toString());

    var url = Uri.parse(newurl);

    http.Response res = await http.get(url);
    //  List datas= jsonDecode(res.body);

    print("Tour Assistant response is : " + res.body);

    var datas = jsonDecode(res.body)['results'] as List;

    List<ResultsTour> tourdata = datas.map((data) =>
        ResultsTour.fromJson(data)).toList();
    m_tmid=tourdata[0].id!;
    m_tmphone=tourdata[0].phoneno!;

    preftmid.setString("tmid", m_tmid);
    print("Tmid from home is : "+m_tmid);

    preftmphone.setString("tmphone", m_tmphone);
    print("Tmphone from home is : "+m_tmphone);

   // getSeen();

    return tourdata;
  }


  Future<List<ResultsProfile>> getProfile() async {
    String newurl = TravApis.CLIENTPROFILE + "id="+ID+ "&type="+Type;

    print("Profile Url is : " + newurl.toString());

    var url = Uri.parse(newurl);

    http.Response res = await http.get(url);
    //  List datas= jsonDecode(res.body);

    print("Profile response is : " + res.body);

    var datas = jsonDecode(res.body)['results'] as List;

    List<ResultsProfile> logindata = datas.map((data) =>
        ResultsProfile.fromJson(data)).toList();

    fname = logindata[0].firstName!;
    lname = logindata[0].lastName!;

    print("first name is : $fname");
    print("last name : $lname");

    return logindata;
  }

}
