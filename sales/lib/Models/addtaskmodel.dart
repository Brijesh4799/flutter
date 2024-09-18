class AddTaskModel {
  String? status;
  List<ResultsAddTask>? results;

  AddTaskModel({this.status, this.results});

  AddTaskModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <ResultsAddTask>[];
      json['results'].forEach((v) {
        results!.add(new ResultsAddTask.fromJson(v));
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

class ResultsAddTask {
  String? msg;

  ResultsAddTask({this.msg});

  ResultsAddTask.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    return data;
  }
}