import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:salescrm/Models/bussinesstypemodel.dart';

import '../Models/allusersmodel.dart';

class CallProvider with ChangeNotifier{

  List<ArticlesUsers>? allusermodels;
  static late ArticlesUsers selectedUser;
  static int pos = 0;
  static String id="0";
  static String username="Administrator";
  static String userid="0";

  List<ArticlesBussinessType>? bustypemodel;
  static late ArticlesBussinessType selectedBustype;
  static int busstypepos = 0;
  static String bustypename="Bussiness Type";
  static String bustypeid="0";

  static String busstpye="All Business Type";
  static String bussvalue="1";

  static String assigntpye="All Assigned Users";
  static String assivalue="1";

  static String statustpye="Status";
  static String typevalue="";

  static String activitytpye="Call";
  static String activityvalue="1";

  static String activitytpye1="Meeting";
  static String activityvalue1="1";

  static String activitytpye2="Task";
  static String activityvalue2="1";

  static String businesstpye="Agent";
  static String businessvalue="1";

  static String calltpye="Incoming";
  static String callvalue="1";

  static String statuscalltpye="Held";
  static String statuscallvalue="2";

  static String timetpye="10:00 AM";
  static String timevalue="10:00 AM";

  static String nexttimetpye="10:00 AM";
  static String nexttimevalue="10:00 AM";

  static String prodtpye="TRAVCRM Inbound";
  static String prodvalue="1";

  static String companytpye="Agent";
  static String companyvalue="1";

  static String operationtpye="Sales";
  static String operationvalue="1";

  static String prioritytype="LOW";
  static String priorityvalue="1";


  selectBussT(){
    switch(busstpye){
      case "All Business Type":
        bussvalue="1";
        print(bussvalue);
        notifyListeners();
        break;

      case "Agent":
        bussvalue="2";
        print(bussvalue);
        notifyListeners();
        break;


      case "Corporate":
        bussvalue="3";
        print(bussvalue);
        notifyListeners();
        break;


      case "Employee":
        bussvalue="4";
        print(bussvalue);
        notifyListeners();
        break;

      case "Local Agent":
        bussvalue="5";
        print(bussvalue);
        notifyListeners();
        break;

      case "UAE Parnar":
        bussvalue="6";
        print(bussvalue);
        notifyListeners();
        break;
    }
  }

  selectAssign() {
    switch(assigntpye){
      case "All Assigned Users":
        assivalue="1";
        print(assivalue);
        notifyListeners();
        break;

      case "Praveen Kumar":
        assivalue="2";
        print(assivalue);
        notifyListeners();
        break;

      case "Advik Jain":
        assivalue="3";
        print(assivalue);
        notifyListeners();
        break;



      case "Mahendra Soni":
        assivalue="4";
        print(assivalue);
        notifyListeners();
        break;

      case "Nikhil Agarwal":
        assivalue="5";
        print(assivalue);
        notifyListeners();
        break;
    }
  }

  selectTypes(){
    switch(statustpye){
      case "Status":
        typevalue="";
        print(typevalue);
        notifyListeners();
        break;

      case "Scheduled":
        typevalue="1";
        print(typevalue);
        notifyListeners();
        break;

      case "Held":
        typevalue="2";
        print(typevalue);
        notifyListeners();
        break;

      case "Canceled":
        typevalue="3";
        print(typevalue);
        notifyListeners();
        break;
    }
  }

  selectActivity(){
    switch(activitytpye){

      case "Call":
        activityvalue="1";
        print(activityvalue);
        notifyListeners();
        break;

      case "Agent":
        activityvalue="2";
        print(activityvalue);
        notifyListeners();
        break;


    }
  }

  selectActivity1(){
    switch(activitytpye1){

      case "Meeting":
        activityvalue1="1";
        print(activityvalue1);
        notifyListeners();
        break;

      case "Agent":
        activityvalue1="2";
        print(activityvalue1);
        notifyListeners();
        break;


    }
  }

  selectActivity2(){
    switch(activitytpye2){

      case "Task":
        activityvalue2="1";
        print(activityvalue2);
        notifyListeners();
        break;

      case "Agent":
        activityvalue2="2";
        print(activityvalue2);
        notifyListeners();
        break;


    }
  }

  selectBusiness(){
    switch(businesstpye){

      case "Agent":
        businessvalue="1";
        print(businessvalue);
        notifyListeners();
        break;

      case "B2C":
        businessvalue="2";
        print(businessvalue);
        notifyListeners();
        break;


    }
  }

  selectCall(){
    switch(calltpye){

      case "Incoming":
        callvalue="1";
        print(callvalue);
        notifyListeners();
        break;

      case "Outgoing":
        callvalue="2";
        print(callvalue);
        notifyListeners();
        break;

    }
  }

  selectStatus(){
    switch(statuscalltpye){

      case "Held":
        statuscallvalue="2";
        print(statuscallvalue);
        notifyListeners();
        break;

      case "Cancelled":
        statuscallvalue="3";
        print(statuscallvalue);
        notifyListeners();
        break;


    }
  }

  selectTime(){
    switch(timetpye){

      case "10:00 AM":
        timevalue="10:00 AM";
        print(timevalue);
        notifyListeners();
        break;

      case "11:00 AM":
        timevalue="11:00 AM";
        print(timevalue);
        notifyListeners();
        break;

      case "12:00 PM":
        timevalue="12:00 PM";
        print(timevalue);
        notifyListeners();
        break;

      case "01:00 PM":
        timevalue="01:00 PM";
        print(timevalue);
        notifyListeners();
        break;

      case "02:00 PM":
        timevalue="02:00 PM";
        print(timevalue);
        notifyListeners();
        break;

      case "03:00 PM":
        timevalue="03:00 PM";
        print(timevalue);
        notifyListeners();
        break;

      case "04:00 PM":
        timevalue="04:00 PM";
        print(timevalue);
        notifyListeners();
        break;

      case "05:00 PM":
        timevalue="05:00 PM";
        print(timevalue);
        notifyListeners();
        break;


    }
  }

  selectNextTime(){
    switch(nexttimetpye){

      case "10:00 AM":
        nexttimevalue="10:00 AM";
        print(nexttimevalue);
        notifyListeners();
        break;

      case "11:00 AM":
        nexttimevalue="11:00 AM";
        print(nexttimevalue);
        notifyListeners();
        break;

      case "12:00 PM":
        nexttimevalue="12:00 PM";
        print(nexttimevalue);
        notifyListeners();
        break;

      case "01:00 PM":
        nexttimevalue="01:00 PM";
        print(nexttimevalue);
        notifyListeners();
        break;

      case "02:00 PM":
        nexttimevalue="02:00 PM";
        print(nexttimevalue);
        notifyListeners();
        break;

      case "03:00 PM":
        nexttimevalue="03:00 PM";
        print(nexttimevalue);
        notifyListeners();
        break;

      case "04:00 PM":
        nexttimevalue="04:00 PM";
        print(nexttimevalue);
        notifyListeners();
        break;

      case "05:00 AM":
        nexttimevalue="05:00 PM";
        print(nexttimevalue);
        notifyListeners();
        break;


    }
  }

  selectProd(){
    switch(prodtpye){

      case "TRAVCRM Inbound":
        prodvalue="1";
        print(prodvalue);
        notifyListeners();
        break;

      case "TRAVCRM Outbound":
        prodvalue="2";
        print(prodvalue);
        notifyListeners();
        break;

      case "TRAVCRM MICE":
        prodvalue="3";
        print(prodvalue);
        notifyListeners();
        break;

      case "TRAVCRM Domestic":
        prodvalue="3";
        print(prodvalue);
        notifyListeners();
        break;
    }
  }

  selectCompany(){
    switch(companytpye){

      case "Agent":
        companyvalue="1";
        print(companyvalue);
        notifyListeners();
        break;

      case "B2C":
        companyvalue="2";
        print(companyvalue);
        notifyListeners();
        break;


    }
  }

  selectOperation(){
    switch(operationtpye){

      case "Sales":
        operationvalue="1";
        print(operationvalue);
        notifyListeners();
        break;

      case "Accounts":
        operationvalue="2";
        print(operationvalue);
        notifyListeners();
        break;

      case "Operations":
        operationvalue="3";
        print(operationvalue);
        notifyListeners();
        break;

      case "FIT Reservation":
        operationvalue="4";
        print(operationvalue);
        notifyListeners();
        break;

      case "GIT Reservation":
        operationvalue="5";
        print(operationvalue);
        notifyListeners();
        break;


    }
  }

  selectPriority(){
    switch(prioritytype){
      case "LOW":
        priorityvalue="1";
        print(priorityvalue);
        notifyListeners();
        break;

      case "MEDIUM":
        priorityvalue="2";
        print(priorityvalue);
        notifyListeners();
        break;

      case "HIGH":
        priorityvalue="2";
        print(priorityvalue);
        notifyListeners();
        break;
    }
  }

  selectUser(String myname, String myid, ArticlesUsers selectuser,int position){
    username=myname;
    userid=myid;
    selectedUser=selectuser;
    pos=position;
    print("User Name is : "+username);
    print("User ID is : "+userid);
    print("Select User is : "+selectedUser.username.toString());
    print("Select User position is : "+pos.toString());
    notifyListeners();
  }

  selectBusType(String myname, String myid, ArticlesBussinessType selectuser,int position){
    bustypename=myname;
    bustypeid=myid;
    selectedBustype=selectuser;
    busstypepos=position;
    print("Bus type Name is : "+bustypename);
    print("Bus type ID is : "+bustypeid);
    print("Select Bus type user is : "+selectedBustype.name.toString());
    print("Select Bus type User position is : "+busstypepos.toString());
    notifyListeners();
  }

}