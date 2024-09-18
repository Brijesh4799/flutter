
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Models/chatmsgmodel.dart';
import '../Models/chatshowmodel.dart';
import '../Utils/Apis.dart';


class Chatmsg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: ChatmsgST(),
    );
  }
}


class ChatmsgST extends StatefulWidget {
  // ItemDetail({required this.itemlist});

  @override
  State createState() => new MyChatmsgST();
}

class MyChatmsgST extends State<ChatmsgST> {

  late SharedPreferences prefs, preflog_in_out,p_refid,p_scancode,prefguestmobile,prefguestid,prefprofile,p_mgrmobile;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  List<ResultChatMsg>? chatmsgmodel;
  List<ResultChatShow>? chatshowmodel;

  ScrollController _scrollController = ScrollController();

  Timer? timer;

  var refid = "";
  bool isSend=false;

  var messageCont = TextEditingController();

  String? messageValidate(String? value) {
    if (value == null || value.isEmpty)
      return "Enter a Message";
    else
      refid = value;
    print(" Message is : " + refid);
    return null;
  }



  String m_refid="";
  String m_chatid="";
  String m_chatphone="";
  String m_chatname="";
  String m_mgrmobile="";


  getMyRefId() async {

    p_refid = await SharedPreferences.getInstance();
    prefguestid = await SharedPreferences.getInstance();
    prefguestmobile = await SharedPreferences.getInstance();
    prefprofile = await SharedPreferences.getInstance();
    p_mgrmobile = await SharedPreferences.getInstance();

    setState(() {
      m_refid = p_refid.getString("refid")!;
      print ("Recieved refid from Home UI : " +m_refid);

      m_chatid = prefguestid.getString("guestid")!;
      print ("Recieved chatid from ChatMsg UI : " +m_chatid);

      m_chatphone = prefguestmobile.getString("guestmobile")!;
      print ("Recieved chatid from ChatMsg UI : " +m_chatphone);

      m_chatname = prefprofile.getString("gname")!;
      print ("Recieved chatname from ChatMsg UI : " +m_chatname);

      m_mgrmobile = p_mgrmobile.getString("mgrmobileno")!;
      print ("Recieved ManagerMobile from ChatMsg UI : " +m_mgrmobile);
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    getMyRefId();

    timer = Timer.periodic(Duration(seconds: 1),(Timer t) => setState(() {}));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });

    return  SafeArea(
      child: Scaffold(

          body:  Stack(children: [

            Container(
              child: Column(children: [

                Container(
                  padding: EdgeInsets.only(top: 10,bottom: 10),
                  // margin: EdgeInsets.only(top: 15, bottom: 0),
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(top: 5, bottom: 0),
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
                          //  color: Colors.cyanAccent,
                          margin: EdgeInsets.only(top: 0, left: 15),
                          child: Image.asset(
                            "image/profileicon.png", height: 25, width: 25,),
                        ),

                        Container(
                          margin: EdgeInsets.only(top: 0, left: 15,),
                          child: Text(m_chatname,
                            style: TextStyle(color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'BebesNeue',
                                fontWeight: FontWeight.w700),),
                        ),

                        Spacer(),


                       /* Container(
                          margin: EdgeInsets.only(right: 25),
                          child: Image.asset("image/threedots.png",height: 22, width: 22,),
                        ),*/


                      ],

                    ),
                  ),
                ),
              ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 45),
              color: Color(0xff38a0b8),
              child: Column(children: [
                // Call Api

                FutureBuilder(
                    future: getChatShow(),
                    builder:(context, snapshot) {

                      if(snapshot.hasData) {
                        chatshowmodel = snapshot.data as List<ResultChatShow>;
                        return getChatMsgWidget();
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

  Widget getChatMsgWidget(){
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
              color: Color(0xff98cfdb),
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

              Expanded(child: Container(
                margin: EdgeInsets.only(top: 20,bottom: 20),
                child: ListView.builder(
                    shrinkWrap: true,
                    controller: _scrollController,
                    padding: EdgeInsets.only(top: 15),
                    itemCount: chatshowmodel!.length+1,
                    itemBuilder: (context, index) {
                      if(index==chatshowmodel!.length){
                        return Container(
                          height: 55,
                        );
                      }

                      ResultChatShow itemslists = chatshowmodel![index];

                     /* if(itemslists.response=="sender"){
                        styleall=stylesender;
                      }*/

                      return Container(

                        margin: EdgeInsets.only(bottom: 5),
                        //  padding: EdgeInsets.only(bottom: 5,top: 5),
                        /* decoration: BoxDecoration(
                            border: Border.all(color: Colors.cyanAccent,width: 2.5,),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),

                            //  color: Colors.deepOrange,
                          ),*/
                        child: Column(
                          children: [

                           /* Container(
                              padding: EdgeInsets.only(left: 7.5,right: 7.5,top: 5,bottom: 5),
                              decoration: BoxDecoration(
                                color:Colors.white,
                                borderRadius: BorderRadius.circular(7.5),


                              ),

                              margin: EdgeInsets.only(left: 7.5),
                              child: Text(itemslists.days.toString(),
                                style: TextStyle(color: Colors.black54,
                                    fontSize: 11,
                                    fontFamily: 'BebesNeue',
                                    fontWeight: FontWeight.w700),),
                            ),*/


                            Container(
                              width:MediaQuery.of(context).size.width,
                              child: Column(
                                //  mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment:(itemslists.response=="sender")?CrossAxisAlignment.end:CrossAxisAlignment.start,
                                children: [

                                  Container(
                                    //  width: 150,
                                    margin: EdgeInsets.only(left: 5,right: 5,bottom: 3.5,top: 10),
                                    padding: EdgeInsets.only(left: 10,right: 10,top: 7.5,bottom: 7.5),
                                    decoration: BoxDecoration(
                                      color:(itemslists.response=="sender")?Color(0xff38a0b8):Colors.white,
                                      borderRadius: BorderRadius.circular(7.5),
                                      /*border: Border.all(
                                      color: Colors.white,
                                      style: BorderStyle.solid,
                                      width: 2.0,
                                    ),*/

                                    ),

                                    child: Text(itemslists.message.toString(),
                                      style: TextStyle(color: Colors.black,
                                          fontSize: 14,
                                          fontFamily: 'BebesNeue',
                                          fontWeight: FontWeight.w700),),
                                  ),


                                  Container(
                                    margin: EdgeInsets.only(left: 7.5,bottom: 5,right: 7.5),
                                    child: Text(itemslists.time.toString(),
                                      style: TextStyle(color: Colors.black54,
                                          fontSize: 9,
                                          fontFamily: 'BebesNeue',
                                          fontWeight: FontWeight.w700),),
                                  ),


                                  /* Bubble(
                                  style: stylesender,
                                  nipWidth: 10,
                                  nipHeight: 28,
                                  child: Text(itemslists.message.toString(),
                                    style: TextStyle(color: Colors.black,
                                        fontSize: 14,
                                        fontFamily: 'BebesNeue',
                                        fontWeight: FontWeight.w700),),
                                ),*/

                                ],),
                            ),
                          ],
                        ),
                      );
                    }
                ),
              ),),


              Form(
                key: formkey,
                child: Container(
                    height: 55,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          width: 250,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 2,color: Colors.cyanAccent),
                            borderRadius: BorderRadius.circular(30),

                          ),
                          //  color: Colors.lightGreen,
                          margin: EdgeInsets.only(left: 0, right: 5),
                          padding: EdgeInsets.only(left: 10,right: 5),
                          child: TextFormField(
                            textAlign: TextAlign.start,
                            controller: messageCont,
                            style: TextStyle(color: Colors.black54,fontSize: 15,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700,),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              // fillColor: Colors.grey.shade100,
                              //  filled: true,
                              hintText: "Message",
                              hintStyle: TextStyle(color: Colors.black54,fontSize: 15,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                              /*border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                    ),*/

                            ),
                            validator: messageValidate,
                            onChanged: ((value) {
                              if(value.length>0)
                                {
                                  setState(() {
                                   isSend=true;
                                  });
                                }else{
                                setState(() {
                                 isSend=false;
                                });
                              }

                            }),
                          ),

                          //last one
                        ),

                        Spacer(),

                        Visibility(
                          visible: isSend,
                          child: InkWell(
                            onTap: (){
                              validate();
                              messageCont.clear();
                              isSend=false;
                              _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 7.5,top: 7.5,right: 7.5,bottom: 7.5),
                              decoration: BoxDecoration(
                                color: Color(0xff38a0b8),
                                border: Border.all(width: 2,color: Colors.cyanAccent),
                                borderRadius: BorderRadius.circular(30),

                              ),
                              margin: EdgeInsets.only(right: 5,top:2.5),
                              child: Image.asset("image/send.png",height: 25, width: 25,),
                            ),
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
    );
  }

  Future<List <ResultChatMsg>> getChatMsg() async{

    List<ResultChatMsg> dashdata=[];

   // String newurl= "https://inboundcrm.in/travcrm-dev_2.4/Api/App/CLIENT1/json_chatroom.php?id="+m_chatid+"&message="+messageCont.text.trim()+"&mobile="+m_chatphone;

    String newurl = TravApis.CHATMSG +"id="+m_chatid+"&message="+messageCont.text.trim()+"&mobile="+m_mgrmobile;

    print("chatmsg url is : "+newurl);

    var url= Uri.parse(newurl);

    http.Response res = await http.get(url);

    if(res.statusCode==200){
      print("Success");
      setState(() {
        getChatShow();
      });
    }else{
      print("Not Success");
    }

    print("chatmsg response is : "+res.body);

    var datas= jsonDecode(res.body)['result'] as List;

    dashdata = datas.map((data) => ResultChatMsg.fromJson(data)).toList();

    String mymessage =dashdata[0].message.toString();
    print("Message from my side : "+mymessage);

    return dashdata;
  }

  Future<List <ResultChatShow>> getChatShow() async{

    List<ResultChatShow> dashdata=[];

   // String newurl= "https://inboundcrm.in/travcrm-dev_2.4/Api/App/CLIENT1/json_chatshow.php?id="+m_chatid+"&mobile="+m_chatphone;

      String newurl = TravApis.CHATSHOW +"id="+m_chatid+"&mobile="+m_mgrmobile+"&managermobile="+m_chatphone;

    print("chatshow url is : "+newurl);

    var url= Uri.parse(newurl);

    http.Response res = await http.get(url);

    print("chatshow response is : "+res.body);

    var datas= jsonDecode(res.body)['result'] as List;

    dashdata = datas.map((data) => ResultChatShow.fromJson(data)).toList();

    return dashdata;
  }

  void validate() {
    if (formkey.currentState!.validate()) {
      print("OK");
      getChatMsg();
    }
    else{
      Fluttertoast.showToast(
        msg: "No Internet Connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0,
      );
    }



      // login(
  }

}