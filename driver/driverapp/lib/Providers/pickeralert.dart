import 'package:flutter/material.dart';

class PickerAlert with ChangeNotifier{

  static bool isSelectpos=false;
  static Color colorList = Color(0xff80deea);

  getColorWhite(){
      isSelectpos=false;
      colorList = Colors.white;
      notifyListeners();
      print("is Select true");
  }

  getColorBlue(){
      isSelectpos=true;
      colorList =  Color(0xff80deea);
      notifyListeners();
      print("is Select false");
  }

}