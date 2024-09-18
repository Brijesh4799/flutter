class RatingFeed {
  String? status;
  List<ResultExp>? result;

  RatingFeed({this.status, this.result});

  RatingFeed.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <ResultExp>[];
      json['result'].forEach((v) {
        result!.add(new ResultExp.fromJson(v));
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

class ResultExp {
  String? refid;
  String? expfeedback;
  String? msg;

  ResultExp({this.refid, this.expfeedback, this.msg});

  ResultExp.fromJson(Map<String, dynamic> json) {
    refid = json['refid'];
    expfeedback = json['expfeedback'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refid'] = this.refid;
    data['expfeedback'] = this.expfeedback;
    data['msg'] = this.msg;
    return data;
  }
}