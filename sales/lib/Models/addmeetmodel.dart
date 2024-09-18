class AddMeetModel {
  String? status;
  List<ResultsAddMeet>? results;

  AddMeetModel({this.status, this.results});

  AddMeetModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <ResultsAddMeet>[];
      json['results'].forEach((v) {
        results!.add(new ResultsAddMeet.fromJson(v));
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

class ResultsAddMeet {
  String? msg;

  ResultsAddMeet({this.msg});

  ResultsAddMeet.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    return data;
  }
}