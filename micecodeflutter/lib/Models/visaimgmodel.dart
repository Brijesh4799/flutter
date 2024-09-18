class VisaFeed {
  String? status;
  List<ResultsVisa>? result;

  VisaFeed({this.status, this.result});

  VisaFeed.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <ResultsVisa>[];
      json['result'].forEach((v) {
        result!.add(new ResultsVisa.fromJson(v));
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

class ResultsVisa {
  String? msg;
  String? img1;

  ResultsVisa({this.msg, this.img1});

  ResultsVisa.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    img1 = json['img1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['img1'] = this.img1;

    return data;
  }
}