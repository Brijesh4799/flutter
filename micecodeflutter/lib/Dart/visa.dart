import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/feedimgmodel.dart';
import '../Models/visaimgmodel.dart';
import '../Utils/Apis.dart';


class VisaSL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Visa(),
    );
  }
}

class Visa extends StatefulWidget {

  @override
  State createState() => MyVisa();
}

class MyVisa extends State<Visa> {

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
                  child: Text("Visa",
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
        margin: EdgeInsets.only(bottom: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
         children: [

           Container(
             child: Image.asset("image/visamice.png",height: 70, width: 70,),
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

           InkWell(onTap: (){

             if(file1!=null){
               getVisaImg();
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
           /*if(file!=null)
             Image.file(file,width: double.infinity,height: 250.0,fit: BoxFit.cover,),*/
         ],
        ),
      )




    );
  }


  Future<List <ResultsVisa>> getVisaImg() async {

    String newurl = TravApis.VISAIMG;
    List<ResultsVisa> imgdata=[];
    print("Visa Image URL : " + newurl);

    var stream = new http.ByteStream(file1!.openRead());
    stream.cast();

    var length = await file1!.length();
    print("Lenght is : "+length.toString());

    var uri = Uri.parse(newurl);

    var request = new http.MultipartRequest('POST', uri);

    request.fields['RefId'] = RefID;
    request.fields['queryId'] = queryID;

    var multiport = new http.MultipartFile(
    'img1',
    stream,
    length,
    filename: file1.toString());

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

   //   print("Response of Pan Card are decoded :  " +responsedData);
     // print("Visa Uploaded Successfully"+ res.body);
      Fluttertoast.showToast(
        msg: "Visa hasbeen Uploaded Sucessfully",
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
