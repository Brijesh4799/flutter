class SeenModel {
  String? status;
  List<ResultSeen>? result;

  SeenModel({this.status, this.result});

  SeenModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <ResultSeen>[];
      json['result'].forEach((v) {
        result!.add(new ResultSeen.fromJson(v));
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

class ResultSeen {
  String?  seen;

  ResultSeen({this.seen});

  ResultSeen.fromJson(Map<String, dynamic> json) {
    seen = json['seen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seen'] = this.seen;
    return data;
  }
}