
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:salescrm/Darts/call.dart';
import 'package:salescrm/Models/allname.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:pie_chart/pie_chart.dart';

import 'package:url_launcher/url_launcher.dart';

import '../Apis/apis.dart';
import '../Models/addcallmodel.dart';
import '../Providers/callprovider.dart';
import '../Providers/nameprovider.dart';
import '../main.dart';
import 'addnew.dart';
import 'calltodaydata.dart';
import 'data.dart';
import 'items.dart';

class AddCallST extends StatefulWidget {

  @override
  State createState() => new MyAddCallST();
}

class MyAddCallST extends State<AddCallST> {

  late SharedPreferences prefs,preflog_in_out;

  List<ResultsAllName>? allnamemodels;
  late ResultsAllName selectedNames;

  String search="";
  TextEditingController searchController = TextEditingController();

  String m_cperson="sanjeev";
  String m_cname="sanjeev";
  String m_number="8826254837";
  int mypos=0;

  String callnumber="";
  String whatsappnumber="";

  GlobalKey<ScaffoldState> _drawerkey= GlobalKey<ScaffoldState>();

  List<Color> colorList = [Color(0xffffc107), Colors.green, Color(0xff00E5FF)];

  Color selectcolorstatus= Color(0xff01579b);

  String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';

  String select="Today";
  Color selectcolortoday= Color(0xff00E5FF);
  Color selectcolortomorrow= Colors.black54;
  Color selectcolordate= Colors.black54;
  bool isTodayLine=true;
  bool isTomorrowLine=false;
  bool isDateLine=false;

  DateTime fromselectedDate = DateTime.now();
  static String fromtime= DateFormat('dd-MM-yyyy').format(DateTime.now());

  DateTime fromnextDate = DateTime.now();
  static String nexttime= DateFormat('dd-MM-yyyy').format(DateTime.now());

  var activityarr=["Call","Agent"];

  var businessarr=["Agent","B2C"];

  var callarr=["Incoming","Outgoing"];

  var statusarr=["Held","Cancelled"];

  var timearr=["10:00 AM","11:00 AM","12:00 PM","01:00 PM","02:00 PM","03:00 PM","04:00 PM","05:00 PM"];

  var productarr=["TRAVCRM Inbound","TRAVCRM Outbound","TRAVCRM MICE","TRAVCRM Domestic"];

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  var noteController = TextEditingController();
  var nameController = TextEditingController();
  var personController = TextEditingController();
  var contactController = TextEditingController();

  var nameup = "";
  var notesup = "";
  var phoneup = "";
  var personup = "";

  String? noteValidate(String? value) {
    if (value == null || value.isEmpty)
      return 'Enter a Notes';
    else
      notesup = value;
    print("notes : " + notesup);
    return null;
  }

  String? nameValidate(String? value) {
    if (value == null || value.isEmpty)
      return 'Enter a Company Name';
    else
      nameup = value;
    print("name : " + nameup);
    return null;
  }

  String? phoneValidate(String? value) {
    if (value == null || value.isEmpty)
      return 'Enter a Phone No';
    else
      phoneup = value;
    print("phone : " + phoneup);
    return null;
  }

  String? personValidate(String? value) {
    if (value == null || value.isEmpty)
      return 'Enter a Contact Person Name';
    else
      personup = value;
    print("person : " + personup);
    return null;
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  getMyLoginValue();
  }

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(


          body: Container(
            child: Column(children: [

              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: [

                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(top:5,left: 15),
                        child: Image.asset("image/back.png",height: 18, width: 20,),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top:6,left: 15,right: 20),
                      child: Text("Add Call",
                        style: TextStyle(color: Colors.blue,fontSize: 18,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                    ),



                  ],

                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width,
                height: 2,
                color: Colors.blue,
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [

                  /*  Row(children: [

                      Container(
                        margin: EdgeInsets.only(left: 15, top: 15),
                        child:  Text("Call Type",
                          style: TextStyle(color: Colors.blue,fontSize: 10,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                      ),

                    ]),

                    Row(children: [

                      Expanded(
                        child: Container(
                          //  padding: EdgeInsets.only(top: 20,bottom: 20,left: 20,right: 20),
                          width: MediaQuery.of(context).size.width,
                          height: 35.0,
                          margin: EdgeInsets.only(left: 20,right: 15),
                          child:DropdownButtonHideUnderline(

                            child: ButtonTheme(
                              focusColor: Colors.white,
                              child: ChangeNotifierProvider<CallProvider>(

                                  create: (context) => CallProvider(),

                                  child: Consumer<CallProvider>(
                                      builder: (context, provider, child){

                                        return DropdownButton(
                                          dropdownColor: Colors.white,
                                          style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                                          // dropdownColor: Colors.grey,
                                          focusColor: Colors.black,
                                          icon: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.black,
                                          ),
                                          items: activityarr.map((String itemnames) {
                                            return DropdownMenuItem<String>(

                                                value: itemnames,
                                                child: Text(itemnames,textAlign: TextAlign.center,style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700))
                                            );
                                          }).toList(),

                                          onChanged: (String? value) {
                                            CallProvider.activitytpye=value!;

                                            provider.selectActivity();

                                          },
                                          value: CallProvider.activitytpye,
                                        );
                                      }
                                  )


                              ),
                            ),
                          ),

                           decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,

                            ),
                        ),
                      ),
                    ]),*/

                    Row(children: [

                      Container(
                        margin: EdgeInsets.only(left: 15, top: 10),
                        child:  Text("Business Type",
                          style: TextStyle(color: Colors.blue,fontSize: 10,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                      ),

                    ]),

                    Row(children: [

                      Expanded(
                        child: Container(
                          //  padding: EdgeInsets.only(top: 20,bottom: 20,left: 20,right: 20),
                          width: MediaQuery.of(context).size.width,
                          height: 35.0,
                          margin: EdgeInsets.only(left: 15,right: 15),
                          child:DropdownButtonHideUnderline(

                            child: ButtonTheme(
                              focusColor: Colors.white,
                              child: ChangeNotifierProvider<CallProvider>(

                                  create: (context) => CallProvider(),

                                  child: Consumer<CallProvider>(
                                      builder: (context, provider, child){

                                        return DropdownButton(
                                          dropdownColor: Colors.white,
                                          style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                                          // dropdownColor: Colors.grey,
                                          focusColor: Colors.black,
                                          icon: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.black,
                                          ),
                                          items: businessarr.map((String itemnames) {
                                            return DropdownMenuItem<String>(

                                                value: itemnames,
                                                child: Text(itemnames,textAlign: TextAlign.center,style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700))
                                            );
                                          }).toList(),

                                          onChanged: (String? value) {
                                            CallProvider.businesstpye=value!;

                                            provider.selectBusiness();

                                          },
                                          value: CallProvider.businesstpye,
                                        );
                                      }
                                  )


                              ),
                            ),
                          ),

                          /* decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,

                            ),*/
                        ),
                      ),
                    ]),

                    Row(children: [

                      Container(
                        margin: EdgeInsets.only(left: 15, top: 10),
                        child:  Text("Name",
                          style: TextStyle(color: Colors.blue,fontSize: 10,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                      ),

                      Spacer(),

                      InkWell(onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddNewST()),).then((value) =>{ getUpdate()});

                        //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddNewST()));
                        print("is called");
                      },
                        child: Container(
                          padding: EdgeInsets.only(left: 25,right: 25,top: 7.5,bottom: 7.5),
                          color: Colors.lightBlueAccent,
                          margin: EdgeInsets.only(right: 15, top: 10),
                          child:  Text("+ Add New",
                            style: TextStyle(color: Colors.white,fontSize: 10,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                        ),
                      ),

                    ]),

                    Form(
                      key: formkey,
                      child: Column(
                        children: [

                          Container(
                            margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                            child: TextFormField(
                              controller: searchController,
                              decoration: InputDecoration(
                                  hintText: "Search",
                                  hintStyle: TextStyle(fontSize: 12,color: Colors.black54),
                                  border: const OutlineInputBorder()
                              ),
                              onChanged: (String? value){
                                setState(() {
                                  search=value.toString();
                                });
                              },
                            ),
                          ),


                          FutureBuilder(
                              future: getAllNames(),
                              builder:(context,  snapshot) {

                                if(snapshot.hasData) {

                                  allnamemodels = snapshot.data as List<ResultsAllName>?;

                                  if(allnamemodels!.length==0) {
                                    Fluttertoast.showToast(
                                        msg: "No Data Available Now",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 4,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 12.0
                                    );
                                  }
                                  else{
                                    selectedNames = allnamemodels![mypos];
                                    print("Position : "+mypos.toString());

                                    m_number=selectedNames.contactNo.toString();
                                    m_cperson=selectedNames.contactPerson.toString();
                                    m_cname=selectedNames.name.toString();

                                    /*  m_number=allnamemodels![0].contactNo.toString();
                                      m_cperson=allnamemodels![0].contactPerson.toString();
                                      m_cname=allnamemodels![0].name.toString();*/

                                    print("Contact number is : "+m_number);
                                    print("Contact person is : "+m_cperson);
                                    print("Contact Name is : "+m_cname);


                                    return  getAllNameWidget();

                                  }
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

                          Row(
                            children: [
                              Column(children: [
                                Container(
                                  margin: EdgeInsets.only(left: 0,right: 55, top: 2.5),
                                  child:  Text("Call Type",
                                    style: TextStyle(color: Colors.blue,fontSize: 10,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                                ),

                                Container(
                                  //  padding: EdgeInsets.only(top: 20,bottom: 20,left: 20,right: 20),
                                  width: 100,
                                  height: 35.0,
                                  margin: EdgeInsets.only(left: 20,right: 10),
                                  child:DropdownButtonHideUnderline(

                                    child: ButtonTheme(
                                      focusColor: Colors.white,
                                      child: ChangeNotifierProvider<CallProvider>(

                                          create: (context) => CallProvider(),

                                          child: Consumer<CallProvider>(
                                              builder: (context, provider, child){

                                                return DropdownButton(
                                                  dropdownColor: Colors.white,
                                                  style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                                                  // dropdownColor: Colors.grey,
                                                  focusColor: Colors.black,
                                                  icon: Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: Colors.black,
                                                  ),
                                                  items: callarr.map((String itemnames) {
                                                    return DropdownMenuItem<String>(

                                                        value: itemnames,
                                                        child: Text(itemnames,textAlign: TextAlign.center,style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700))
                                                    );
                                                  }).toList(),

                                                  onChanged: (String? value) {
                                                    CallProvider.calltpye=value!;

                                                    provider.selectCall();

                                                  },
                                                  value: CallProvider.calltpye,
                                                );
                                              }
                                          )


                                      ),
                                    ),
                                  ),

                                  /* decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,

                            ),*/
                                ),
                              ],),



                              Column(children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10, top: 2.5),
                                  child:  Text("Status",
                                    style: TextStyle(color: Colors.blue,fontSize: 10,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                                ),

                                Container(
                                  //  padding: EdgeInsets.only(top: 20,bottom: 20,left: 20,right: 20),
                                  width: 100,
                                  height: 35.0,
                                  margin: EdgeInsets.only(left: 100,right: 10),
                                  child:DropdownButtonHideUnderline(

                                    child: ButtonTheme(
                                      focusColor: Colors.white,
                                      child: ChangeNotifierProvider<CallProvider>(

                                          create: (context) => CallProvider(),

                                          child: Consumer<CallProvider>(
                                              builder: (context, provider, child){

                                                return DropdownButton(
                                                  dropdownColor: Colors.white,
                                                  style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                                                  // dropdownColor: Colors.grey,
                                                  focusColor: Colors.black,
                                                  icon: Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: Colors.black,
                                                  ),
                                                  items: statusarr.map((String itemnames) {
                                                    return DropdownMenuItem<String>(

                                                        value: itemnames,
                                                        child: Text(itemnames,textAlign: TextAlign.center,style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700))
                                                    );
                                                  }).toList(),

                                                  onChanged: (String? value) {
                                                    CallProvider.statuscalltpye=value!;

                                                    provider.selectStatus();

                                                  },
                                                  value: CallProvider.statuscalltpye,
                                                );
                                              }
                                          )


                                      ),
                                    ),
                                  ),

                                  /* decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,

                            ),*/
                                ),

                              ],),
                            ],
                          ),

                          Row(
                            children: [
                              Column(children: [

                                Container(
                                  margin: EdgeInsets.only(left: 0,right: 67.5, top: 2.5),
                                  child:  Text("Date",
                                    style: TextStyle(color: Colors.blue,fontSize: 10,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                                ),

                                InkWell(
                                  onTap: (){
                                    selectFromDateAssign(context);
                                  },
                                  child: Row(children: [

                                    Container(
                                      margin: EdgeInsets.only(left: 20,top: 10),
                                      child: Center(
                                        child: Text(fromtime,
                                            style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                                      ),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only( top: 10,left: 15),
                                      child: Image.asset("image/calender.png",height: 14, width: 14,),
                                    ),
                                  ],
                                  ),
                                ),

                              ],),



                              Column(children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20, top: 10),
                                  child:  Text("Time",
                                    style: TextStyle(color: Colors.blue,fontSize: 10,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                                ),

                                Container(
                                  //  padding: EdgeInsets.only(top: 20,bottom: 20,left: 20,right: 20),
                                  width: 100,
                                  height: 35.0,
                                  margin: EdgeInsets.only(left: 110,right: 10),
                                  child:DropdownButtonHideUnderline(

                                    child: ButtonTheme(
                                      focusColor: Colors.white,
                                      child: ChangeNotifierProvider<CallProvider>(

                                          create: (context) => CallProvider(),

                                          child: Consumer<CallProvider>(
                                              builder: (context, provider, child){

                                                return DropdownButton(
                                                  dropdownColor: Colors.white,
                                                  style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                                                  // dropdownColor: Colors.grey,
                                                  focusColor: Colors.black,
                                                  icon: Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: Colors.black,
                                                  ),
                                                  items: timearr.map((String itemnames) {
                                                    return DropdownMenuItem<String>(

                                                        value: itemnames,
                                                        child: Text(itemnames,textAlign: TextAlign.center,style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700))
                                                    );
                                                  }).toList(),

                                                  onChanged: (String? value) {
                                                    CallProvider.timetpye=value!;

                                                    provider.selectTime();

                                                  },
                                                  value: CallProvider.timetpye,
                                                );
                                              }
                                          )


                                      ),
                                    ),
                                  ),

                                  /* decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,

                            ),*/
                                ),

                              ],),
                            ],
                          ),

                          Row(
                            children: [
                              Column(children: [

                                Container(
                                  margin: EdgeInsets.only(left: 15,right: 20, top: 10),
                                  child:  Text("Next Follow-up Date",
                                    style: TextStyle(color: Colors.blue,fontSize: 10,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                                ),

                                InkWell(
                                  onTap: (){
                                    selectNextDateAssign(context);
                                  },
                                  child: Row(children: [

                                    Container(
                                      margin: EdgeInsets.only(left: 15,top: 10),
                                      child: Center(
                                        child: Text(nexttime,
                                            style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                                      ),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only( top: 10,left: 15),
                                      child: Image.asset("image/calender.png",height: 14, width: 14,),
                                    ),
                                  ],
                                  ),
                                ),

                              ],),



                              Column(children: [
                                Container(
                                  margin: EdgeInsets.only(left: 45, top: 10),
                                  child:  Text("Next Follow-up Time",
                                    style: TextStyle(color: Colors.blue,fontSize: 10,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                                ),

                                Container(
                                  //  padding: EdgeInsets.only(top: 20,bottom: 20,left: 20,right: 20),
                                  width: 100,
                                  height: 35.0,
                                  margin: EdgeInsets.only(left: 105,right: 10),
                                  child:DropdownButtonHideUnderline(

                                    child: ButtonTheme(
                                      focusColor: Colors.white,
                                      child: ChangeNotifierProvider<CallProvider>(

                                          create: (context) => CallProvider(),

                                          child: Consumer<CallProvider>(
                                              builder: (context, provider, child){

                                                return DropdownButton(
                                                  dropdownColor: Colors.white,
                                                  style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                                                  // dropdownColor: Colors.grey,
                                                  focusColor: Colors.black,
                                                  icon: Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: Colors.black,
                                                  ),
                                                  items: timearr.map((String itemnames) {
                                                    return DropdownMenuItem<String>(

                                                        value: itemnames,
                                                        child: Text(itemnames,textAlign: TextAlign.center,style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700))
                                                    );
                                                  }).toList(),

                                                  onChanged: (String? value) {
                                                    CallProvider.nexttimetpye=value!;

                                                    provider.selectNextTime();

                                                  },
                                                  value: CallProvider.nexttimetpye,
                                                );
                                              }
                                          )


                                      ),
                                    ),
                                  ),

                                  /* decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,

                            ),*/
                                ),

                              ],),
                            ],
                          ),

                          Row(children: [

                            Container(
                              margin: EdgeInsets.only(left: 15, top: 15),
                              child:  Text("Product",
                                style: TextStyle(color: Colors.blue,fontSize: 10,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                            ),

                          ]),

                          Row(children: [

                            Expanded(
                              child: Container(
                                //  padding: EdgeInsets.only(top: 20,bottom: 20,left: 20,right: 20),
                                width: MediaQuery.of(context).size.width,
                                height: 35.0,
                                margin: EdgeInsets.only(left: 15,right: 20),
                                child:DropdownButtonHideUnderline(

                                  child: ButtonTheme(
                                    focusColor: Colors.white,
                                    child: ChangeNotifierProvider<CallProvider>(

                                        create: (context) => CallProvider(),

                                        child: Consumer<CallProvider>(
                                            builder: (context, provider, child){

                                              return DropdownButton(
                                                dropdownColor: Colors.white,
                                                style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                                                // dropdownColor: Colors.grey,
                                                focusColor: Colors.black,
                                                icon: Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: Colors.black,
                                                ),
                                                items: productarr.map((String itemnames) {
                                                  return DropdownMenuItem<String>(

                                                      value: itemnames,
                                                      child: Text(itemnames,textAlign: TextAlign.center,style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700))
                                                  );
                                                }).toList(),

                                                onChanged: (String? value) {
                                                  CallProvider.prodtpye=value!;

                                                  provider.selectActivity();

                                                },
                                                value: CallProvider.prodtpye,
                                              );
                                            }
                                        )


                                    ),
                                  ),
                                ),

                                /* decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,

                            ),*/
                              ),
                            ),
                          ]),

                          Row(children: [

                            Container(
                              margin: EdgeInsets.only(left: 20, top: 5),
                              child:  Text("Notes",
                                style: TextStyle(color: Colors.blue,fontSize: 10,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                            ),

                          ]),

                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 30,
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(
                              // textAlign: TextAlign.center,
                              controller: noteController,
                              validator: noteValidate,
                              style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                              maxLines: 1,
                            ),
                          ),

                          SizedBox(height: 15,),

                        ],
                      ),
                    ),


                    SizedBox(height: 10,),

                    Row(children: [

                      InkWell(
                        onTap: (){
                          validatdation();
                        },
                        child: Container(
                          width: 90,
                          padding: EdgeInsets.only(top: 10,bottom:10),
                          margin: EdgeInsets.only(left: 80,right:10, top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Colors.indigoAccent,
                          ),
                          child:  Center(
                            child: Text("Save",
                              style: TextStyle(color: Colors.white,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                          ),
                        ),
                      ),

                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 90,
                          padding: EdgeInsets.only(top: 10,bottom:10),
                          margin: EdgeInsets.only(left: 10,right:10, top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            border: Border.all(color: Colors.black26),
                            color: Colors.white,
                          ),
                          child:  Center(
                            child: Text("Cancel",
                              style: TextStyle(color: Colors.black,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                          ),
                        ),
                      ),
                    ],),

                    SizedBox(height: 15,),

                  ],),
                ),
              ),



            ],
            ),
          ),
      ),
    );
  }

  void validatdation() {
    if (formkey.currentState!.validate()) {
      getAddCall();
      print("OK");
    //  Navigator.pop(context);
     // getUpdateProfile();
      //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyBottomNavigationBar()));
    } else {
      print("Error");
    }
  }

  selectFromDateAssign(BuildContext context,) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: fromselectedDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2025));

    if (picked != null && picked != fromselectedDate) {
      setState(() {
        fromtime = DateFormat('dd-MM-yyyy').format(picked);
        print("from time prickers : " +fromtime );
       // getAssign();
        Fluttertoast.showToast(
            msg: "Updated Now",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 4,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 12.0
        );

      });
    }
  }

  selectNextDateAssign(BuildContext context,) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: fromnextDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2025));

    if (picked != null && picked != fromselectedDate) {
      setState(() {
        nexttime = DateFormat('dd-MM-yyyy').format(picked);
        print("from time prickers : " +nexttime );
        // getAssign();
        Fluttertoast.showToast(
            msg: "Updated Now",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 4,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 12.0
        );

      });
    }
  }

  Widget addPopUp(){
    return  Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 10,bottom: 10),
        width: 81,
        decoration: BoxDecoration(
           /* border: Border.all(
              color: Colors.blue,
              width: 2.5,
            ),*/
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            Row(children: [

              Container(
                //  margin: EdgeInsets.only(left: 5,top: 5, right: 5),
                child: Image.asset("image/addcall.png",height: 15,width: 16,),
              ),

              Container(
                margin: EdgeInsets.only(left: 7.5,),
                child: Text("Add Call",
                    style: TextStyle(color: Colors.blue,
                      fontSize: 11,
                      fontFamily: 'BebesNeue',
                      fontWeight: FontWeight.w700,)),
              ),

            ],),

            SizedBox(height: 10,),

            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: Colors.grey,
            ),

            SizedBox(height: 10,),

            Row(children: [

              Container(
                //  margin: EdgeInsets.only(left: 5,top: 5, right: 5),
                child: Image.asset("image/addmeeting.png",height: 15,width: 16,),
              ),

              Container(
                margin: EdgeInsets.only(left: 7.5,),
                child: Text("Add Meeting",
                    style: TextStyle(color: Colors.blue,
                      fontSize: 11,
                      fontFamily: 'BebesNeue',
                      fontWeight: FontWeight.w700,)),
              ),

            ],),

            SizedBox(height: 10,),

            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: Colors.grey,
            ),

            SizedBox(height: 10,),

            Row(children: [

              Container(
                //  margin: EdgeInsets.only(left: 5,top: 5, right: 5),
                child: Image.asset("image/addtask.png",height: 15,width: 16,),
              ),

              Container(
                margin: EdgeInsets.only(left: 5,),
                child: Text("Add Task",
                    style: TextStyle(color: Colors.blue,
                      fontSize: 11,
                      fontFamily: 'BebesNeue',
                      fontWeight: FontWeight.w700,)),
              ),

            ],),

            SizedBox(height: 10,),

            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: Colors.grey,
            ),
            SizedBox(height: 10,),

            Row(children: [

              Container(
                //  margin: EdgeInsets.only(left: 5,top: 5, right: 5),
                child: Image.asset("image/viewactivity.png",height: 15,width: 16,),
              ),

              Container(
                margin: EdgeInsets.only(left: 5,),
                child: Text("View Activity",
                    style: TextStyle(color: Colors.blue,
                      fontSize: 11,
                      fontFamily: 'BebesNeue',
                      fontWeight: FontWeight.w700,)),
              ),

            ],),
          ],
        ),
      ),
    );
  }

  Future<List <ResultsAddCall>> getAddCall() async {
    List<ResultsAddCall> logindata = [];

    /*String newurl = AppNetworkConstants.ADDNEW +
        "?calltype=" + CallProvider.activityvalue +
        "&bussinesstype=" + CallProvider.businessvalue +
        "&companyname=" + m_cname +
        "&contactperson=" + m_cperson +
        "&phone=" + m_number +
        "&phonecalltype=" + CallProvider.callvalue +
        "&status=" + CallProvider.statuscallvalue +
        "&date=" +fromtime+
        "&time=" + CallProvider.timevalue +
        "&nextdate=" + nexttime +
        "&nexttime=" + CallProvider.nexttimevalue +
        "&product=" + CallProvider.prodvalue;*/

    String newurl = AppNetworkConstants.ADDCALL;

   // String newurl = "https://inboundcrm.in/travcrm-dev_2.2/Api/App/nikhil/json_addcall.php";

    print("Add Call Url is :"+newurl);

    var res = await http.post(Uri.parse(newurl),

        body: ({
          'calltype': CallProvider.activityvalue,
          'bussinesstype': CallProvider.businessvalue,
          'companyname': m_cname,
          'contactperson':m_cperson,
          'companyPhone':m_number,
          'phonecalltype': CallProvider.callvalue,
          'status': CallProvider.statuscallvalue,
          'date': fromtime,
          'time': CallProvider.timevalue,
          'nextdate': CallProvider.statuscallvalue,
          'nexttime': fromtime,
          'product': CallProvider.timevalue
        })
    );

    print("calltype are : " + CallProvider.activityvalue);
    print("bussinesstype are : " +CallProvider.businessvalue);
    print("companyname are : " + m_cname);
    print("contactperson are : " + m_cperson);
    print("phone are : " + m_number);

    if(res.statusCode==200) {
      var datas = jsonDecode(res.body)['results'] as List;

      logindata = datas.map((data) => ResultsAddCall.fromJson(data)).toList();

    //  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> CallST()));

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return MyCallBottomNavigationBar();
      }));

      Fluttertoast.showToast(
        msg: logindata[0].msg.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 6,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0,
      );
    }else {
      Fluttertoast.showToast(
        msg: "Someting wents wrong",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 6,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0,
      );
    }

    return logindata;
  }

  Future<List <ResultsAllName>> getAllNames() async{

    String newurl=AppNetworkConstants.ALLNAMES;

  //  String newurl= "https://inboundcrm.in/travcrm-dev_2.2/Api/App/nikhil/json_showcall.php";

    print("All Names Url is : "+ newurl.toString());

    var url= Uri.parse(newurl);

    http.Response res = await http.get(url);

    print("All Names Response is : "+ res.body);

    var datas= jsonDecode(res.body)['results'] as List;

    List<ResultsAllName> agentdata = datas.map((data) => ResultsAllName.fromJson(data)).toList();

    return agentdata;
  }

  getUpdate(){
    setState(() {
      getAllNames();
    });
  }

  Widget getAllNameWidget(){


    return  ChangeNotifierProvider(
        create: (context) => NameProvider(),

        child: Consumer<NameProvider>(
            builder: (context, provider, child){

              return  Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 10),
                  height: 175,

                  padding: EdgeInsets.only(left: 10,right: 10,top: 0,bottom:15),


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

                  child: Column(
                    children: [

                      Expanded(child:  RawScrollbar(
                        thumbColor: Colors.blueAccent,
                        radius: Radius.circular(20),
                        thickness: 7.5,
                        child: ListView.builder(
                          //  padding: EdgeInsets.only(top: 15),
                            itemCount: allnamemodels!.length,
                            itemBuilder: (context,index){
                              ResultsAllName itemslists =allnamemodels![index];

                              late String position =itemslists.name.toString();

                              if(searchController.text.isEmpty){
                                return Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  //  height: 500,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),

                                    //  color: Colors.deepOrange,


                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,children: [

                                    InkWell(
                                      onTap:(){
                                        print("is click");

                                        mypos=allnamemodels!.indexOf(itemslists);
                                        selectedNames = itemslists;

                                        m_cname =itemslists.name.toString();
                                        m_cperson =itemslists.contactPerson.toString();
                                        m_number =itemslists.contactNo.toString();

                                        print("Contact number is : "+m_number);
                                        print("Contact person is : "+m_cperson);
                                        print("Contact Name is : "+m_cname);

                                        provider.selectUserSearch(m_number, m_cname, m_cperson,selectedNames,mypos);


                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(left: 10, top: 10),
                                        child:  Text(itemslists.name.toString(),
                                          style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                                      ),
                                    ),


                                  ],),
                                );
                              }else if(position.toLowerCase().contains(searchController.text.toLowerCase())){
                                return Container(
                                  margin: EdgeInsets.only(bottom: 5),
                                  //  height: 500,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    //  borderRadius: BorderRadius.circular(5),

                                    //  color: Colors.deepOrange,


                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,children: [

                                    InkWell(
                                      onTap:(){
                                        print("is click");

                                        mypos=allnamemodels!.indexOf(itemslists);
                                        selectedNames = itemslists;

                                        m_cname =itemslists.name.toString();
                                        m_cperson =itemslists.contactPerson.toString();
                                        m_number =itemslists.contactNo.toString();

                                        print("Contact number is : "+m_number);
                                        print("Contact person is : "+m_cperson);
                                        print("Contact Name is : "+m_cname);

                                        provider.selectUserSearch(m_number, m_cname, m_cperson,selectedNames,mypos);


                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(left: 10, top: 10),
                                        child:  Text(itemslists.name.toString(),
                                          style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                                      ),
                                    ),


                                  ],),
                                );
                              }
                              else{
                                return Container();
                              }


                            }
                        ),
                      ),

                      ),

                      SizedBox(height: 10,),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [

                            Container(

                              child: Column(children: [

                                Container(
                                  width: 100,
                                  margin: EdgeInsets.only(left: 5,right: 5, top: 5),
                                  child:  Text("Contact Person",
                                    style: TextStyle(color: Colors.blue,fontSize: 10,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                                ),

                                Container(
                                  width: 100,
                                  margin: EdgeInsets.only(left: 5, right: 5,top: 5),
                                  child: Text(m_cperson,
                                    style: TextStyle(color: Colors.black54,fontSize: 10,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),maxLines: 1,),
                                ),

                                SizedBox(height: 15,),

                              ],),
                            ),

                            Container(
                              child: Column(children: [
                                Container(
                                  width: 100,
                                  margin: EdgeInsets.only(left: 10,right: 5, top: 5),
                                  child:  Text("Contact Number",
                                    style: TextStyle(color: Colors.blue,fontSize: 10,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                                ),

                                Container(
                                  width: 100,
                                  margin: EdgeInsets.only(left: 10, right: 5,top: 5),
                                  child: Text(m_number,
                                    style: TextStyle(color: Colors.black54,fontSize: 10,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),maxLines: 1,),
                                ),

                                SizedBox(height: 15,),


                              ],),
                            ),

                            InkWell(
                              onTap:(){
                                callnumber=m_number;
                                RegExp regExp = new RegExp(patttern);
                                if(callnumber==""){
                                  Fluttertoast.showToast(
                                      msg: "Please Enter Mobile No",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 12.0
                                  );
                                }else if(!regExp.hasMatch(callnumber)){
                                  Fluttertoast.showToast(
                                      msg: "Please Enter valid Mobile No",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 12.0
                                  );
                                }else{
                                  _makingPhoneCall();
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(top:0,left: 10,),
                                child: Image.asset("image/callblue.png",height: 22, width: 24,),
                              ),
                            ),

                            InkWell(
                              onTap:(){
                                whatsappnumber=m_number;
                                RegExp regExp = new RegExp(patttern);
                                if(whatsappnumber==""){
                                  Fluttertoast.showToast(
                                      msg: "Please Enter Mobile No",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 12.0
                                  );
                                }else if(!regExp.hasMatch(whatsappnumber)){
                                  Fluttertoast.showToast(
                                      msg: "Please Enter valid Mobile No",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 12.0
                                  );
                                }else{
                                  _makingWhatsapp();
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(top:0,left: 10,right: 10),
                                child: Image.asset("image/whatsapp.png",height: 26, width: 26.5,),
                              ),
                            ),
                          ],
                        ),
                      ),


                    ],

                  )


              );

            }
        )
    );

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