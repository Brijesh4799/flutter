import 'dart:async';
import 'dart:convert';
import 'dart:io';

//import 'package:ext_storage/ext_storage.dart';
import 'package:external_path/external_path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class PdfviewSL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Pdfview(),
    );
  }
}

class Pdfview extends StatefulWidget {

  @override
  State createState() => MyPdfview();
}

class MyPdfview extends State<Pdfview> {

   String url ="https://travcrm.in/travcrm-demooutbound/loadcreatevoucher_client.php?module=ClientVoucher&quotationId=487&apiurl=1";

   var dio=Dio();



  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blueAccent.withOpacity(0.5),
                    Colors.blue.withOpacity(1.0),
                  ],
                 //   stops: [0.0,1.0]
                )

            ),


              child: Column(
                children: [

                  SizedBox(height: 50,),


                  Expanded(
                    child: SingleChildScrollView(
                      
                      child: Column(children: [

                        Container(
                          child: Center(
                            child: Text("CODE VERIFICATION",
                              style: TextStyle(color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'BebesNeue',
                                  fontWeight: FontWeight.w700),),
                          ),
                        ),

                        SizedBox(height: 120,),

                        InkWell(
                          onTap: () async{
                            getPermission();
                            String path =  await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
                            String fullpath="$path/newtask1.pdf";
                            download2(dio,url,fullpath);
                          },
                          child: Container(
                            child: Center(
                              child: Text("PDF VIEW",
                                style: TextStyle(color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'BebesNeue',
                                    fontWeight: FontWeight.w700),),
                            ),
                          ),
                        ),

                      ],),
                    ),
                  ),



                ],
              ),

          ),
      ),

    );
  }

   void getPermission() async{
    print("get Permisson is :");
    //await PermissionHandler().requestPermissions(PermissionGroup.storage]);
    await Permission.contacts.request;
  }

   Future download2(Dio dio, String url, String savePath) async {
    try{
      Response response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status){
            return status! < 500;
          }),
        );

      File file =File(savePath);
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
    }catch(e){
      print("error is :");
      print(e);
    }
    }

  void showDownloadProgress(recieved,total) {
    if(total!=-1){
      print((recieved/total*100).toStringAsFixed(0) + "%");
    }
  }
}

