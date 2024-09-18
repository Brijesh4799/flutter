class StartActivityModel {
  String? status;
  List<ResultsStartAct>? results;

  StartActivityModel({this.status, this.results});

  StartActivityModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <ResultsStartAct>[];
      json['results'].forEach((v) {
        results!.add(new ResultsStartAct.fromJson(v));
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

class ResultsStartAct {
  String? message;

  ResultsStartAct({this.message});

  ResultsStartAct.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
