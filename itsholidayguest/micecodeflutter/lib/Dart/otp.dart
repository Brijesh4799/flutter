

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';



class OtpSL extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Otp(),
    );
  }
}

class Otp extends StatefulWidget {

  @override
  State createState() => MyOtp();
}

class MyOtp extends State<Otp> {

  late SharedPreferences preflog_in_out, prefotp;

 String requiredno = "1010";
 String myotp="";
 String fillotp="";


  @override
  void initState() {
   // preflog_in_out.clear();
    getPref();
    super.initState();
  }

  getPref() async {
    prefotp = await SharedPreferences.getInstance();
      myotp =  prefotp.getString("otp")!;
      print("my otp is : $myotp");
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

                        Container(
                          child: Center(
                            child: Text("Please Enter PIN to proceed further.",
                              style: TextStyle(color: Colors.white,
                                  fontSize: 13,
                                  fontFamily: 'BebesNeue',
                                  fontWeight: FontWeight.w700),),
                          ),
                        ),

                        SizedBox(height: 60,),

                        Container(
                          margin: EdgeInsets.only(left: 90,right: 90),
                          child: PinCodeTextField(
                            appContext: context,
                            length: 4,
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.black,
                            onChanged: (value){
                              print(value);
                            },
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 50,
                              fieldWidth: 40,
                              borderWidth: 1,
                              inactiveColor: Colors.black,
                              activeColor: Colors.black,
                            ),
                            onCompleted: (value){
                              fillotp=value;
                              if (fillotp==myotp){
                                print("Valid No");

                              }
                              else{
                                print("Invalid No");
                              }
                            },
                          ),
                        ),

                        SizedBox(height: 30,),

                        InkWell(
                          onTap: (){
                            if(fillotp.isEmpty) {
                              Fluttertoast.showToast(
                                msg: "Please Enter PIN",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 3,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 12.0,
                              );
                            }

                            else if(fillotp==myotp) {

                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {return MyBottomNavigationBar();}));

                             /* Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MyBottomNavigationBar()));*/
                            }
                            else{
                              Fluttertoast.showToast(
                                msg: "PIN Does't Exist",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 3,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 12.0,
                              );
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(left: 80,right: 80),
                            height: 50,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight:Radius.circular(20),
                                  bottomLeft: Radius.circular(20),bottomRight:Radius.circular(20) ),
                              border: Border.all(
                                color: Colors.white,
                                style: BorderStyle.solid,
                                width: 2.0,
                              ),

                            ),

                            child: Center(
                              child: Text("LOGIN",
                                style: TextStyle(color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: 'BebesNeue',
                                    fontWeight: FontWeight.w700),),
                            ),
                          ),
                        ),

                        Align(
                            alignment: Alignment.centerRight,
                            child:InkWell(
                              onTap: (){
                                if(myotp.isEmpty) {
                                  Fluttertoast.showToast(
                                    msg: "No PIN Available Now",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 3,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 12.0,
                                  );
                                }
                                else{
                                  Fluttertoast.showToast(
                                    msg: "$myotp",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 8,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 12.0,
                                  );
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 10,right: 40),
                                child: Text("Resend PIN?",
                                    style: TextStyle(color: Colors.red,fontSize: 14,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                              ),
                            )
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

}
