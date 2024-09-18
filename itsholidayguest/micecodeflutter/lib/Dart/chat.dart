
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:micetravel/Dart/chatmsg.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Models/profilemodel.dart';
import '../Models/seenmodel.dart';
import '../Models/tourassistancemodel.dart';
import '../Utils/Apis.dart';


class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: ChatST(),
    );
  }
}


class ChatST extends StatefulWidget {
  // ItemDetail({required this.itemlist});

  @override
  State createState() => new MyChatST();
}

class MyChatST extends State<ChatST> {

  late SharedPreferences prefRefid,prefId,preftype,p_mgrmobile,prefprofile,prefguestid,prefguestmobile ;

  String refID="";
  String Guestname="";
  String mgrmobileno="";
  String ID="";
  String Type="";
  String Guestid="";
  String Guestmobile="";
  String seen="";
  String guestId="";
  bool isSeenShow=false;

  late List<ResultsTour> tourdata;


  String select="Pending";
  Color selectcolorpending= Colors.blue;
  Color selectcolorcheckin= Colors.white;

  getMyRefId() async {
    prefRefid = await SharedPreferences.getInstance();
    preftype = await SharedPreferences.getInstance();
    prefId = await SharedPreferences.getInstance();

    setState(() {
      refID = prefRefid.getString("refid")!;
      Type=preftype.getString("type")!;
      ID = prefId.getString("id")!;
    });
  }

  Timer? timer,timer2;

  @override
  void initState() {
    // TODO: implement initState
    getMyRefId();

    timer2 = Timer.periodic(Duration(seconds: 1),(Timer t) async {

      setState(() {});

      // timer2?.cancel();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(

          body: Stack(children: [

            Container(
              //  padding: EdgeInsets.only(top: 10,bottom: 10),
              // margin: EdgeInsets.only(top: 15, bottom: 0),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
              ),
              child: Container(
                margin: EdgeInsets.only(top: 15, bottom:15),
                // padding: EdgeInsets.only(bottom: 20, top: 0),
                child:  Row(
                  children: [

                    InkWell(
                      onTap:(){
                        Navigator.pop(context);
                        print("drawer is pressed");
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 0, left: 15),
                        child: Image.asset(
                          "image/back.png", height: 20, width: 25,),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 0, left: 15,),
                      child: Text("Chat",
                        style: TextStyle(color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'BebesNeue',
                            fontWeight: FontWeight.w700),),
                    ),

                    Spacer(),

                  ],

                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 50),
              color: Color(0xff38a0b8),
              child: Column(children: [

                // Call Api

                FutureBuilder(
                    future: getTourAssitant(),
                    builder:(context, snapshot) {

                      if(snapshot.hasData) {
                        tourdata = snapshot.data as List<ResultsTour>;

                        if(tourdata.length==0) {

                          /*Fluttertoast.showToast(
                              msg: "No GuestList Now",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 3,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 12.0
                          );
*/
                        }
                          else{
                            /* Fluttertoast.showToast(
            msg: "Updated Now : ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 12.0
        );*/
                          }

                        return getChatWidget();
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

              ],
              ),
            )
          ],

          )
      ),
    );
  }

  Widget getChatWidget(){
    return  Expanded(

      child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
              left: 10, right: 10, top: 20, bottom: 10),
          //height: 275,

          padding: EdgeInsets.only(
              left: 10, right: 10, top: 0, bottom: 15),


          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.cyanAccent,width: 5,),
              //  color: Colors.deepOrange,
             /* gradient: LinearGradient(
                //   begin: Alignment.topLeft,
                //   end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.3),
                  Colors.white.withOpacity(0.3),
                ],
                //  stops: [0.0,1.0]
              )*/

          ),

          child: Column(
            children: [

              Expanded(child: ListView.builder(
                  padding: EdgeInsets.only(top: 15),
                  itemCount: tourdata.length,
                  itemBuilder: (context, index) {

                    ResultsTour itemslists = tourdata[index];

                   // guestId = itemslists.id.toString();

                 //   getSeen();

                    if(seen=="0" || seen=="" || seen=="null"){
                      isSeenShow=false;
                    }else{
                      isSeenShow=true;
                    }

                    return InkWell(
                      onTap: () async {

                        mgrmobileno = itemslists.phoneno.toString();
                        Guestname = itemslists.name.toString();

                        prefprofile = await SharedPreferences.getInstance();
                        prefprofile.setString("gname", Guestname);
                        print("first name is : "+Guestname);

                        prefguestid = await SharedPreferences.getInstance();
                        prefguestid.setString("guestid", Guestid);

                        prefguestmobile = await SharedPreferences.getInstance();
                        prefguestmobile.setString("guestmobile", Guestmobile);

                        print("Guest-ID from prfile is : " +Guestid);
                        print("Guest-Mobile no from profile : " + Guestmobile);

                        p_mgrmobile = await SharedPreferences.getInstance();
                        p_mgrmobile.setString("mgrmobileno", mgrmobileno);



                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChatmsgST()));
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 7.5),
                        padding: EdgeInsets.only(bottom: 5,top: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.cyanAccent,width: 2.5,),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),

                          //  color: Colors.deepOrange,


                        ),
                        child: Column(children: [


                          Row(mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Container(
                                  //  color: Colors.cyanAccent,
                                  margin: EdgeInsets.only(top: 0, left: 15),
                                  child: Image.asset(
                                    "image/profileicon.png", height: 50, width: 50,),
                                ),

                                Container(
                                  margin: EdgeInsets.only(
                                      left: 20, top: 10),
                                  // width: 150,
                                  child: Text(itemslists.name.toString(),
                                    style: TextStyle(color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: 'BebesNeue',
                                        fontWeight: FontWeight.w700),),
                                ),

                                Spacer(),

                                Visibility(
                                  visible:isSeenShow,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10,top: 5,bottom: 5,right: 10),
                                    decoration : BoxDecoration(
                                      border: Border.all(width: 1,color: Colors.cyanAccent),
                                      color: Color(0xff38a0b8),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    margin: EdgeInsets.only(right: 20, top: 15),
                                    // width: 150,
                                    child: Text(seen,
                                      style: TextStyle(color: Colors.white,
                                          fontSize: 13,
                                          fontFamily: 'BebesNeue',
                                          fontWeight: FontWeight.w700),),
                                  ),
                                ),

                              ]
                          ),


                        ],),
                      ),
                    );

                  }
              ),

              )


            ],

          )
      ),
    );
  }


  Future<List<ResultsProfile>> getProfile() async {
    String newurl = TravApis.CLIENTPROFILE + "id="+ID+"&type="+Type;

    print("Profile Url is : " + newurl.toString());

    var url = Uri.parse(newurl);

    http.Response res = await http.get(url);
    //  List datas= jsonDecode(res.body);

    print("Profile response is : " + res.body);

    var datas = jsonDecode(res.body)['results'] as List;

    List<ResultsProfile> logindata = datas.map((data) => ResultsProfile.fromJson(data)).toList();

    Guestid=logindata[0].id.toString();
    Guestmobile=logindata[0].mobile.toString();

    getSeen();

    //Guestname=logindata[0].firstName.toString()+""+logindata[0].lastName.toString();
    return logindata;
  }

  Future<List<ResultsTour>> getTourAssitant() async {
    String newurl = TravApis.TOURASSTANT + "RefId="+refID;

    print("Tour Assistant Url is : " + newurl.toString());

    var url = Uri.parse(newurl);

    http.Response res = await http.get(url);
    //  List datas= jsonDecode(res.body);

    getProfile();

    print("Tour Assistant response is : " + res.body);

    var datas = jsonDecode(res.body)['results'] as List;

    List<ResultsTour> tourdata = datas.map((data) =>
        ResultsTour.fromJson(data)).toList();

    return tourdata;
  }

  Future<List <ResultSeen>> getSeen() async{

    List<ResultSeen> dashdata=[];

    //  String newurl= "https://inboundcrm.in/travcrm-dev_2.2/Api/App/nikhil/json_call.php";/*?followupdate=01-06-2023&status=2*/

    String newurl = TravApis.SEEN +"id="+Guestid+"&mobile="+Guestmobile;

    print("Seen url is : "+newurl);

    var url= Uri.parse(newurl);


    http.Response res = await http.get(url);

    print("Seen response is : "+res.body);

    var datas= jsonDecode(res.body)['result'] as List;

    dashdata = datas.map((data) => ResultSeen.fromJson(data)).toList();

    seen = dashdata[0].seen.toString();
    print("Seen is : " +seen);

    return dashdata;
  }

}