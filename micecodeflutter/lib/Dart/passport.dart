import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/feedimgmodel.dart';
import '../Models/passportimgmodel.dart';
import '../Utils/Apis.dart';



class PassportSL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Passport(),
    );
  }
}

class Passport extends StatefulWidget {

  @override
  State createState() => MyPassport();
}

class MyPassport extends State<Passport> {

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  var passno = "";

  var passportNo = TextEditingController();

  String? passportValidate(String? value) {
    if (value == null || value.isEmpty)
      return "Enter a Pass-Port-No";
    else
      passno = value;
    print("Email Id is : " + passno);
    return null;
  }


  static String issuetime= DateFormat('dd-MMM-yyyy').format(DateTime.now());

  DateTime fromIssueDate = DateTime.now();

  static String exptime= DateFormat('dd-MMM-yyyy').format(DateTime.now());

  DateTime fromExpDate = DateTime.now();

  late SharedPreferences prefRefid,prefqueryId;

  String RefID="";
  String queryID="";

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
  }

  getMyRefId() async {
    prefRefid = await SharedPreferences.getInstance();
    prefqueryId = await SharedPreferences.getInstance();
    setState(() {
      RefID = prefRefid.getString("refid")!;
      queryID = prefqueryId.getString("queryId")!;
    });
  }

  @override
  void initState() {
    getMyRefId();
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
                  //   margin: EdgeInsets.only(right: 5),
                  child: Text("PassPort",
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
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
         children: [

           Expanded(

             child: SingleChildScrollView(
               child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [

                 Container(
                   child: Image.asset("image/passportmice.png",height: 80, width: 60,),
                 ),

                 SizedBox(height: 20,),

                 InkWell(
                   onTap: (){
                       pickImage1();
                   },
                   child: Container(
                     margin: EdgeInsets.only(left: 10,right: 5),
                     decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(10),
                         border: Border.all(color: Colors.blue,width: 3.0)
                     ),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [

                         Visibility(
                           visible: isPic1,
                           child: Container(
                             padding: EdgeInsets.only(left: 40,right:40,top: 20,bottom: 20),
                             margin: EdgeInsets.only(top: 5),
                             child: Image.asset("image/plusmice.png",height: 75, width: 75,),
                           ),
                         ),

                         if(file1!=null)
                           Visibility(
                             visible: isFile1,
                             child: Container(
                               margin: EdgeInsets.only(top: 5),
                               child: Image.file(file1!,width: double.infinity,height: 120,),
                             ),
                           ),

                         Container(

                           margin: EdgeInsets.only(top: 10,bottom: 10),
                           child : Text("Select Image",
                               style: TextStyle(color: Colors.black,fontSize: 14,
                                   fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                         ),

                       ],

                     ),
                   ),
                 ),

                 SizedBox(height: 35),

                 Container(
                     margin: EdgeInsets.only(left: 15,right: 15),
                     child: Row(
                       children: [
                         // passport no
                         Form(
                           key: formkey,
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             mainAxisAlignment: MainAxisAlignment.start,
                             children: [

                               Container(
                                 margin: EdgeInsets.only(left: 5),
                                 child: Text("Passport Number",
                                   style: TextStyle(color: Colors.grey,
                                       fontSize: 9,
                                       fontFamily: 'BebesNeue',
                                       fontWeight: FontWeight.w700),),
                               ),

                               Container(
                                 margin: EdgeInsets.only(top: 5),
                                 decoration: BoxDecoration(
                                   // color: Colors.blue,
                                   borderRadius: BorderRadius.circular(10),
                                   border: Border.all(color: Colors.lightBlueAccent,width: 1.0),

                                 ),
                                 width: 90,
                                 height: 30,
                                 child: TextFormField(
                                   textAlign: TextAlign.center,
                                   controller: passportNo,
                                   style: TextStyle(fontSize: 10),
                                   decoration: InputDecoration(
                                     // hintText: "PassPort No",
                                     hintStyle: TextStyle(fontSize: 10),
                                     border: InputBorder.none,

                                   ),
                                   validator: passportValidate,
                                 ),

                               ),

                             ],),
                         ),

                         Spacer(),

                         //issue date
                         Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [


                             Container(
                               margin: EdgeInsets.only(left: 5),
                               child: Text("Issue Date",
                                   style: TextStyle(color: Colors.grey,fontSize: 10,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                             ),

                             // 1
                             SizedBox(
                               height: 5,
                             ),

                             Container(
                               decoration: BoxDecoration(
                                 // color: Colors.blue,
                                 borderRadius: BorderRadius.circular(10),
                                 border: Border.all(color: Colors.lightBlueAccent,width: 1.0),

                               ),
                               width: 100,
                               height: 30,
                               child: Row(children: [
                                 InkWell(
                                   onTap: (){
                                     selectIssueDate(context);
                                   },
                                   child: Container(
                                     margin: EdgeInsets.only(left: 10,right: 0),
                                     child: Text(issuetime,
                                         style: TextStyle(color: Colors.grey,fontSize: 8,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                                   ),
                                 ),

                                 Spacer(),

                                 InkWell(
                                   onTap: (){
                                     selectIssueDate(context);
                                   },
                                   child: Container(
                                     margin: EdgeInsets.only(right: 5),
                                     child: Image.asset("image/calendarmice.png", height: 13.0, width: 13),
                                   ),
                                 ),
                               ],),
                             ),

                           ],
                         ),

                         Spacer(),

                         Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [


                             Container(
                               margin: EdgeInsets.only(left: 5),
                               child: Text("Expiry Date",
                                   style: TextStyle(color: Colors.grey,fontSize: 10,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                             ),

                             // 1
                             SizedBox(
                               height: 5,
                             ),

                             Container(
                               decoration: BoxDecoration(
                                 // color: Colors.blue,
                                 borderRadius: BorderRadius.circular(10),
                                 border: Border.all(color: Colors.lightBlueAccent,width: 1.0),

                               ),
                               width: 100,
                               height: 30,
                               child: Row(children: [
                                 InkWell(
                                   onTap: (){
                                     selectExpDate(context);
                                   },
                                   child: Container(
                                     margin: EdgeInsets.only(left: 10,right: 0),
                                     child: Text(exptime,
                                         style: TextStyle(color: Colors.grey,fontSize: 8,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                                   ),
                                 ),

                                 Spacer(),

                                 InkWell(
                                   onTap: (){
                                     selectExpDate(context);
                                   },
                                   child: Container(
                                     margin: EdgeInsets.only(right: 5),
                                     child: Image.asset("image/calendarmice.png", height: 13.0, width: 13),
                                   ),
                                 ),
                               ],),
                             ),

                           ],
                         ),

                       ],
                     )),

                 SizedBox(height: 35,),

                 InkWell(onTap: (){

                   if(file1!=null){
                     getPassPortImg();
                   }
                   else{
                     Fluttertoast.showToast(
                         msg: "Select Images !...",
                         toastLength: Toast.LENGTH_SHORT,
                         gravity: ToastGravity.BOTTOM,
                         timeInSecForIosWeb: 3,
                         backgroundColor: Colors.black,
                         textColor: Colors.white,
                         fontSize: 12.0
                     );
                   }
                 },
                   child: Container(
                     //   height:,
                     width: 150,
                     padding: EdgeInsets.only(top: 15, bottom: 15, left: 20,right: 20),
                     decoration: BoxDecoration(
                       color: Colors.lightBlue,
                       borderRadius: BorderRadius.circular(5),
                       //   border: Border.all(color: Colors.lightBlue,width: 1.0)
                     ),
                     child: Center(
                       child: Text("Upload Images",
                         style: TextStyle(color: Colors.white,
                             fontSize: 14,
                             fontFamily: 'BebesNeue',
                             fontWeight: FontWeight.w700),
                       ),
                     ),
                   ),
                 ),

               ]),
             ),
           ),

           /*if(file!=null)
             Image.file(file,width: double.infinity,height: 250.0,fit: BoxFit.cover,),*/
         ],
        ),
      )

    );
  }


  Future<List <ResultsPassPort>> getPassPortImg() async {

    String newurl = TravApis.PASSPORTIMG;
    List<ResultsPassPort> imgdata=[];
    print("FeedBack Image URL : " + newurl);

    var stream = new http.ByteStream(file1!.openRead());
    stream.cast();

    var length = await file1!.length();
    print("Lenght is : "+length.toString());

    var uri = Uri.parse(newurl);

    var request = new http.MultipartRequest('POST', uri);

    request.fields['RefId'] = RefID;
    request.fields['queryId'] = queryID;
    request.fields['passportno'] = passportNo.toString().trim();
    request.fields['passissueDate'] = issuetime;
    request.fields['passexDate'] = exptime;

    var multiport = new http.MultipartFile(
    'img1',
    stream,
    length,
    filename: file1.toString());

    request.files.add(multiport);

    var res = await request.send();
    print("Response of Images are : " +res.stream.toString());

    if(res.statusCode == 200){
      print("Image Upload");
      Fluttertoast.showToast(
        msg: "Passport Details Uploaded With Image Sucessfully",
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


  void validate() {
    if (formkey.currentState!.validate()) {
      print("OK");
      //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyBottomNavigationBar()));
    } else {
      print("Error");
    }
  }

  selectIssueDate(BuildContext context,) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: fromIssueDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2025));

    if (picked != null && picked != fromIssueDate) {
      setState(() {
        issuetime = DateFormat('dd-MMM-yyyy').format(picked);
        print("Issue time prickers : " +issuetime);
        //  getDuty();


      });
    }
  }

  selectExpDate(BuildContext context,) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: fromExpDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2025));

    if (picked != null && picked != fromExpDate) {
      setState(() {
        exptime = DateFormat('dd-MMM-yyyy').format(picked);
        print("Expiry time prickers : " +exptime);
        //  getDuty();


      });
    }
  }

}
