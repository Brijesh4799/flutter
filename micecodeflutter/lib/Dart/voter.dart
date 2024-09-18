import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/feedimgmodel.dart';
import '../Models/panimgmodel.dart';
import '../Models/voterimgmodel.dart';
import '../Utils/Apis.dart';


class VoterSL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Voter(),
    );
  }
}

class Voter extends StatefulWidget {

  @override
  State createState() => MyVoter();
}

class MyVoter extends State<Voter> {

  late SharedPreferences prefRefid,prefqueryId;

  String RefID="";
  String queryID="";

  File? file1, file2;

  XFile? image1,image2;

  bool isFile1=false;
  bool isFile2=false;

  bool isPic1=true;
  bool isPic2=true;




  void pickImage1() async{
    image1 = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 100);

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

  void pickImage2() async{
    image2 = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 100);

    if(image2!=null){
      setState(() {
        file2=File(image2!.path);
        isFile2=true;
        isPic2=false;
      });
    } else{
      isFile2=false;
      isPic2=true;
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
                  child: Text("Voter-ID Card",
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
          margin: EdgeInsets.only(bottom: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                child: Image.asset("image/voterid_mice.png",height: 80, width: 80,),
              ),

              SizedBox(height: 20,),

              Row(children: [

                Expanded(
                  flex: 1,
                  child: InkWell(
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
                              padding: EdgeInsets.only(top: 20,bottom: 20),
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
                            child : Text("Front Image",
                                style: TextStyle(color: Colors.black,fontSize: 14,
                                    fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                          ),

                        ],

                      ),
                    ),
                  ),
                ),

                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: (){
                      pickImage2();
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
                            visible: isPic2,
                            child: Container(
                              padding: EdgeInsets.only(top: 20,bottom: 20),
                              margin: EdgeInsets.only(top: 5),
                              child: Image.asset("image/plusmice.png",height: 75, width: 75,),
                            ),
                          ),

                          if(file2!=null)
                            Visibility(
                              visible: isFile2,
                              child: Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Image.file(file2!,width: double.infinity,height: 120,),
                              ),
                            ),

                          Container(

                            margin: EdgeInsets.only(top: 10,bottom: 10),
                            child : Text("Back Image",
                                style: TextStyle(color: Colors.black,fontSize: 14,
                                    fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                          ),

                        ],

                      ),
                    ),
                  ),
                ),

              ],
              ),

              SizedBox(height: 35),

              InkWell(onTap: (){

                if(file1!=null && file2!=null){
                  getVoterImg();
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


  Future<List <ResultsVoter>> getVoterImg() async {

    String newurl = TravApis.VOTERIMG;

   // String newurl = "https://inboundcrm.in/travcrm-dev_2.2/Api/App/MICE/json_voter.php";

    List<ResultsVoter> imgdata=[];
    print("Voter Id Image URL : " + newurl);

    // For Image1
    var stream = new http.ByteStream(file1!.openRead());
    stream.cast();

    var length = await file1!.length();
    print("Lenght is : "+length.toString());

    // For Image2
    var stream2 = new http.ByteStream(file2!.openRead());
    stream2.cast();

    var length2 = await file2!.length();
    print("Lenght2 is : "+length2.toString());

    var uri = Uri.parse(newurl);

    var request = new http.MultipartRequest('POST', uri);

    request.fields['RefId'] = RefID;
    request.fields['queryId'] = queryID;

    var multiport = new http.MultipartFile(
        'img1',
        stream,
        length,
        filename: file1.toString());

    var multiport2 = new http.MultipartFile(
        'img2',
        stream2,
        length2,
        filename: file2.toString());

    //  http.MultipartFile multiparfile = await http.MultipartFile.fromPath('img1',file1.toString());
    request.files.add(multiport);
    request.files.add(multiport2);

    var res = await request.send();
    print("Response of Images are : " +res.stream.toString());

    /* http.StreamedResponse res= await request.send();

    print("Response of Images are : " +res.toString());*/

    if(res.statusCode == 200){
      print("Voter Images Uploaded Successfully");
      Fluttertoast.showToast(
        msg: "Images Uploaded Sucessfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0,
      );
    }else{
      Fluttertoast.showToast(
        msg: "Images Can't Uploaded, Minimum Required 300kbps Size",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0,
      );
    }

    return imgdata;

  }
}
