
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salescrm/Apis/apis.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'loginmodel.dart';
import 'package:google_sign_in/google_sign_in.dart';


class Login extends StatefulWidget {
  // ItemDetail({required this.itemlist});

  @override
  State createState() => new MyLogin();
}

class MyLogin extends State<Login> {

  String? id = "1";
  String? error = "Invalid";

  late SharedPreferences prefs;
  bool obsecureText = true;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var name = "";
  var pass = "";

  var emailController = TextEditingController();
  var passController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setMyValue();
    print("init state is working");
  }

  String? passValidate(String? value) {
    if (value == null || value.isEmpty)
      return 'Enter a Password';
    else if (value.length < 6)
      return "At Least put 6 Letter Password";
    else
      pass = value;
    print("Password is : " + pass);
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
      name = value;
    print("Email Id is : " + name);
    return null;
  }


  @override
  Widget build(BuildContext context) {
    print("context state is working");

    return Scaffold(
   // resizeToAvoidBottomInset: false,

      body: getBodyWidget()

    );
  }

  Widget  getBodyWidget(){

    return Stack(children: [

      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.all(0),
          child:   Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("image/callbg.png"),
                fit: BoxFit.cover,
              ),
            ),

          ),
        ),


      ),

      Center(
        child: Container(
          height: 370,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: 15, right: 15, top: 30),
          decoration: BoxDecoration(color: Colors.white,
            borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                //   begin: Alignment.topLeft,
                //   end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.65),
                  Colors.white.withOpacity(0.65),
                ],
                //  stops: [0.0,1.0]
              )
          ),


          child: Column(children: [

            Form(
              key: formkey,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 60,
                    width: 140,
                    child: Image.asset("image/saleslogo.png",),
                  ),

                  SizedBox(height: 20,),

                  Container(
                    child: Text("Your Credentials",
                      style: TextStyle(color: Colors.blue,fontSize: 14,fontFamily: 'BebesNeue',fontWeight: FontWeight.w700), ),
                  ),

                  SizedBox(height: 20,),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                     // textAlign: TextAlign.center,
                      controller: emailController,
                      decoration: InputDecoration(

                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),

                      ),
                      validator: emailValidate,
                    ),
                  ),

                  SizedBox(height: 15,),

                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                  //    textAlign: TextAlign.center,
                      obscureText: obsecureText,
                      controller: passController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Password",
                        suffixIcon: GestureDetector(onTap: (){
                          setState(() {
                            obsecureText=!obsecureText;
                          });
                        },
                          child: Icon(obsecureText?Icons.visibility_off : Icons.visibility),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),

                      ),
                      validator: passValidate,
                    ),
                  ),

                  SizedBox(height: 15,),

                  Row(children: [

                     InkWell(
                       onTap:(){
                       // googleSignIn();
                        },
                       child: Container(
                         margin: EdgeInsets.only(left: 20),
                        child: Text("Forgot Password ?",
                            style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w700)),
                    ),
                     ),
                  ],

                  ),


                  SizedBox(height: 15,),

                ],
              ),
            ),
          ],

          ),

        ),
      ),


      Center(
        child: Container(
            width: 115,
            height: 80,
            margin: EdgeInsets.only(top: 400),

            child: SingleChildScrollView(

              child: Column(children: [

                InkWell(

                  onTap: () {
                    validate();
                    //   myMessage();
                  },
                  child: Container(
                    child: Image.asset("image/nextarrow.png", height: 80.0, width: 115),
                  ),
                )
              ],),
            )
        ),

      ),


    ],
    );
  }



  void validate() {
    if (formkey.currentState!.validate()) {
      print("OK");
      getlogin();
     //    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyBottomNavigationBar()));
    } else {
      print("Error");
    }
  }


  Future<List <ResultsLogin>> getlogin() async {
    List<ResultsLogin> logindata = [];

    String newurl = AppNetworkConstants.login_url + "?username=" + emailController.text.trim() +
        "&password=" + passController.text.trim();

    print("Login Url is :"+newurl);

    var res = await http.post(Uri.parse(newurl),
        body: ({'username': emailController.text.trim(),
          'password': passController.text.trim()})
    );

    print("Login Response are : "+res.body);

    print("Email Id are : " + emailController.text);
    print("Password are : " + passController.text);


    var datas = jsonDecode(res.body)['results'] as List;

    logindata = datas.map((data) => ResultsLogin.fromJson(data)).toList();

    id = logindata[0].id;
    error = logindata[0].error;

    print("Login Response ID is : $id");
    print("Login Response Error is : $error");

    if (id == null) {
      Fluttertoast.showToast(
        msg: "$error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 6,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0,
      );
    }
    else {
      prefs = await SharedPreferences.getInstance();
      prefs.setBool("ID", true);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return MyBottomNavigationBar();
      }));
    }

    return logindata;
  }

  void googleSignIn() async{
    print("Google method is called");

    GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
       var result = await _googleSignIn.signIn();

       print("result : $result");
        } catch (error) {
        print(error);
       }
      }

}


