class AddExpModel {
  String? status;
  List<ResultsAddExp>? results;

  AddExpModel({this.status, this.results});

  AddExpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <ResultsAddExp>[];
      json['results'].forEach((v) {
        results!.add(new ResultsAddExp.fromJson(v));
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

class ResultsAddExp {
  String? result;

  ResultsAddExp({this.result});

  ResultsAddExp.fromJson(Map<String, dynamic> json) {
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    return data;
  }
}
