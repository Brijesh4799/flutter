class AlertpayDetailModel {
  String? status;
  List<ResultsAlertpayDetail>? results;

  AlertpayDetailModel({this.status, this.results});

  AlertpayDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <ResultsAlertpayDetail>[];
      json['results'].forEach((v) {
        results!.add(new ResultsAlertpayDetail.fromJson(v));
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

class ResultsAlertpayDetail {
  String? tripId;
  String? totalClientCost;
  String? received;
  String? pendingCost;

  ResultsAlertpayDetail({this.tripId, this.totalClientCost, this.received, this.pendingCost});

  ResultsAlertpayDetail.fromJson(Map<String, dynamic> json) {
    tripId = json['tripId'];
    totalClientCost = json['totalClientCost'];
    received = json['received'];
    pendingCost = json['pendingCost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tripId'] = this.tripId;
    data['totalClientCost'] = this.totalClientCost;
    data['received'] = this.received;
    data['pendingCost'] = this.pendingCost;
    return data;
  }
}
