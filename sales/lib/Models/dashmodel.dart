class DashModel {
  String? status;
  List<ResultsDash>? results;

  DashModel({this.status, this.results});

  DashModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <ResultsDash>[];
      json['results'].forEach((v) {
        results!.add(new ResultsDash.fromJson(v));
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

class ResultsDash {
  String? totalCalls;
  String? totalmeetings;
  String? totaltasks;
  String? totalsale;
  String? totaltarget;

  ResultsDash(
      {this.totalCalls, this.totalmeetings, this.totaltasks, this.totalsale, this.totaltarget});

  ResultsDash.fromJson(Map<String, dynamic> json) {
    totalCalls = json['totalCalls'];
    totalmeetings = json['totalmeetings'];
    totaltasks = json['totaltasks'];
    totalsale = json['totalsale'];
    totaltarget = json['totaltarget'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCalls'] = this.totalCalls;
    data['totalmeetings'] = this.totalmeetings;
    data['totaltasks'] = this.totaltasks;
    data['totalsale'] = this.totalsale;
    data['totaltarget'] = this.totaltarget;
    return data;
  }
}