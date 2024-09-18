class StartMeetModel {
  String? status;
  List<ResultsStartMeet>? results;

  StartMeetModel({this.status, this.results});

  StartMeetModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <ResultsStartMeet>[];
      json['results'].forEach((v) {
        results!.add(new ResultsStartMeet.fromJson(v));
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

class ResultsStartMeet {
  String? msg;

  ResultsStartMeet({this.msg});

  ResultsStartMeet.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    return data;
  }
}
