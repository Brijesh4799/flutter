import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()

class InvoiceModel {
  String? status;
  List<ResultsInvoice>? results;

  InvoiceModel({this.status, this.results});

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <ResultsInvoice>[];
      json['results'].forEach((v) {
        results!.add(new ResultsInvoice.fromJson(v));
      });
    }
  }
}

class ResultsInvoice {
  String? tripName;
  String? queryId;
  String? invoicePdfLink;

  ResultsInvoice({this.tripName, this.queryId, this.invoicePdfLink});

  ResultsInvoice.fromJson(Map<String, dynamic> json) {
    tripName = json['tripName'];
    queryId = json['queryId'];
    invoicePdfLink = json['invoicePdfLink'];
  }
}


