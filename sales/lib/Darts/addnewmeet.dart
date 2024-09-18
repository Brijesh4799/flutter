
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
import 'package:salescrm/Models/addnewcallmodel.dart';
import 'package:salescrm/Models/addnewmeetmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:pie_chart/pie_chart.dart';


import '../Apis/apis.dart';
import '../Models/addnewmodel.dart';
import '../Providers/callprovider.dart';
import 'calltodaydata.dart';
import 'data.dart';
import 'items.dart';

class AddNewMeetST extends StatefulWidget {

  @override
  State createState() => new MyAddNewMeetST();
}

class MyAddNewMeetST extends State<AddNewMeetST> {

  late SharedPreferences prefs,preflog_in_out;

  GlobalKey<ScaffoldState> _drawerkey= GlobalKey<ScaffoldState>();

  var companyarr=["Agent","B2C"];

  var operationarr=["Sales","Accounts","Operations","FIT Reservation","GIT Reservation"];

  GlobalKey<FormState> formkeyall = GlobalKey<FormState>();

  var companyController = TextEditingController();
  var companyup = "";

  var nameController = TextEditingController();
  var nameup = "";

  var desiController = TextEditingController();
  var desiup = "";

  var phoneController = TextEditingController();
  var phoneup = "";

  var emailController = TextEditingController();
  var emailup = "";

  var addressController = TextEditingController();
  var addressup = "";

  String? companyValidate(String? value) {
    if (value == null || value.isEmpty)
      return 'Enter a Company';
    else
      companyup = value;
    print("Company : " + companyup);
    return null;
  }

  String? desiValidate(String? value) {
    if (value == null || value.isEmpty)
      return 'Enter a Designation';
    else
      desiup = value;
    print("notes : " + desiup);
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

  String? emailValidate(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value))
      return 'Enter a valid email address';
    else
      emailup = value;
    print("Email Id is : " + emailup);
    return null;
  }

  String? addressValidate(String? value) {
    if (value == null || value.isEmpty)
      return 'Enter a Address';
    else
      addressup = value;
    print("name : " + addressup);
    return null;
  }


  File? file1;

  XFile? image1;

  bool isFile1=false;

  bool isPic1=true;

  void pickImage1() async{
    image1 = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 100);

    if(image1!=null){
      setState(() {
        file1=File(image1!.path);
        isFile1=true;
        isPic1=false;
      });
    }
    else{
      isFile1=false;
      isPic1=true;
    }

    /*if(file1!=null){
      isFile1=true;
      isPic1=false;
    }
    else{
      isFile1=false;
      isPic1=true;
    }*/
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("add new");
    print("Business type is : "+CallProvider.companyvalue);
    print("Contact Person type is : "+CallProvider.companyvalue);

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
                        child: Text("Add New",
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

                      Row(children: [

                        Container(
                          margin: EdgeInsets.only(left: 15, top: 15),
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
                                            focusColor: Colors.black54,
                                            icon: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.black,
                                            ),
                                            items: companyarr.map((String itemnames) {
                                              return DropdownMenuItem<String>(

                                                  value: itemnames,
                                                  child: Text(itemnames,textAlign: TextAlign.center,style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700))
                                              );
                                            }).toList(),

                                            onChanged: (String? value) {
                                              CallProvider.companytpye=value!;

                                              provider.selectCompany();

                                            },
                                            value: CallProvider.companytpye,
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
                          child:  Text("Company Name",
                            style: TextStyle(color: Colors.blue,fontSize: 10,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                        ),


                      ]),

                      Form(
                        key: formkeyall,
                        child: Column(
                          children: [

                            SizedBox(height: 10,),

                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 30,
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                // textAlign: TextAlign.center,
                                controller: companyController,
                                validator: companyValidate,
                                style: TextStyle(color: Colors.blue,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintText: "Name",

                                ),
                              ),
                            ),


                            SizedBox(height: 10,),

                            Row(children: [

                              Container(
                                margin: EdgeInsets.only(left: 15, top: 15),
                                child:  Text("Contact Person",
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
                                                  style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                                                  // dropdownColor: Colors.grey,
                                                  focusColor: Colors.black,
                                                  icon: Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: Colors.black,
                                                  ),
                                                  items: operationarr.map((String itemnames) {
                                                    return DropdownMenuItem<String>(

                                                        value: itemnames,
                                                        child: Text(itemnames,textAlign: TextAlign.center,style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700))
                                                    );
                                                  }).toList(),

                                                  onChanged: (String? value) {
                                                    CallProvider.operationtpye=value!;

                                                    provider.selectOperation();

                                                  },
                                                  value: CallProvider.operationtpye,
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


                            ]),

                            SizedBox(height: 10,),

                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 30,
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                // textAlign: TextAlign.center,
                                controller: nameController,
                                validator: nameValidate,
                                style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintText: "Name",

                                ),
                              ),
                            ),

                            SizedBox(height: 15,),

                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 30,
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                // textAlign: TextAlign.center,
                                controller: desiController,
                                validator: desiValidate,
                                style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintText: "Designation",

                                ),
                              ),
                            ),

                            SizedBox(height: 35,),

                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 30,
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                // textAlign: TextAlign.center,
                                controller: phoneController,
                                validator: phoneValidate,
                                style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                decoration: InputDecoration(
                                  hintText: "Phone",

                                ),
                              ),
                            ),

                            SizedBox(height: 15,),

                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 30,
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                // textAlign: TextAlign.center,
                                controller: emailController,
                                validator: emailValidate,
                                style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintText: "E-Mail",

                                ),
                              ),
                            ),

                            SizedBox(height: 15,),

                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 30,
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                // textAlign: TextAlign.center,
                                controller: addressController,
                                validator: addressValidate,
                                style: TextStyle(color: Colors.black,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintText: "Address",

                                ),
                              ),
                            ),

                          ],
                        ),
                      ),



                      Row(children: [

                        Container(
                          margin: EdgeInsets.only(left: 15, top: 25),
                          child:  Text("Attach Business Card",
                            style: TextStyle(color: Colors.black54,fontSize: 12,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),),
                        ),

                        Spacer(),

                        InkWell(
                          onTap: (){
                            pickImage1();
                          },
                          child: Container(

                            child: Row(children: [
                              Container(
                                margin: EdgeInsets.only(top:20,left: 0,),
                                child: Image.asset("image/attachvisit.png",height: 22, width: 28,),
                              ),

                              Container(
                                margin: EdgeInsets.only(top:20,left: 5,right: 15),
                                child: Image.asset("image/addvisit.png",height: 20, width: 25,),
                              ),
                            ],),
                          ),
                        )



                      ]),



                      SizedBox(height: 30,),

                      Row(children: [

                        InkWell(
                          onTap: (){
                           validatdationAll();
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
      getAddNewMeet();
    //  Navigator.pop(context);
      //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyBottomNavigationBar()));
    } else {
      print("Error");
    }
  }

  Future<List <ResultsAddNewMeet>> getAddNewMeet() async {

     String newurl = AppNetworkConstants.ADDNEWMEET;

  //  String newurl = "https://inboundcrm.in/travcrm-dev_2.2/Api/App/nikhil/json_addnewmeeting.php";

    List<ResultsAddNewMeet> imgdata=[];
    print("AddNewMeet URL : " + newurl);

    var stream = new http.ByteStream(file1!.openRead());
    stream.cast();

    var length = await file1!.length();
    print("Lenght is : "+length.toString());

    var uri = Uri.parse(newurl);

    var request = new http.MultipartRequest('POST', uri);

    request.fields['bussinesstype'] = CallProvider.companyvalue;
    request.fields['companyname'] = companyController.text.trim();
    request.fields['contactperson'] = CallProvider.operationvalue;
    request.fields['name'] = nameController.text.trim();
    request.fields['designation'] = desiController.text.trim();
    request.fields['phone'] = phoneController.text.trim();
    request.fields['email'] =  emailController.text.trim();
    request.fields['address'] = addressController.text.trim();

    var multiport = new http.MultipartFile(
        'img',
        stream,
        length,
        filename: file1.toString());

    request.files.add(multiport);

    /* var res = await request.send();
    print("Response of Pan Card Images are : " +res.stream.toString());

     var responsed = await http.Response.fromStream(res);
    */

    var res = await request.send();

    if(res.statusCode == 200){

      print("Response of AddNewMeet Images are :  ${res.statusCode}");

      Fluttertoast.showToast(
        msg: "Data Saved Sucessfully",
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