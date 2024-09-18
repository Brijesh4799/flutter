class AlertPayModel {
  String? status;
  List<ResultsAlertPay>? results;

  AlertPayModel({this.status, this.results});

  AlertPayModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <ResultsAlertPay>[];
      json['results'].forEach((v) {
        results!.add(new ResultsAlertPay.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultsAlertPay {
  String? id;
  String? showid;
  String? referanceNumber;
  String? tripId;
  String? totalClientCost;
  String? received;
  String? pendingCost;

  ResultsAlertPay({this.id,
    this.showid,
    this.referanceNumber,
    this.tripId,
    this.totalClientCost,
    this.received,
    this.pendingCost});

  ResultsAlertPay.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    showid = json['showid'];
    referanceNumber = json['referanceNumber'];
    tripId = json['tripId'];
    totalClientCost = json['totalClientCost'];
    received = json['received'];
    pendingCost = json['pendingCost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['showid'] = this.showid;
    data['referanceNumber'] = this.referanceNumber;
    data['tripId'] = this.tripId;
    data['totalClientCost'] = this.totalClientCost;
    data['received'] = this.received;
    data['pendingCost'] = this.pendingCost;
    return data;
  }
}