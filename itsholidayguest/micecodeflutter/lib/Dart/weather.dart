import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';




class WeatherSL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Weather(),
    );
  }
}

class Weather extends StatefulWidget {

  @override
  State createState() => MyWeather();
}

class MyWeather extends State<Weather> {

 // List<SaleModel>? salemodel;
  bool loadCircle = false;

  var nameup = "";
  var m_name = TextEditingController();
  String cityname="City";
  double temptemp=0.0;
  String temp="10.0ºC";

  Timer? timer;

  String currenttime="";
  String currentday="";

 //  var day = DateTime.now().;
 // DateTime date = DateTime.now();
 // String dateFormat =DateFormat('EEEE').format(date);

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String? nameValidate(String? value) {
    if (value == null || value.isEmpty)
      return 'Enter a City Name';
    else
      nameup = value;
    print("Name is : " + nameup);
    return null;
  }

  void validate() {
    if (formkey.currentState!.validate()) {

        weather();


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

  @override
  void initState() {

    timer = Timer.periodic(Duration(seconds: 1),(Timer t) {

      var now = DateFormat('hh:mm a').format(DateTime.now());

      var nowday = DateFormat('EEEE').format(DateTime.now());

      //  DateFormat('hh:mm a').format(now)

      setState(() {
        currenttime=now;
        currentday=nowday;
      });
        print(currenttime);
    });



    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loadCircle,
      child: Scaffold(

        body:Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("image/weather_bg.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Text(""),
            ),


            Column(children: [

              SizedBox(height: 40,),

              Row(children: [

                Column(children: [
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Text(currentday,
                        style: TextStyle(color: Colors.white,fontSize: 16,
                            fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                  ),

                  SizedBox(height: 5,),

                  Container(
                    margin: EdgeInsets.only(left: 20,),
                    child: Text(currenttime,
                        style: TextStyle(color: Colors.white,fontSize: 24,
                            fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                  ),
                ],)

              ],),

                 Expanded(

                  child: SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height/1.15,

                      child: Form(
                        key: formkey,
                        child: Column(
                          children: [


                            Container(width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(left: 60, right: 60),
                              child: TextFormField(
                                maxLines: 1,
                                style: TextStyle(color: Colors.white,fontSize: 16,
                                    fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                                textAlign: TextAlign.center,
                                controller: m_name,
                                decoration: InputDecoration(
                                 // fillColor: Colors.white,
                               // focusColor: Colors.white,
                                 // filled: true,
                                  hintText: "Enter City-Name",
                                  hintStyle: TextStyle(color: Colors.white,fontSize: 16,
                                      fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                                  /*border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)
                                  ),*/

                                ),
                                validator: nameValidate,
                              ),

                            ),

                            SizedBox(height: 10,),

                               InkWell(
                                onTap: (){
                                  validate();
                                },
                                child: Container(
                                  width: 110,
                                  height: 40,
                                  decoration: BoxDecoration(
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
                                  child: Center(
                                    child: Text("SEARCH",style: TextStyle(color: Colors.white,fontSize: 16,
                                         fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                                  ),
                                ),
                              ),

                            Center(
                              child: Container(
                                margin: EdgeInsets.only(top: 40),
                                padding: EdgeInsets.only(top: 15),
                                child: InkWell(
                                  onTap: () {

                                  },
                                  child: Container(
                                    height: 250,
                                    width: 210,
                                    child: Image.asset(
                                      "image/sun.png",
                                      height: 80,
                                      width: 80,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Expanded(

                              child: Align(
                                alignment: FractionalOffset.bottomCenter,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child:  Row(
                                    children: [

                                      Container(
                                     //   width: 55,
                                        margin: EdgeInsets.only(left: 20,),
                                        child: Text(temp.substring(0,4)+"ºC",
                                            maxLines: 1,
                                            style: TextStyle(color: Colors.white,fontSize: 24,
                                                fontFamily: 'BebesNeue',fontWeight: FontWeight.w700,)),
                                      ),

                                      /*Container(
                                        width: 65,

                                        child: Text("ºC",
                                            style: TextStyle(color: Colors.white,fontSize: 24,
                                              fontFamily: 'BebesNeue',fontWeight: FontWeight.w700,)),
                                      ),*/

                                      Spacer(),

                                      Container(
                                        width: 2,
                                        height: 55,
                                        color: Colors.white,
                                        margin: EdgeInsets.only(right: 40),
                                        child: Text("",
                                            style: TextStyle(color: Color(0xffb71c1c),fontSize: 24,
                                                fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                                      ),

                                      Spacer(),

                                      Container(
                                        margin: EdgeInsets.only(right: 20,),
                                        child: Text(cityname,
                                            style: TextStyle(color: Colors.white,fontSize: 16,
                                                fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(bottom: 60),
                              child: Row(
                                children: [

                                  Container(
                                    margin: EdgeInsets.only(left: 100),
                                    width: 30,
                                    height: 2,
                                    color: Colors.white,
                                    child: Text("",
                                        style: TextStyle(color: Color(0xffb71c1c),fontSize: 24,
                                            fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                                  ),

                                  Spacer(),

                                  Container(
                                    width: 30,
                                    height: 2,
                                    color: Colors.white,
                                    margin: EdgeInsets.only(left: 10,right: 10),
                                    child: Text("",
                                        style: TextStyle(color: Color(0xffb71c1c),fontSize: 24,
                                            fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                                  ),

                                  Spacer(),

                                  Container(
                                    width: 30,
                                    height: 2,
                                    color: Colors.white,
                                    margin: EdgeInsets.only(right: 100),
                                    child: Text("",
                                        style: TextStyle(color: Color(0xffb71c1c),fontSize: 24,
                                            fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                                  ),
                                ],
                              ),
                            ),




                          ],
                        ),
                      ),
                    ),
                  ),
                ),




            ],),




          ],
        ),


      ),
    );
  }

  Future<void> weather() async {
    String newurl ="http://api.openweathermap.org/data/2.5/weather?q="+m_name.text.trim()+"&appid=afc979012fee64bf8f3467f54b53bfea";
    var url = Uri.parse(newurl);
    /*  Fluttertoast.showToast(
        msg: "Weather URL is : " + url.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0
    );*/
    getWeather();

  }

  Future<void> getWeather() async {
    loadCircle = false;
    String newurl ="http://api.openweathermap.org/data/2.5/weather?q="+m_name.text.trim()+"&appid=afc979012fee64bf8f3467f54b53bfea";

    var url = Uri.parse(newurl);

   /* Fluttertoast.showToast(
        msg: "Weather URL is : " + url.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 4,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0
    );
*/

    http.Response res = await http.get(url);


    /*Fluttertoast.showToast(
        msg: "weather response is : " + res.body,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0
    );
*/

    setState(() {
      if(res.statusCode==200){
        loadCircle = false;
        print("OK");
        String data = res.body;
        temptemp= jsonDecode(data)['main']['temp'];
        cityname= jsonDecode(data)['name'];
        print("City Temprature is : $temptemp" );
        print("City Name is :" +cityname);
        double temperatureCelsius = temptemp - 273.15;
        temp= temperatureCelsius.toString();
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
        print("error");

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
