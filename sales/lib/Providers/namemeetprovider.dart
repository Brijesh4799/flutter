import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:salescrm/Models/allmeetname.dart';
import 'package:salescrm/Models/allname.dart';
import 'package:salescrm/Models/bussinesstypemodel.dart';

import '../Models/allusersmodel.dart';

class NameMeetProvider with ChangeNotifier {

  List<ResultsNameMeet>? allnamesmodels;
  static late ResultsNameMeet selectedUser;
  static int pos = 0;
  static String id="0";
  static String contactno="";
  static String contactperson="";
  static String companyname="";

  static String dropdownvalueuser="Select Users";  // for month name

  selectUser(String cnumber, String cname, String cperson, ResultsNameMeet selectuser,int position){
    contactno=cnumber;
    contactperson=cperson;
    selectedUser=selectuser;
    companyname=cname;
    pos=position;
    print("Contact No is : "+contactno);
    print("Contact person is : "+contactperson);
    print("Company Name is : "+companyname);
    print("Select User is : "+selectedUser.name.toString());
    print("Select User position is : "+pos.toString());
    notifyListeners();
  }

  selectUserSearch(String cnumber, String cname, String cperson, ResultsNameMeet selectuser,int position){
    contactno=cnumber;
    contactperson=cperson;
    selectedUser=selectuser;
    companyname=cname;
    pos=position;
    print("Contact No is : "+contactno);
    print("Contact person is : "+contactperson);
    print("Company Name is : "+companyname);
    print("Select User is : "+selectedUser.name.toString());
    print("Select User position is : "+pos.toString());
    notifyListeners();
  }
}