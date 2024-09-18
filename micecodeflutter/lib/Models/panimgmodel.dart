class PanFeed {
  String? status;
  List<ResultsPan>? result;

  PanFeed({this.status, this.result});

  PanFeed.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <ResultsPan>[];
      json['result'].forEach((v) {
        result!.add(new ResultsPan.fromJson(v));
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

class ResultsPan {
  String? msg;
  String? img1;

  ResultsPan({this.msg, this.img1});

  ResultsPan.fromJson(Map<String, dynamic> json) {
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