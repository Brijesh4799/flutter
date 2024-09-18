import 'dart:async';
import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/feedratingmodel.dart';
import '../Utils/Apis.dart';



class RatingSL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Rating(),
    );
  }
}

class Rating extends StatefulWidget {

  @override
  State createState() => MyRating();
}

class MyRating extends State<Rating> {

  String refID="";

  late SharedPreferences prefRefid;

  bool isFeedBackClick=false;

  String feebackvalue="5";

  String excellentplane="ratingwhite.png";
  String vgoodplane="ratingwhite.png";
  String goodplane="ratingwhite.png";
  String avgplane="ratingwhite.png";
  String poorplane="ratingwhite.png";

  getMyRefId() async {
    prefRefid = await SharedPreferences.getInstance();
    setState(() {
      refID = prefRefid.getString("refid")!;
    });
  }


  void getExcellent(){
    setState(() {
       excellentplane="ratingblue.png";
       vgoodplane="ratingwhite.png";
       goodplane="ratingwhite.png";
       avgplane="ratingwhite.png";
       poorplane="ratingwhite.png";
    });
  }

  void getVGood(){
    setState(() {
      excellentplane="ratingwhite.png";
      vgoodplane="ratingblue.png";
      goodplane="ratingwhite.png";
      avgplane="ratingwhite.png";
      poorplane="ratingwhite.png";
    });
  }

  void getGood(){
    setState(() {
      excellentplane="ratingwhite.png";
      vgoodplane="ratingwhite.png";
      goodplane="ratingblue.png";
      avgplane="ratingwhite.png";
      poorplane="ratingwhite.png";
    });
  }

  void getAvg(){
    setState(() {
      excellentplane="ratingwhite.png";
      vgoodplane="ratingwhite.png";
      goodplane="ratingwhite.png";
      avgplane="ratingblue.png";
      poorplane="ratingwhite.png";
    });
  }

  void getPoor(){
    setState(() {
      excellentplane="ratingwhite.png";
      vgoodplane="ratingwhite.png";
      goodplane="ratingwhite.png";
      avgplane="ratingwhite.png";
      poorplane="ratingblue.png";
    });
  }





 /* bool isFeedBackClick= false;

  Color myfeedbackcolorexcellent= Color(0xffeeeeee);
  Color myfeedbacktextcolorexcellent= Colors.black;

  Color myfeedbackcolorgood= Color(0xffeeeeee);
  Color myfeedbacktextcolorgood= Colors.black;

  Color myfeedbackcolorpoor= Color(0xffeeeeee);
  Color myfeedbacktextcolorpoor= Colors.black;*/

 /* void first(){
    myfeedbackcolorexcellent= Colors.lightGreen;
    myfeedbacktextcolorexcellent= Colors.white;

    myfeedbackcolorgood= Color(0xffeeeeee);
    myfeedbacktextcolorgood= Colors.black;

    myfeedbackcolorpoor= Color(0xffeeeeee);
    myfeedbacktextcolorpoor= Colors.black;
  }

  void second(){
    myfeedbackcolorexcellent= Color(0xffeeeeee);
    myfeedbacktextcolorexcellent= Colors.black;

    myfeedbackcolorgood= Colors.yellow;
    myfeedbacktextcolorgood= Colors.white;

    myfeedbackcolorpoor= Color(0xffeeeeee);
    myfeedbacktextcolorpoor= Colors.black;
  }

  void third(){
    myfeedbackcolorexcellent= Color(0xffeeeeee);
    myfeedbacktextcolorexcellent= Colors.black;

    myfeedbackcolorgood= Color(0xffeeeeee);
    myfeedbacktextcolorgood= Colors.black;

    myfeedbackcolorpoor= Colors.red;
    myfeedbacktextcolorpoor= Colors.white;
  }*/

  @override
  void initState() {
    getMyRefId();
    getExcellent();
    isFeedBackClick=true;
    feebackvalue="5";
    print(feebackvalue);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
              ),*/

              Container(
              //    margin: EdgeInsets.only(left: 15),
                child: Text("RATINGS",
                    style: TextStyle(color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'BebesNeue',
                        fontWeight: FontWeight.w700)),
              )

            ],

          ),
        ),
      ),

      body:Container(
       // margin: EdgeInsets.only(bottom: 100),
        child: Column(
          children: [

            SizedBox(height: 25,),

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

            SizedBox(height: 10,),

            Row(
              children: [
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    //   margin: EdgeInsets.only(left: 5,top: 5, right: 5),
                    child: Image.asset("image/ratinglogo.jpg",height: 70,),
                  ),
                ),
              ],
            ),


          SizedBox(height: 30,),

          Row(children: [

             Expanded(
               flex: 2,
               child: Container(
                 margin: EdgeInsets.only(left: 60,),
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
                    getExcellent();
                    isFeedBackClick=true;
                    feebackvalue="5";
                    print(feebackvalue);
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
                  margin: EdgeInsets.only(left: 60,),
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
                    getVGood();
                    isFeedBackClick=true;
                    feebackvalue="4";
                    print(feebackvalue);
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
                  margin: EdgeInsets.only(left: 60,),
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
                    getGood();
                    isFeedBackClick=true;
                    feebackvalue="3";
                    print(feebackvalue);
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
                  margin: EdgeInsets.only(left: 60,),
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
                    getAvg();
                    isFeedBackClick=true;
                    feebackvalue="2";
                    print(feebackvalue);
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
                  margin: EdgeInsets.only(left: 60,),
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
                    getPoor();
                    isFeedBackClick=true;
                    feebackvalue="1";
                    print(feebackvalue);
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

                getRatingFeed();

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
              width: 140,
             // margin: EdgeInsets.only(left: 5,right: 10),
              padding: EdgeInsets.only(top: 12.5, bottom: 12.5, left: 15,right: 15),
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
      ),




    );
  }

  Future<List <ResultRating>> getRatingFeed() async {
    String newurl = TravApis.FEEDBACKRATING + "tripFeedback="+feebackvalue+"&refId="+refID;

    List<ResultRating> ratingdata=[];


    print("FeedBack Rating URL" +newurl);

    var res = await http.post(
        Uri.parse(newurl),
        body: ({
          'tripFeedback': feebackvalue,
          'refId': refID,
        })
    );

    print("Feedback Rating Responsee is " +res.body);

    var datas = jsonDecode(res.body)['result'] as List;

    ratingdata = datas.map((data) => ResultRating.fromJson(data)).toList();

    String message = ratingdata[0].msg!;

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


    return ratingdata;

  }

}
