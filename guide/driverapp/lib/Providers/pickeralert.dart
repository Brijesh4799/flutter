import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PickerAlert with ChangeNotifier{

  static bool isSelectpos=false;
  static Color colorList = Color(0xffbdbdbd);

  static bool isIconBlack=true;
  static bool isIconRed=false;

  getColorWhite(){
      isSelectpos=false;
      colorList = Colors.white;
      notifyListeners();
      print("is Select true");
  }

  getColorBlue(){
      isSelectpos=true;
      colorList =  Color(0xffbdbdbd);
      notifyListeners();
      print("is Select false");
  }

  getIconBlack(){
    isIconBlack=true;
    isIconRed=false;
    notifyListeners();
    print("Icon Color Black is print");
  }

  getIconRed(){
    isIconBlack=false;
    isIconRed=true;
    notifyListeners();
    print("Icon Color Red is print");
  }

}