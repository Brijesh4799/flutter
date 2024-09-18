class AddCallModel {
  String? status;
  List<ResultsAddCall>? results;

  AddCallModel({this.status, this.results});

  AddCallModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <ResultsAddCall>[];
      json['results'].forEach((v) {
        results!.add(new ResultsAddCall.fromJson(v));
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

class ResultsAddCall {
  String? msg;

  ResultsAddCall({this.msg});

  ResultsAddCall.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    return data;
  }
}