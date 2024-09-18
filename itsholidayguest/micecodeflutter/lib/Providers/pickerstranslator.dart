import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PickersTranslatorProvider with ChangeNotifier{

  static String languageName="Select Language";
  static String code="en-IN";

   selectLanguage(){
     switch(languageName){

       case "Select Language":
         code='en-IN';
         print(code);
         notifyListeners();
         break;

       case "English":
         code='en-IN';
         print(code);
         notifyListeners();
         break;

       case "Hindi":
         code='hi-IN';
         print(code);
         notifyListeners();
         break;

       case 'Bengali':
         code="bn";
         print(code);
         notifyListeners();
         break;


     }
   }
}