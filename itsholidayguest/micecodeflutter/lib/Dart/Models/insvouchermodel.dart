import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()

class InsVoucherModel {
  String? status;
  List<ResultsIns>? results;

  InsVoucherModel({this.status, this.results});

  InsVoucherModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <ResultsIns>[];
      json['results'].forEach((v) {
        results!.add(new ResultsIns.fromJson(v));
      });
    }
  }
}

class ResultsIns {
  String? qid;
  String? insuranceVoucher;

  ResultsIns({this.qid, this.insuranceVoucher});

  ResultsIns.fromJson(Map<String, dynamic> json) {
    qid = json['qid'];
    insuranceVoucher = json['insuranceVoucher'];
  }
}


