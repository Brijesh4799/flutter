import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()

class DetailIteModel {
  String? status;
  String? quotationId;
  String? quotationTitle;
  String? quotationRefNo;
  String? quotationFromDate;
  String? quotationToDate;
  String? quotationsubject;
  String? quotationDocumentURL;
  List<DaysDetailIte>? days;

  DetailIteModel(
      {this.status,
        this.quotationId,
        this.quotationTitle,
        this.quotationRefNo,
        this.quotationFromDate,
        this.quotationToDate,
        this.quotationsubject,
        this.quotationDocumentURL,
        this.days});

  DetailIteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    quotationId = json['QuotationId'];
    quotationTitle = json['QuotationTitle'];
    quotationRefNo = json['QuotationRefNo'];
    quotationFromDate = json['QuotationFromDate'];
    quotationToDate = json['QuotationToDate'];
    quotationsubject = json['Quotationsubject'];
    quotationDocumentURL = json['QuotationDocumentURL'];
    if (json['Days'] != null) {
      days = <DaysDetailIte>[];
      json['Days'].forEach((v) {
        days!.add(new DaysDetailIte.fromJson(v));
      });
    }
  }
}

class DaysDetailIte {
  String? dayNumber;
  String? dayId;
  String? dayTitle;
  String? sortdescription;
  String? date;
  List<ServicesDetailIte>? services;

  DaysDetailIte(
      {this.dayNumber,
        this.dayId,
        this.dayTitle,
        this.sortdescription,
        this.date,
        this.services});

  DaysDetailIte.fromJson(Map<String, dynamic> json) {
    dayNumber = json['DayNumber'];
    dayId = json['DayId'];
    dayTitle = json['DayTitle'];
    sortdescription = json['sortdescription'];
    date = json['Date'];
    if (json['Services'] != null) {
      services = <ServicesDetailIte>[];
      json['Services'].forEach((v) {
        services!.add(new ServicesDetailIte.fromJson(v));
      });
    }
  }

}

class ServicesDetailIte {
  String? iD;
  String? serviceTypeId;
  String? serviceTypeName;
  String? serviceDescription;
  String? serviceImage;

  ServicesDetailIte(
      {this.iD,
        this.serviceTypeId,
        this.serviceTypeName,
        this.serviceDescription,
        this.serviceImage});

  ServicesDetailIte.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    serviceTypeId = json['ServiceTypeId'];
    serviceTypeName = json['ServiceTypeName'];
    serviceDescription = json['ServiceDescription'];
    serviceImage = json['ServiceImage'];
  }
}


