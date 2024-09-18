
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:pie_chart/pie_chart.dart';


import '../Apis/apis.dart';
import '../Models/addexpmodel.dart';
import '../Providers/callprovider.dart';
import 'calltodaydata.dart';
import 'data.dart';
import 'items.dart';

class AddExpenseST extends StatefulWidget {

  @override
  State createState() => new MyAddExpenseST();
}

class MyAddExpenseST extends State<AddExpenseST> {

  File? file1;

  XFile? image1;

  bool isFile1=false;

  bool isPic1=true;



  late SharedPreferences prefs,preflog_in_out;

  DateTime fromselectedDate = DateTime.now();
  static String fromtime = DateFormat('dd-MM-yyyy').format(DateTime.now());

  GlobalKey<ScaffoldState> _drawerkey= GlobalKey<ScaffoldState>();

  var companyarr=["Agent","Call"];

  var operationarr=["Operations","Sales",];



  GlobalKey<FormState> formkeyall = GlobalKey<FormState>();

  var typeController = TextEditingController();
  var typeup = "";

 /* var nameController = TextEditingController();
  var nameup = "";*/

  var noteController = TextEditingController();
  var noteup = "";

  var amtController = TextEditingController();
  var amtup = "";

  String? typeValidate(String? value) {
    if (value == null || value.isEmpty)
      return 'Enter a Expense Type';
    else
      typeup = value;
    print("Expense Type : " + typeup);
    return null;
  }

  String? amountValidate(String? value) {
    if (value == null || value.isEmpty)
      return 'Enter a Amount';
    else
      amtup = value;
    print("Amount : " + amtup);
    return null;
  }

  String? noteValidate(String? value) {
    if (value == null || value.isEmpty)
      return 'Enter a Expense Note';
    else
      noteup = value;
    print("Note : " + noteup);
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


    return Scaffold(


        body:  Padding(
            padding: EdgeInsets.all(0),

            child:   Container(
              child: Column(children: [

                Container(
                  margin: EdgeInsets.only(top: 35),
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
                        child: Text("Add Expense",
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

                      Form(
                        key: formkeyall,
                        child: Column(
                          children: [

                            Row(children: [

                              Container(
                                margin: EdgeInsets.only(left: 15, top: 10),
                                child:  Text("Expense Type",
                                  style: TextStyle(color: Colors.blue,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                              ),


                            ]),

                            SizedBox(height: 15,),

                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 30,
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                // textAlign: TextAlign.center,
                                controller: typeController,
                                validator: typeValidate,
                                style: TextStyle(color: Colors.blue,fontSize: 13,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintText: "Type",

                                ),
                              ),
                            ),


                            SizedBox(height: 30,),

                            Row(children: [

                              Container(
                                margin: EdgeInsets.only(left: 20,),
                                child: Text("Date : ",
                                    style: TextStyle(color: Colors.grey,
                                      fontSize: 11,
                                      fontFamily: 'BebesNeue',
                                      fontWeight: FontWeight.w700,)),
                              ),

                            ]),

                            SizedBox(height: 15,),

                            InkWell(
                              onTap: (){selectExpenseDateAssign(context);},
                              child: Row(children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20,),
                                  child: Text(fromtime,
                                      style: TextStyle(color: Colors.black,
                                        fontSize: 13,
                                        fontFamily: 'BebesNeue',
                                        fontWeight: FontWeight.w700,)),
                                ),
                              ],),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 20, right: 20, top: 5),
                              color: Colors.grey,
                              width: MediaQuery.of(context).size.width,
                              height: 1,
                            ),

                            SizedBox(height: 30,),

                            Row(children: [

                              Container(
                                margin: EdgeInsets.only(left: 15, top: 10),
                                child:  Text("Claim Amount",
                                  style: TextStyle(color: Colors.blue,fontSize: 11,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                              ),


                            ]),

                            SizedBox(height: 15,),


                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 30,
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                keyboardType:TextInputType.number,
                                // textAlign: TextAlign.center,
                                controller: amtController,
                                validator: amountValidate,
                                style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintText: "Amount",

                                ),
                              ),
                            ),

                            SizedBox(height: 15,),

                            Row(children: [

                              Container(
                                margin: EdgeInsets.only(left: 15, top: 10),
                                child:  Text("Expense Note",
                                  style: TextStyle(color: Colors.grey,fontSize: 16,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                              ),


                            ]),

                            SizedBox(height: 20,),

                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 30,
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                // textAlign: TextAlign.center,
                                controller: noteController,
                                validator: noteValidate,
                                style: TextStyle(color: Colors.blue,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintText: "Note",

                                ),
                              ),
                            ),

                          ],
                        ),
                      ),



                      Row(children: [

                        Container(
                          margin: EdgeInsets.only(left: 15, top: 25),
                          child:  Text("Expense Attachment",
                            style: TextStyle(color: Colors.blue,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                        ),

                      ]),

                      InkWell(
                        onTap: (){
                         pickImage();
                        },
                        child: Row(children: [

                          Visibility(
                            visible: isPic1,
                            child: Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Image.asset("image/addvisit.png",height: 80, width: 80,),
                            ),
                          ),

                          if(file1!=null)
                            Visibility(
                              visible: isFile1,
                              child: Container(
                                margin: EdgeInsets.only(left: 20,top: 5),
                                child: Image.file(file1!,width: 100,height: 80,),
                              ),
                            ),

                        ],),
                      ),



                      SizedBox(height: 30,),

                      Row(children: [

                        InkWell(
                          onTap: (){
                            if (formkeyall.currentState!.validate()) {
                              print("OK");
                              getAddExp();
                            //  Navigator.of(context).pop();
                            } else {
                              print("Error");
                            }
                          },
                          child: Container(
                            width: 90,
                            padding: EdgeInsets.only(top: 10,bottom:10),
                            margin: EdgeInsets.only(left: 80,right:10, top: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              color: Colors.indigo,
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

                      SizedBox(height: 20,),

                    ],),
                  ),
                ),

                

              ],
              ),
            ))
    );
  }

  void validatdationAll() {
    if (formkeyall.currentState!.validate()) {
      print("OK");
     // getUpdateProfile();
      //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyBottomNavigationBar()));
    } else {
      print("Error");
    }
  }

  selectExpenseDateAssign(BuildContext context,) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: fromselectedDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2025));

    if (picked != null && picked != fromselectedDate) {
      setState(() {
        fromtime = DateFormat('dd-MMM-yyyy').format(picked);
        print("from time prickers : " + fromtime);
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

  void pickImage() async{
    image1 = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(image1!=null){
      setState(() {
        file1=File(image1!.path);
        isFile1=true;
        isPic1=false;
      });
    } else{
      isFile1=false;
      isPic1=true;
    }
  }

  Future<List <ResultsAddExp>> getAddExp() async {

    String newurl = AppNetworkConstants.ADDEXP;
  //  String newurl = "https://inboundcrm.in/travcrm-dev_2.2/Api/App/SALES/json_addexpense.php";
    List<ResultsAddExp> imgdata=[];
    print("Add Exp URL : " + newurl);

    var stream = new http.ByteStream(file1!.openRead());
    stream.cast();

    var length = await file1!.length();
    print("Lenght is : "+length.toString());

    var uri = Uri.parse(newurl);

    var request = new http.MultipartRequest('POST', uri);

    request.fields['type'] = typeController.text.trim();
    request.fields['date'] = fromtime;
    request.fields['amt'] = amtController.text.trim();
    request.fields['note'] = noteController.text.trim();

    var multiport = new http.MultipartFile(
        "img",
        stream,
        length,
        filename: file1.toString().trim());

    request.files.add(multiport);

    var res = await request.send();

    /* var res = await request.send();
    print("Response of Pan Card Images are : " +res.stream.toString());

     var responsed = await http.Response.fromStream(res);
    */

    // var res = await http.Response.fromStream(await request.send());
    //  print("Response of Pan Card Images are :  ${res.statusCode}");
    //  print("Response of Pan Card are :  ${res.body}");


    if(res.statusCode == 200){
       Navigator.of(context).pop();
      //   print("Response of Pan Card are decoded :  " +responsedData);
      // print("Visa Uploaded Successfully"+ res.body);
      Fluttertoast.showToast(
        msg: "Expense Added Successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0,
      );
    }else{
      print("failed");
    }


    return imgdata;

  }

}