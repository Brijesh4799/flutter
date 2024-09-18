class FeedIteModel {
  String? status;
  List<ResultFeedIte>? result;

  FeedIteModel({this.status, this.result});

  FeedIteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <ResultFeedIte>[];
      json['result'].forEach((v) {
        result!.add(new ResultFeedIte.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultFeedIte {
  String? feed;
  String? msg;
  String? serviceType;
  String? quotationId;
  String? serviceId;

  ResultFeedIte(
      {this.feed,
        this.msg,
        this.serviceType,
        this.quotationId,
        this.serviceId});

  ResultFeedIte.fromJson(Map<String, dynamic> json) {
    feed = json['feed'];
    msg = json['msg'];
    serviceType = json['serviceType'];
    quotationId = json['quotationId'];
    serviceId = json['serviceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feed'] = this.feed;
    data['msg'] = this.msg;
    data['serviceType'] = this.serviceType;
    data['quotationId'] = this.quotationId;
    data['serviceId'] = this.serviceId;
    return data;
  }
}
