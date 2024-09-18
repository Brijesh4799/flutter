import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()

class TravVoucherModel {
  String? status;
  List<ResultsTravVoucher>? results;

  TravVoucherModel({this.status, this.results});

  TravVoucherModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <ResultsTravVoucher>[];
      json['results'].forEach((v) {
        results!.add(new ResultsTravVoucher.fromJson(v));
      });
    }
  }
}

class ResultsTravVoucher {
  String? qid;
  String? clientVoucher;
  ResultsTravVoucher({this.qid, this.clientVoucher});
  ResultsTravVoucher.fromJson(Map<String, dynamic> json) {
    qid = json['qid'];
    clientVoucher = json['clientVoucher'];
  }
}


