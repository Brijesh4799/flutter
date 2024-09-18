class RatingFeed {
  String? status;
  List<ResultRating>? result;

  RatingFeed({this.status, this.result});

  RatingFeed.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <ResultRating>[];
      json['result'].forEach((v) {
        result!.add(new ResultRating.fromJson(v));
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

class ResultRating {
  String? refId;
  String? tripfeedback;
  String? msg;

  ResultRating({this.refId, this.tripfeedback, this.msg});

  ResultRating.fromJson(Map<String, dynamic> json) {
    refId = json['refId'];
    tripfeedback = json['tripfeedback'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refId'] = this.refId;
    data['tripfeedback'] = this.tripfeedback;
    data['msg'] = this.msg;
    return data;
  }
}