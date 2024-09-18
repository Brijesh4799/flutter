import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()

class IteModel {
  String? status;
  String? quotationId;
  String? quotationRefNo;
  String? quotationFromDate;
  String? quotationToDate;
  String? displayId;
  List<DaysIte>? days;

  IteModel(
      {this.status,
        this.quotationId,
        this.quotationRefNo,
        this.quotationFromDate,
        this.quotationToDate,
        this.displayId,
        this.days});

  IteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    quotationId = json['QuotationId'];
    quotationRefNo = json['QuotationRefNo'];
    quotationFromDate = json['QuotationFromDate'];
    quotationToDate = json['QuotationToDate'];
    displayId = json['DisplayId'];
    if (json['Days'] != null) {
      days = <DaysIte>[];
      json['Days'].forEach((v) {
        days!.add(new DaysIte.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['QuotationId'] = this.quotationId;
    data['QuotationRefNo'] = this.quotationRefNo;
    data['QuotationFromDate'] = this.quotationFromDate;
    data['QuotationToDate'] = this.quotationToDate;
    data['DisplayId'] = this.displayId;
    if (this.days != null) {
      data['Days'] = this.days!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DaysIte {
  String? dayNumber;
  String? dayId;
  String? dayTitle;
  String? quotationTitle;
  String? quotationsubject;
  String? date;
  List<ServicesIte>? services;

  DaysIte(
      {this.dayNumber,
        this.dayId,
        this.dayTitle,
        this.quotationTitle,
        this.quotationsubject,
        this.date,
        this.services});

  DaysIte.fromJson(Map<String, dynamic> json) {
    dayNumber = json['DayNumber'];
    dayId = json['DayId'];
    dayTitle = json['DayTitle'];
    quotationTitle = json['QuotationTitle'];
    quotationsubject = json['Quotationsubject'];
    date = json['Date'];
    if (json['Services'] != null) {
      services = <ServicesIte>[];
      json['Services'].forEach((v) {
        services!.add(new ServicesIte.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DayNumber'] = this.dayNumber;
    data['DayId'] = this.dayId;
    data['DayTitle'] = this.dayTitle;
    data['QuotationTitle'] = this.quotationTitle;
    data['Quotationsubject'] = this.quotationsubject;
    data['Date'] = this.date;
    if (this.services != null) {
      data['Services'] = this.services!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServicesIte {
  String? iD;
  String? serviceTypeId;
  String? serviceImage;
  String? serviceTypeName;
  String? serviceID;
  String? serviceCategory;
  String? serviceDetails;
  String? serviceDetails01;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? feedback;
  String? voucherURL;

  ServicesIte(
      {this.iD,
        this.serviceTypeId,
        this.serviceImage,
        this.serviceTypeName,
        this.serviceID,
        this.serviceCategory,
        this.serviceDetails,
        this.serviceDetails01,
        this.startDate,
        this.endDate,
        this.startTime,
        this.endTime,
        this.feedback,
        this.voucherURL});

  ServicesIte.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    serviceTypeId = json['ServiceTypeId'];
    serviceImage = json['ServiceImage'];
    serviceTypeName = json['ServiceTypeName'];
    serviceID = json['ServiceID'];
    serviceCategory = json['ServiceCategory'];
    serviceDetails = json['ServiceDetails'];
    serviceDetails01 = json['ServiceDetails_01'];
    startDate = json['StartDate'];
    endDate = json['EndDate'];
    startTime = json['StartTime'];
    endTime = json['EndTime'];
    feedback = json['Feedback'];
    voucherURL = json['VoucherURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['ServiceTypeId'] = this.serviceTypeId;
    data['ServiceImage'] = this.serviceImage;
    data['ServiceTypeName'] = this.serviceTypeName;
    data['ServiceID'] = this.serviceID;
    data['ServiceCategory'] = this.serviceCategory;
    data['ServiceDetails'] = this.serviceDetails;
    data['ServiceDetails_01'] = this.serviceDetails01;
    data['StartDate'] = this.startDate;
    data['EndDate'] = this.endDate;
    data['StartTime'] = this.startTime;
    data['EndTime'] = this.endTime;
    data['Feedback'] = this.feedback;
    data['VoucherURL'] = this.voucherURL;
    return data;
  }
}

class AlertModel {
  String status;
  String img;
  String time;
  String name;
  String period;
  String date;
  String arrow;

  AlertModel(
      { required this.status,
        required this.img,
        required this.time,
        required this.name,
        required this.period,
        required this.date,
        required this.arrow});
}



