import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
//import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_to_text.dart';
import 'package:translator/translator.dart';
import '../Providers/pickerstranslator.dart';

class TranslateSTT extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TranslateST(),
    );
  }
}

class TranslateST extends StatefulWidget {
  @override
  State createState() => MyTranslateST();
}

class MyTranslateST extends State<TranslateST> {
  SpeechToText stt = SpeechToText();
  bool isListening = false;
  String text2 = "";
  double accuracy = 1.0;
  bool _loading = false;
  bool loadCircle = false;
  bool isConVisibleClick = true;
  bool isConInVisibleClick = false;

  String languagenamesst = "English";
  String localeid = "en";

  String languagenametts = "Afrikaans";

  String codestts = 'af';

  String translatednewText = "";

  String selectsttlanguage = "Select";

  var selectsst = ["Select"];

  get formkey => null;

  void getSelectVisible() {
    isConVisibleClick = false;
    isConInVisibleClick = true;
  }

  void getNotSelectVisible() {
    isConVisibleClick = true;
    isConInVisibleClick = false;
  }

  var languageNamesst = [
    "English",
    "Afrikaans",
    "Arabic",
    "Bengali",
    "French",
    "German",
    "Gujrati",
    "Hindi",
    "Indonesian",
    "Italian",
    "Japanese",
    "Kannada",
    "Korean",
    "Malayalam",
    "Marathi",
    "Nepali",
    "Punjabi",
    "Russian",
    "Spanish",
    "Tamil",
    "Telugu",
    "Thai",
    "Urdu",
  ];

  var languageNametts = [
    "Afrikaans",
    "Arabic",
    "Bengali",
    "English",
    "French",
    "German",
    "Gujrati",
    "Hindi",
    "Indonesian",
    "Italian",
    "Japanese",
    "Kannada",
    "Korean",
    "Malayalam",
    "Marathi",
    "Nepali",
    "Punjabi",
    "Russian",
    "Spanish",
    "Tamil",
    "Telugu",
    "Thai",
    "Urdu",
  ];

  List<String> _languagesCodetts = [
    'af',
    'ar',
    'bn',
    'en',
    'fr',
    'de',
    'gu',
    'hi',
    'id',
    'it',
    'ja',
    'kn',
    'ko',
    'ml',
    'mr',
    'ne',
    'pa',
    'ru',
    'es',
    'ta',
    'te',
    'th',
    'ur'
  ];

  List<String> _languagesCodetts2 = [
    'af',
    'sq',
    'am',
    'ar',
    'hy',
    'az',
    'eu',
    'be',
    'bn',
    'bs',
    'bg',
    'ca',
    'ceb',
    'zh-CN',
    'co',
    'hr',
    'cs',
    'da',
    'nl',
    'en',
    'eo',
    'et',
    'fi',
    'fr',
    'fy',
    'gl',
    'ka',
    'de',
    'el',
    'gu',
    'ht',
    'ha',
    'haw',
    'he',
    'hi',
    'hmn',
    'hu',
    'is',
    'ig',
    'id',
    'ga',
    'it',
    'ja',
    'jv',
    'kn',
    'kk',
    'km',
    'rw',
    'ko',
    'ku',
    'ky',
    'lo',
    'lv',
    'lt',
    'lb',
    'mk',
    'mg',
    'ms',
    'ml',
    'mt',
    'mi',
    'mr',
    'mn',
    'my',
    'ne',
    'no',
    'ny',
    'or',
    'ps',
    'fa',
    'pl',
    'pt',
    'pa',
    'ro',
    'ru',
    'sm',
    'gd',
    'sr',
    'st',
    'sn',
    'sd',
    'si',
    'sk',
    'sl',
    'so',
    'es',
    'su',
    'sw',
    'sv',
    'tl',
    'tg',
    'ta',
    'tt',
    'te',
    'th',
    'tr',
    'tk',
    'uk',
    'ur',
    'ug',
    'uz',
    'vi',
    'cy',
    'xh',
    'yi',
    'yo',
    'zu'
  ];

  var languageNamesst1 = [
    "Afrikaans",
    "Albanian",
    "Amharic",
    "Arabic",
    "Armenian",
    "Azerbaijani",
    "Basque",
    "Belarusian",
    "Bengali",
    "Bosnian",
    "Bulgarian",
    "Catalan",
    "Cebuano",
    /*"Chinese"*/ "Croatain",
    "Czech",
    "Danish",
    "Dutch",
    "English",
    "Esperanto",
    "Estonian",
    "Finnish",
    "French",
    "Frisian",
    "Galician",
    "Georgian",
    "German",
    "Greek",
    "Gujrati",
    /*,"Hailtian Creole","Hausa","Hawaiian","Hebrew",*/ "Hindi" /*,"Hmong","Hungarian"*/,
    "Icelandic",
    "Igbo",
    "Indonesian",
    "Irish",
    "Italian",
    "Japanese",
    /*"Javanese",*/ "Kannada" /*,"Kazakh","khmer","Kinyarwanda"*/,
    "Korean",
    /*"Kurdish","Kyrgyz",*/
    "Lao",
    /*"Latvian",*/ "Lithuanian",
    "Luxembourgish",
    "Macedonian",
    "Malaygasy",
    "Malay",
    "Malayalam",
    "Maltese",
    "Maori",
    "Mararti",
    "Mongolian",
    "Myanmar",
    "Nepali" /*"Norwegian","Nyanja","Odia","Pashto","Persian","Polish","Portuguese"*/,
    "Punjabi",
    "Romanian",
    "Russian",
    /*"Samoan","Scots Gaelic","Serbian",
    "Sesotho","Shona",*/
    "Sindhi",
    /*"Sinhala","Slovak","Slovenian","Somali",*/ "Spanish",
    /*"Sundanese","Swahili","Swedish","Tagalog","tajik",*/ "Tamil" /*,"Tatar",*/
    ,
    "Telugu",
    "Thai",
    "Turkish",
    /*"Turkmen","Ukrainian",*/ "Urdu",
    /*"Uyghur","Uzbek",*/ "Vietnamese",
    "Weish",
    "Xhosa",
    "Yiddish",
    /*"Yoruba"*/ "Zulu"
  ];

  var languageNametts1 = [
    "Afrikaans",
    "Albanian",
    "Amharic",
    "Arabic",
    "Armenian",
    "Azerbaijani",
    "Basque",
    "Belarusian",
    "Bengali",
    "Bosnian",
    "Bulgarian",
    "Catalan",
    "Cebuano",
    /*"Chinese"*/ "Croatain",
    "Czech",
    "Danish",
    "Dutch",
    "English",
    "Esperanto",
    "Estonian",
    "Finnish",
    "French",
    "Frisian",
    "Galician",
    "Georgian",
    "German",
    "Greek",
    "Gujrati",
    /*,"Hailtian Creole","Hausa","Hawaiian","Hebrew",*/ "Hindi" /*,"Hmong","Hungarian"*/,
    "Icelandic",
    "Igbo",
    "Indonesian",
    "Irish",
    "Italian",
    "Japanese",
    /*"Javanese",*/ "Kannada" /*,"Kazakh","khmer","Kinyarwanda"*/,
    "Korean",
    /*"Kurdish","Kyrgyz",*/
    "Lao",
    /*"Latvian",*/ "Lithuanian",
    "Luxembourgish",
    "Macedonian",
    "Malaygasy",
    "Malay",
    "Malayalam",
    "Maltese",
    "Maori",
    "Mararti",
    "Mongolian",
    "Myanmar",
    "Nepali" /*"Norwegian","Nyanja","Odia","Pashto","Persian","Polish","Portuguese"*/,
    "Punjabi",
    "Romanian",
    "Russian",
    /*"Samoan","Scots Gaelic","Serbian",
    "Sesotho","Shona",*/
    "Sindhi",
    /*"Sinhala","Slovak","Slovenian","Somali",*/ "Spanish",
    /*"Sundanese","Swahili","Swedish","Tagalog","tajik",*/ "Tamil" /*,"Tatar",*/
    ,
    "Telugu",
    "Thai",
    "Turkish",
    /*"Turkmen","Ukrainian",*/ "Urdu",
    /*"Uyghur","Uzbek",*/ "Vietnamese",
    "Weish",
    "Xhosa",
    "Yiddish",
    /*"Yoruba"*/ "Zulu"
  ];

  List<String> _translatedTexts = [];

  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController textEditingController = TextEditingController();

  GoogleTranslator translator = GoogleTranslator();

  @override
  void initState() {
    initialiseAudio();
    super.initState();
  }

  initialiseAudio() async {
    stt.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loadCircle,
      progressIndicator: const CircularProgressIndicator(color: Colors.purple,strokeWidth: 5),

      child: Scaffold(
        body: Stack(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("image/currencybg.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Text(""),
                ),
            Padding(
              padding:
                  EdgeInsets.only(top: 51, left: 20, right: 20, bottom: 31),
              child: Container(
             //   margin: EdgeInsets.only(top: ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    )),
                child: Column(
                  children: [

                    Expanded(
                      child:
                      SingleChildScrollView(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.0),
                                topRight: Radius.circular(5.0),
                                bottomLeft: Radius.circular(5.0),
                                bottomRight: Radius.circular(5.0),
                              )),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    //  padding: EdgeInsets.only(top: 20,bottom: 20,left: 20,right: 20),
                                    width: 180.0,
                                    height: 80.0,
                                    margin: EdgeInsets.only(
                                      left: 40,
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: Theme(
                                        data: Theme.of(context)
                                            .copyWith(canvasColor: Colors.white),
                                        child: ChangeNotifierProvider(
                                            create: (context) =>
                                                PickersTranslatorProvider(),
                                            child:
                                                Consumer<PickersTranslatorProvider>(
                                                    builder:
                                                        (context, provider, child) {
                                              return DropdownButton(
                                                icon: Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: Colors.blue,
                                                ),
                                                focusColor: Colors.white,
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize: 20),
                                                items: languageNamesst
                                                    .map((String itemnames) {
                                                  return DropdownMenuItem<String>(
                                                      value: itemnames,
                                                      child: Text(itemnames, textAlign: TextAlign.center,style: TextStyle(color: Colors.blue,fontSize: 18,
                                                          fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),));
                                                }).toList(),
                                                onChanged: (String? value) {
                                                  //  PickersTranslatorProvider.languageName=value!;

                                                  //  provider.selectLanguage();

                                                  languagenamesst = value!;

                                                  switch (languagenamesst) {

                                                    // A

                                                    case "English":
                                                      setState(() {
                                                        _translatedTexts.clear();
                                                        localeid = "en";
                                                        print(localeid);
                                                      });
                                                      break;

                                                    case "Afrikaans":
                                                      setState(() {
                                                        _translatedTexts.clear();
                                                        localeid = "af";
                                                        print(localeid);
                                                      });
                                                      break;

                                                    case "Arabic":
                                                      setState(() {
                                                        _translatedTexts.clear();
                                                        localeid = "ar";
                                                        print(localeid);
                                                      });
                                                      break;

                                                    // B

                                                    case "Bengali":
                                                      setState(() {
                                                        _translatedTexts.clear();
                                                        localeid = "bn";
                                                        print(localeid);
                                                      });
                                                      break;

                                                    // C

                                                    // D

                                                    // E

                                                    // F

                                                    case "French":
                                                      setState(() {
                                                        _translatedTexts.clear();
                                                        localeid = "fr";
                                                        print(localeid);
                                                      });
                                                      break;

                                                    // G

                                                    case "German":
                                                      setState(() {
                                                        _translatedTexts.clear();
                                                        localeid = "de";
                                                        print(localeid);
                                                      });
                                                      break;

                                                    case "Gujrati":
                                                      setState(() {
                                                        _translatedTexts.clear();
                                                        localeid = "gu";
                                                        print(localeid);
                                                      });
                                                      break;

                                                    // H

                                                    case "Hindi":
                                                      setState(() {
                                                        _translatedTexts.clear();
                                                        localeid = "hi";
                                                        print(localeid);
                                                      });
                                                      break;

                                                    // I

                                                    case "Indonesian":
                                                      setState(() {
                                                        _translatedTexts.clear();
                                                        localeid = "id";
                                                        print(localeid);
                                                      });
                                                      break;

                                                    case "Italian":
                                                      setState(() {
                                                        _translatedTexts.clear();
                                                        localeid = "it";
                                                        print(localeid);
                                                      });
                                                      break;

                                                    // J

                                                    case "Japanese":
                                                      setState(() {
                                                        _translatedTexts.clear();
                                                        localeid = "ja";
                                                        print(localeid);
                                                      });
                                                      break;

                                                    //  k

                                                    case "Kannada":
                                                      setState(() {
                                                        _translatedTexts.clear();
                                                        localeid = "kn";
                                                        print(localeid);
                                                      });
                                                      break;

                                                    case "Korean":
                                                      setState(() {
                                                        _translatedTexts.clear();
                                                        localeid = "ko";
                                                        print(localeid);
                                                      });
                                                      break;

                                                    // L

                                                    // M

                                                    case "Malayalam":
                                                      setState(() {
                                                        _translatedTexts.clear();
                                                        localeid = "ml";
                                                        print(localeid);
                                                      });
                                                      break;

                                                    case "Marathi":
                                                      setState(() {
                                                        _translatedTexts.clear();
                                                        localeid = "mr";
                                                        print(localeid);
                                                      });
                                                      break;

                                                    // N

                                                    case "Nepali":
                                                      setState(() {
                                                        _translatedTexts.clear();
                                                        localeid = "ne";
                                                        print(localeid);
                                                      });
                                                      break;

                                                    // O

                                                    // P

                                                    case "Punjabi":
                                                      setState(() {
                                                        _translatedTexts.clear();
                                                        localeid = "pa";
                                                        print(localeid);
                                                      });
                                                      break;

                                                    // R

                                                    case "Russian":
                                                      setState(() {
                                                        _translatedTexts.clear();
                                                        localeid = "ru";
                                                        print(localeid);
                                                      });
                                                      break;

                                                    // S

                                                    case "Spanish":
                                                      setState(() {
                                                        _translatedTexts.clear();
                                                        localeid = "es";
                                                        print(localeid);
                                                      });
                                                      break;

                                                    // T

                                                    case "Tamil":
                                                      setState(() {
                                                        _translatedTexts.clear();
                                                        localeid = "ta";
                                                        print(localeid);
                                                      });
                                                      break;

                                                    case "Telugu":
                                                      setState(() {
                                                        _translatedTexts.clear();
                                                        localeid = "tu";
                                                        print(localeid);
                                                      });
                                                      break;

                                                    case "Thai":
                                                      setState(() {
                                                        _translatedTexts.clear();
                                                        localeid = "th";
                                                        print(localeid);
                                                      });
                                                      break;

                                                    // U

                                                    case "Urdu":
                                                      setState(() {
                                                        _translatedTexts.clear();
                                                        localeid = "ur";
                                                        print(localeid);
                                                      });
                                                      break;
                                                  }
                                                },
                                                value: languagenamesst,
                                              );
                                            })),
                                      ),
                                    ),

                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                    ),
                                  ),

                                  InkWell(
                                    onTap: () {
                                      _listen();
                                      //  getNotSelectVisible();
                                      translatednewText = "";
                                      text2="";
                                    },
                                    child: Container(
                                      child: Image.asset(
                                        "image/mic.png",
                                        height: 35,
                                        width: 30,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: Text(text2,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'BebesNeue',
                                        fontWeight: FontWeight.w700)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                   
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5.0),
                                bottomRight: Radius.circular(5.0),
                              )),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 100,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: Text(translatednewText,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'BebesNeue',
                                        fontWeight: FontWeight.w700)),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Row(
                                children: [

                                  Visibility(
                                    visible: isConVisibleClick,
                                    child: InkWell(
                                      onTap: (){
                                        Fluttertoast.showToast(
                                            msg: "Translate Select Language First",
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 4,
                                            backgroundColor: Colors.black,
                                            textColor: Colors.white,
                                            fontSize: 14.0
                                        );
                                      },
                                      child: Container(
                                       // color: Colors.grey,
                                        width: 140.0,
                                        height: 60.0,
                                        margin: EdgeInsets.only(top: 40,left:70,right: 10),
                                        child : Text("",
                                            style: TextStyle(color: Colors.white,fontSize: 20,
                                                fontFamily: 'BebesNeue',fontWeight: FontWeight.w700)),
                                      ),
                                    ),
                                  ),

                                  Visibility(
                                    visible: isConInVisibleClick,
                                    child: Container(
                                      alignment: Alignment.center,
                                      //  padding: EdgeInsets.only(top: 20,bottom: 20,left: 20,right: 20),
                                      width: 180.0,
                                      height: 80.0,
                                      margin: EdgeInsets.only(
                                        left: 40,
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: Theme(
                                          data: Theme.of(context).copyWith(
                                              canvasColor: Colors.lightBlue),
                                          child: ChangeNotifierProvider(
                                              create: (context) =>
                                                  PickersTranslatorProvider(),
                                              child:
                                                  Consumer<PickersTranslatorProvider>(
                                                      builder:
                                                          (context, provider, child) {
                                                return DropdownButton(
                                                  icon: Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: Colors.white,
                                                  ),
                                                  focusColor: Colors.white,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                  //  focusColor: Colors.white,

                                                  items: languageNametts
                                                      .map((String itemnames) {
                                                    return DropdownMenuItem<String>(
                                                        value: itemnames,
                                                        child: Text(
                                                          itemnames,
                                                          textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 18,
                                                            fontFamily: 'BebesNeue',fontWeight: FontWeight.w700),
                                                        ));
                                                  }).toList(),

                                                  onChanged: (String? value) {
                                                    //  PickersTranslatorProvider.languageName=value!;

                                                    //  provider.selectLanguage();

                                                    languagenametts = value!;
                                                    print("the value is : $value");

                                                    switch (languagenametts) {

                                                      // A

                                                      case "Afrikaans":
                                                        setState(() {
                                                          codestts = 'af';
                                                          //  codestts="en";
                                                          if (_translatedTexts
                                                                  .length ==
                                                              0) {
                                                            toastMessage();
                                                          }

                                                          if (_translatedTexts
                                                                  .length !=
                                                              0) {
                                                            toastcircle();
                                                          }
                                                          translatednewText =
                                                              _translatedTexts[0];
                                                          print(_translatedTexts[0]);
                                                          speak(codestts,
                                                              _translatedTexts[0]);
                                                        });
                                                        //  translate();
                                                        break;

                                                      case "Arabic":
                                                        setState(() {
                                                          if (_translatedTexts
                                                                  .length ==
                                                              0) {
                                                            toastMessage();
                                                          } else {
                                                            toastcircle();
                                                          }
                                                          codestts = "ar";
                                                          translatednewText =
                                                              _translatedTexts[1];
                                                          print(_translatedTexts[1]);
                                                          speak(codestts,
                                                              _translatedTexts[1]);
                                                        });
                                                        break;

                                                      case "Bengali":
                                                        setState(() {
                                                          if (_translatedTexts
                                                                  .length ==
                                                              0) {
                                                            toastMessage();
                                                          } else {
                                                            toastcircle();
                                                          }
                                                          codestts = "bn";
                                                          translatednewText =
                                                              _translatedTexts[2];
                                                          print(_translatedTexts[2]);
                                                          speak(codestts,
                                                              _translatedTexts[2]);
                                                        });
                                                        break;

                                                      case "English":
                                                        setState(() {
                                                          if (_translatedTexts
                                                                  .length ==
                                                              0) {
                                                            toastMessage();
                                                          }

                                                          if (_translatedTexts
                                                                  .length !=
                                                              0) {
                                                            toastcircle();
                                                          } else {
                                                            toastcircle();
                                                          }
                                                          codestts = "en";
                                                          translatednewText =
                                                              _translatedTexts[3];
                                                          print(_translatedTexts[3]);
                                                          speak(codestts,
                                                              _translatedTexts[3]);
                                                        });
                                                        break;

                                                      case "French":
                                                        setState(() {
                                                          if (_translatedTexts
                                                                  .length ==
                                                              0) {
                                                            toastMessage();
                                                          } else {
                                                            toastcircle();
                                                          }
                                                          codestts = "fr";
                                                          translatednewText =
                                                              _translatedTexts[4];
                                                          print(_translatedTexts[4]);
                                                          speak(codestts,
                                                              _translatedTexts[4]);
                                                        });
                                                        break;

                                                      case "German":
                                                        setState(() {
                                                          if (_translatedTexts
                                                                  .length ==
                                                              0) {
                                                            toastMessage();
                                                          } else {
                                                            toastcircle();
                                                          }
                                                          codestts = "de";
                                                          translatednewText =
                                                              _translatedTexts[5];
                                                          print(_translatedTexts[5]);
                                                          speak(codestts,
                                                              _translatedTexts[5]);
                                                        });
                                                        break;

                                                      case "Gujrati":
                                                        setState(() {
                                                          if (_translatedTexts
                                                                  .length ==
                                                              0) {
                                                            toastMessage();
                                                          } else {
                                                            toastcircle();
                                                          }
                                                          codestts = "gu";
                                                          translatednewText =
                                                              _translatedTexts[6];
                                                          print(_translatedTexts[6]);
                                                          speak(codestts,
                                                              _translatedTexts[6]);
                                                        });
                                                        break;

                                                      case "Hindi":
                                                        setState(() {
                                                          if (_translatedTexts
                                                                  .length ==
                                                              0) {
                                                            toastMessage();
                                                          } else {
                                                            toastcircle();
                                                          }
                                                          codestts = "hi";
                                                          translatednewText =
                                                              _translatedTexts[7];
                                                          print(_translatedTexts[7]);
                                                          speak(codestts,
                                                              _translatedTexts[7]);
                                                        });
                                                        break;

                                                      case "Indonesian":
                                                        setState(() {
                                                          if (_translatedTexts
                                                                  .length ==
                                                              0) {
                                                            toastMessage();
                                                          } else {
                                                            toastcircle();
                                                          }
                                                          codestts = "id";
                                                          translatednewText =
                                                              _translatedTexts[8];
                                                          print(_translatedTexts[8]);
                                                          speak(codestts,
                                                              _translatedTexts[8]);
                                                        });
                                                        break;

                                                      case "Italian":
                                                        setState(() {
                                                          if (_translatedTexts
                                                                  .length ==
                                                              0) {
                                                            toastMessage();
                                                          } else {
                                                            toastcircle();
                                                          }
                                                          codestts = "it";
                                                          translatednewText =
                                                              _translatedTexts[9];
                                                          print(_translatedTexts[9]);
                                                          speak(codestts,
                                                              _translatedTexts[9]);
                                                        });
                                                        break;

                                                      // J

                                                      case "Japanese":
                                                        setState(() {
                                                          if (_translatedTexts
                                                                  .length ==
                                                              0) {
                                                            toastMessage();
                                                          } else {
                                                            toastcircle();
                                                          }
                                                          codestts = "ja";
                                                          translatednewText =
                                                              _translatedTexts[10];
                                                          print(_translatedTexts[10]);
                                                          speak(codestts,
                                                              _translatedTexts[10]);
                                                        });
                                                        break;

                                                      case "Kannada":
                                                        setState(() {
                                                          if (_translatedTexts
                                                                  .length ==
                                                              0) {
                                                            toastMessage();
                                                          } else {
                                                            toastcircle();
                                                          }
                                                          codestts = "kn";
                                                          translatednewText =
                                                              _translatedTexts[11];
                                                          print(_translatedTexts[11]);
                                                          speak(codestts,
                                                              _translatedTexts[11]);
                                                        });
                                                        break;

                                                      case "Korean":
                                                        setState(() {
                                                          if (_translatedTexts
                                                                  .length ==
                                                              0) {
                                                            toastMessage();
                                                          } else {
                                                            toastcircle();
                                                          }
                                                          codestts = "ko";
                                                          translatednewText =
                                                              _translatedTexts[12];
                                                          print(_translatedTexts[12]);
                                                          speak(codestts,
                                                              _translatedTexts[12]);
                                                        });
                                                        break;

                                                      case "Malayalam":
                                                        setState(() {
                                                          if (_translatedTexts
                                                                  .length ==
                                                              0) {
                                                            toastMessage();
                                                          } else {
                                                            toastcircle();
                                                          }
                                                          codestts = "ml";
                                                          translatednewText =
                                                              _translatedTexts[13];
                                                          print(_translatedTexts[13]);
                                                          speak(codestts,
                                                              _translatedTexts[13]);
                                                        });
                                                        break;

                                                      case "Marathi":
                                                        setState(() {
                                                          if (_translatedTexts
                                                                  .length ==
                                                              0) {
                                                            toastMessage();
                                                          } else {
                                                            toastcircle();
                                                          }
                                                          codestts = "mr";
                                                          translatednewText =
                                                              _translatedTexts[14];
                                                          print(_translatedTexts[14]);
                                                          speak(codestts,
                                                              _translatedTexts[14]);
                                                        });

                                                        break;

                                                      case "Nepali":
                                                        setState(() {
                                                          if (_translatedTexts
                                                                  .length ==
                                                              0) {
                                                            toastMessage();
                                                          } else {
                                                            toastcircle();
                                                          }
                                                          codestts = "ne";
                                                          translatednewText =
                                                              _translatedTexts[15];
                                                          print(_translatedTexts[15]);
                                                          speak(codestts,
                                                              _translatedTexts[15]);
                                                        });
                                                        break;

                                                      case "Punjabi":
                                                        setState(() {
                                                          if (_translatedTexts
                                                                  .length ==
                                                              0) {
                                                            toastMessage();
                                                          } else {
                                                            toastcircle();
                                                          }
                                                          codestts = "pa";
                                                          translatednewText =
                                                              _translatedTexts[16];
                                                          print(_translatedTexts[16]);
                                                          speak(codestts,
                                                              _translatedTexts[16]);
                                                        });
                                                        break;

                                                      // R

                                                      case "Russian":
                                                        setState(() {
                                                          if (_translatedTexts
                                                                  .length ==
                                                              0) {
                                                            toastMessage();
                                                          } else {
                                                            toastcircle();
                                                          }
                                                          codestts = "ru";
                                                          translatednewText =
                                                              _translatedTexts[17];
                                                          print(_translatedTexts[17]);
                                                          speak(codestts,
                                                              _translatedTexts[17]);
                                                        });
                                                        break;

                                                      case "Spanish":
                                                        setState(() {
                                                          if (_translatedTexts
                                                                  .length ==
                                                              0) {
                                                            toastMessage();
                                                          } else {
                                                            toastcircle();
                                                          }
                                                          codestts = "es";
                                                          translatednewText =
                                                              _translatedTexts[18];
                                                          print(_translatedTexts[18]);
                                                          speak(codestts,
                                                              _translatedTexts[18]);
                                                        });
                                                        break;

                                                      case "Tamil":
                                                        setState(() {
                                                          if (_translatedTexts
                                                                  .length ==
                                                              0) {
                                                            toastMessage();
                                                          } else {
                                                            toastcircle();
                                                          }
                                                          codestts = "ta";
                                                          translatednewText =
                                                              _translatedTexts[19];
                                                          print(_translatedTexts[19]);
                                                          speak(codestts,
                                                              _translatedTexts[19]);
                                                        });
                                                        break;

                                                      case "Telugu":
                                                        setState(() {
                                                          if (_translatedTexts
                                                                  .length ==
                                                              0) {
                                                            toastMessage();
                                                          } else {
                                                            toastcircle();
                                                          }
                                                          codestts = "tu";
                                                          translatednewText =
                                                              _translatedTexts[20];
                                                          print(_translatedTexts[20]);
                                                          speak(codestts,
                                                              _translatedTexts[20]);
                                                        });
                                                        break;

                                                      case "Thai":
                                                        setState(() {
                                                          if (_translatedTexts
                                                                  .length ==
                                                              0) {
                                                            toastMessage();
                                                          } else {
                                                            toastcircle();
                                                          }
                                                          codestts = "th";
                                                          translatednewText =
                                                              _translatedTexts[21];
                                                          print(_translatedTexts[21]);
                                                          speak(codestts,
                                                              _translatedTexts[21]);
                                                        });
                                                        break;

                                                      case "Urdu":
                                                        setState(() {
                                                          if (_translatedTexts.length == 0) {
                                                            toastMessage();
                                                          } else {
                                                            toastcircle();
                                                          }
                                                          codestts = "ur";
                                                          translatednewText =
                                                              _translatedTexts[22];
                                                          print(_translatedTexts[22]);
                                                          speak(codestts,
                                                              _translatedTexts[22]);
                                                        });
                                                        break;
                                                    }
                                                  },

                                                  value: languagenametts,
                                                );
                                              })),
                                        ),
                                      ),

                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),

                                  InkWell(
                                    onTap: () {
                                      speak(codestts, translatednewText);
                                    },
                                    child: Container(
                                      child: Image.asset(
                                        "image/speeks.png",
                                        height: 35,
                                        width: 30,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                   padding: EdgeInsets.only(top: 15),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (text2 == "") {
                        Fluttertoast.showToast(
                            msg: "Please Speech Some here....",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 4,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 12.0);
                      } else {
                        _translatedTexts.clear();
                        translatednewText = "";
                        translate();

                        print("tranlated text is : $translatednewText");
                        print("tranlated code is : $codestts");

                        speak(codestts, translatednewText);
                      }
                    });
                  },
                  child: Container(
                    height: 80,
                    width: 80,
                    child: Image.asset(
                      "image/convertimg.png",
                      height: 80,
                      width: 80,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _listen() async {
    if (stt.isAvailable) {
      if (!isListening) {
        stt.listen(
            localeId: localeid,
            onResult: (result) {
              setState(() {
                accuracy = result.confidence;
                text2 = result.recognizedWords;
                print("accuracy is : $accuracy");
                isListening = true;
                print("Locale id is :" + localeid);

                getNotSelectVisible();

                /*_translatedTexts.clear();
                translatednewText="";
                translate();*/
              });
            });
      } else {
        setState(() {
          isListening = false;
          stt.stop();
          getNotSelectVisible();
          /*_translatedTexts.clear();
          translatednewText="";
          translate();*/
        });
      }
    } else {
      print("Permissin Denied");
    }
  }

  /*Future speak(String text1) async{
     await flutterTts.speak(text1);
     await flutterTts.setLanguage("af-ZA");
     await flutterTts.setPitch(0.8); //0.5 to 1.5
  }*/

  Future translate() async {
    List<String> translatedTexts = [];
    setState(() {
      loadCircle = true;
      _loading = true;

      /*Fluttertoast.showToast(
          msg: "Converting",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 6,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 12.0
      );*/
    });

    for (String code in _languagesCodetts) {
      Translation translation = await translator.translate(text2, to: code);
      String translatedText = translation.text;
      translatedTexts.add(translatedText);
    }

    setState(() {
      _translatedTexts = translatedTexts;
      _loading = false;
      loadCircle = false;

      getSelectVisible();

       Fluttertoast.showToast(
          msg: "Translated Now,",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 14.0
      );
    });
  }

  Future speak(String languageCode, String text) async {
    await flutterTts.setLanguage(languageCode);
    await flutterTts.setPitch(0.5);
    await flutterTts.setVolume(1.5);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);

    /* Fluttertoast.showToast(
        msg: "Language data is : "+text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0
    );*/
  }

  void toastMessage() {
    setState(() {
      //  loadCircle=true;
    });

    /* Fluttertoast.showToast(
        msg: "Converting ...... ",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 8,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0
    );*/
  }

  void toastcircle() {
    setState(() {
      /* Fluttertoast.showToast(
          msg: "Converted Now",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 12.0
      );*/
      //   loadCircle=false;
    });

    /* Fluttertoast.showToast(
        msg: "Converting ...... ",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0
    );*/
  }
}
