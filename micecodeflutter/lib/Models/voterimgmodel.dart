class VoterFeed {
  String? status;
  List<ResultsVoter>? result;

  VoterFeed({this.status, this.result});

  VoterFeed.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <ResultsVoter>[];
      json['result'].forEach((v) {
        result!.add(new ResultsVoter.fromJson(v));
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

class ResultsVoter {
  String? msg;
  String? img1;
  String? img2;

  ResultsVoter({this.msg, this.img1, this.img2});

  ResultsVoter.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    img1 = json['img1'];
    img2 = json['img2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['img1'] = this.img1;
    data['img2'] = this.img2;
    return data;
  }
}