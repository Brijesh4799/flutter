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
import '../Utils/Apis.dart';



class PicturesSL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Pictures(),
    );
  }
}

class Pictures extends StatefulWidget {

  @override
  State createState() => MyPictures();
}

class MyPictures extends State<Pictures> {

  late SharedPreferences prefRefid,prefqueryId;

  String RefID="";
  String queryID="";

  File? file1, file2, file3, file4;

  XFile? image1,image2,image3,image4;

  bool isFile1=false;
  bool isFile2=false;
  bool isFile3=false;
  bool isFile4=false;

  bool isPic1=true;
  bool isPic2=true;
  bool isPic3=true;
  bool isPic4=true;




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

  void pickImage2() async{
     image2 = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 100);

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

  void pickImage3() async{
     image3 = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 100);

    if(image3!=null){
      setState(() {
        file3=File(image3!.path);
        isFile3=true;
        isPic3=false;
      });
    } else{
      isFile3=false;
      isPic3=true;
    }
  }

  void pickImage4() async{
     image4 = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 100);

    if(image4!=null){
      setState(() {
        file4=File(image4!.path);
        isFile4=true;
        isPic4=false;
      });
    } else{
      isFile4=false;
      isPic4=true;
    }
  }
  
  Future<void> uploadImages() async{
    
    var stream = new http.ByteStream(image1!.openRead());
    stream.cast();
    
    var length= await image1!.length();

    String newurl = TravApis.CLIENTFEEDBACK + "Refid=R20220059";
    
    var url = Uri.parse(newurl);
    
    var request= new http.MultipartRequest('POST',url);
    
    var mutipart=new http.MultipartFile('images', stream, length);

    request.files.add(mutipart);

    var response = await request.send();

    if(response.statusCode==200){
      print("ok");
    }else{
      print("failed");
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
              //    margin: EdgeInsets.only(left: 15),
                child: Text("PICTURES",
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
             width: MediaQuery.of(context).size.width,
             margin: EdgeInsets.only(left: 30,right: 30),
             child: Center(
               child: Text("How was Your Trip ?",
                   // textAlign: TextAlign.left,
                   style: TextStyle(color: Colors.blueAccent,
                     fontSize: 16,
                     fontFamily: 'BebesNeue',
                     fontWeight: FontWeight.w700,)),
             ),
           ),

           SizedBox(height: 15,),



           Container(
             width: MediaQuery.of(context).size.width,
             margin: EdgeInsets.only(left: 30,top: 5, right: 30),
             child: Center(
               child: Text("Share Your Wonderful Memories of your Trip",
                   // textAlign: TextAlign.left,
                   style: TextStyle(color: Colors.blueAccent,
                     fontSize: 13,
                     fontFamily: 'BebesNeue',
                     fontWeight: FontWeight.w700,)),
             ),
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
                           margin: EdgeInsets.only(top: 5),
                           child: Image.asset("image/accountlogo.png",height: 120, width: 120,),
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
                           margin: EdgeInsets.only(top: 5),
                           child: Image.asset("image/accountlogo.png",height: 120, width: 120,),
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
                         child : Text("Select Image",
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

           SizedBox(height: 10,),

           Row(children: [

             Expanded(
               flex: 1,
               child: InkWell(
                 onTap: (){
                   pickImage3();
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
                         visible: isPic3,
                         child: Container(
                           margin: EdgeInsets.only(top: 5),
                           child: Image.asset("image/accountlogo.png",height: 120, width: 120,),
                         ),
                       ),

                       if(file3!=null)
                       Visibility(
                         visible: isFile3,
                         child: Container(
                           margin: EdgeInsets.only(top: 5),
                           child: Image.file(file3!,width: double.infinity,height: 120,),
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
             ),

             Expanded(
               flex: 1,
               child: InkWell(
                 onTap: (){
                   pickImage4();
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
                         visible: isPic4,
                         child: Container(
                           margin: EdgeInsets.only(top: 5),
                           child: Image.asset("image/accountlogo.png",height: 120, width: 120,),
                         ),
                       ),

                       if(file4!=null)
                       Visibility(
                         visible: isFile4,
                         child: Container(
                           margin: EdgeInsets.only(top: 5),
                           child: Image.file(file4!,width: double.infinity,height: 120,),
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
             ),

           ],
           ),

           SizedBox(height: 15),

           InkWell(onTap: (){

             if(file1!=null && file2!=null && file3!=null && file4!=null){
               getImgFeed();
              /* Fluttertoast.showToast(
                   msg: "Uploaded",
                   toastLength: Toast.LENGTH_SHORT,
                   gravity: ToastGravity.BOTTOM,
                   timeInSecForIosWeb: 3,
                   backgroundColor: Colors.black,
                   textColor: Colors.white,
                   fontSize: 12.0
               );*/
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


  Future<List <ResultImg>> getImgFeed() async {
   // String newurl = TravApis.FEEDBACKIMG + "refid="+refID+"&img1="++"&img2="++"&img3="++"&img4="+;

  //  String newurl = TravApis.FEEDBACKIMG + "Refid="+refID+"&img1="+file1.toString();

    String newurl = TravApis.FEEDBACKIMG;
    List<ResultImg> imgdata=[];
    print("FeedBack Image URL : " + newurl);

    var stream = new http.ByteStream(file1!.openRead());
    stream.cast();

    var length = await file1!.length();
    print("Lenght is : "+length.toString());

    var stream2 = new http.ByteStream(file2!.openRead());
    stream2.cast();

    var length2 = await file2!.length();
    print("Lenght2 is : "+length2.toString());

    var stream3 = new http.ByteStream(file3!.openRead());
    stream3.cast();

    var length3 = await file3!.length();
    print("Lenght3 is : "+length3.toString());

    var stream4 = new http.ByteStream(file4!.openRead());
    stream4.cast();

    var length4 = await file4!.length();
    print("Lenght4 is : "+length4.toString());

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

    var multiport3 = new http.MultipartFile(
        'img3',
        stream3,
        length3,
        filename: file3.toString());

    var multiport4 = new http.MultipartFile(
        'img4',
        stream4,
        length4,
        filename: file4.toString());

  //  http.MultipartFile multiparfile = await http.MultipartFile.fromPath('img1',file1.toString());
    request.files.add(multiport);
    request.files.add(multiport2);
    request.files.add(multiport3);
    request.files.add(multiport4);

    var res = await request.send();
    print("Response of Images are : " +res.stream.toString());

   /* http.StreamedResponse res= await request.send();

    print("Response of Images are : " +res.toString());*/

    if(res.statusCode == 200){
      print("Image Upload Successfully");
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
      print("failed");
    }

   /* print("Feedback Experince Responsee is " +res.body);

    var datas = jsonDecode(res.body)['result'] as List;

    imgdata = datas.map((data) => ResultImg.fromJson(data)).toList();

    String message = imgdata[0].msg!;

    print("Message  is $message" );


    Fluttertoast.showToast(
      msg: "$message",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 6,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 12.0,
    );*/


    return imgdata;

  }

}
