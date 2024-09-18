class ToggleNotifyModel {
  String? status;
  List<ResultsToggleNotify>? results;

  ToggleNotifyModel({this.status, this.results});

  ToggleNotifyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <ResultsToggleNotify>[];
      json['results'].forEach((v) {
        results!.add(new ResultsToggleNotify.fromJson(v));
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

class ResultsToggleNotify {
  String? counter;
  String? duty;
  String? statusclock;

  ResultsToggleNotify({this.counter});

  ResultsToggleNotify.fromJson(Map<String, dynamic> json) {
    counter = json['counter'];
    duty = json['duty'];
    statusclock = json['statusclock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['counter'] = this.counter;
    data['duty'] = this.duty;
    data['statusclock'] = this.statusclock;
    return data;
  }
}