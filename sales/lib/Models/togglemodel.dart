class ToggleModel {
  String? status;
  List<ResultsToggle>? results;

  ToggleModel({this.status, this.results});

  ToggleModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <ResultsToggle>[];
      json['results'].forEach((v) {
        results!.add(new ResultsToggle.fromJson(v));
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

class ResultsToggle {
  bool? statusclock;

  ResultsToggle({this.statusclock});

  ResultsToggle.fromJson(Map<String, dynamic> json) {
    statusclock = json['statusclock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusclock'] = this.statusclock;
    return data;
  }
}