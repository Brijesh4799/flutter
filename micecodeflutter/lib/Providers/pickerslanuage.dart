import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

import '../Models/itemodel.dart';

class PickersLanguageProvider with ChangeNotifier{

  static String languageName="Select Language";
   String code="en";

  List<DaysIte>? daysdatamodel;
   late DaysIte daysIte;
   int pos = 0;

  String serviceTypeId="Accomodation";
  String  serviceTypeName="Hotel";
  String  serviceCategory="5";
  String  pickuptime="12:00:00 AM";
  String  droptime="12:00:00 PM";
  String  serviceDetail="12:00:00 AM";
  String  serviceDetail01="12:00:00 PM";

  String serviceTypeIdlat="Accomodation";
  String  serviceTypeNamelat="Hotel";
  String  serviceCategorylat="5";
  String  pickuptimelat="12:00:00 AM";
  String  droptimelat="12:00:00 PM";
  String  serviceDetaillat="12:00:00 AM";
  String  serviceDetail01lat="12:00:00 PM";






  selectLanguage(){
     switch(languageName){

       case "Select Language":
         code='en';
         print(code);
         notifyListeners();
         break;

       case "Arabic":
         code='ar';
         print(code);
         notifyListeners();
         break;

       case 'Bengali':
         code="bn";
         print(code);
         notifyListeners();
         break;

       case "Chinese":
         code='zh-cn';
         print(code);
         notifyListeners();
         break;

       case "English":
         code='en';
         print(code);
         notifyListeners();
         break;

       case "Frence":
         code='fr';
         print(code);
         notifyListeners();
         break;

       case "German":
         code='de';
         print(code);
         notifyListeners();
         break;

       case "Hindi":
         code='hi';
         print(code);
         notifyListeners();
         break;

       case "Japanes":
         code='ja';
         print(code);
         notifyListeners();
         break;
     }
   }

  traslateIte( DaysIte daysIte1,int pos1) {
    daysIte=daysIte1;
    pos=pos1;
    notifyListeners();
  }

}