import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()

class FinanceModel {
  String? status;
  List<ResultsFinance>? results;

  FinanceModel({this.status, this.results});

  FinanceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <ResultsFinance>[];
      json['results'].forEach((v) {
        results!.add(new ResultsFinance.fromJson(v));
      });
    }
  }
}

class ResultsFinance {
  String? tripId;
  String? totalClientCost;
  String? received;
  String? pendingCost;

  ResultsFinance({this.tripId, this.totalClientCost, this.received, this.pendingCost});

  ResultsFinance.fromJson(Map<String, dynamic> json) {
    tripId = json['tripId'];
    totalClientCost = json['totalClientCost'];
    received = json['received'];
    pendingCost = json['pendingCost'];
  }
}


