class AddNewModel {
  String? status;
  List<ResultsAddNew>? results;

  AddNewModel({this.status, this.results});

  AddNewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <ResultsAddNew>[];
      json['results'].forEach((v) {
        results!.add(new ResultsAddNew.fromJson(v));
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

class ResultsAddNew {
  String? result;

  ResultsAddNew({this.result});

  ResultsAddNew.fromJson(Map<String, dynamic> json) {
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    return data;
  }
}