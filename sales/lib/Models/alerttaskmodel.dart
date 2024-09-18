

class AlertTaskModel {
  String? status;
  List<ResultsAlertTask>? results;

  AlertTaskModel({this.status, this.results});

  AlertTaskModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <ResultsAlertTask>[];
      json['results'].forEach((v) {
        results!.add(new ResultsAlertTask.fromJson(v));
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

class ResultsAlertTask {
  String? id;
  String? time;
  String? contactPerson;
  String? date;
  String? subject;
  String? show;

  ResultsAlertTask(
      {this.id,
        this.time,
        this.contactPerson,
        this.date,
        this.subject,
        this.show});

  ResultsAlertTask.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    time = json['time'];
    contactPerson = json['contactPerson'];
    date = json['Date'];
    subject = json['subject'];
    show = json['show'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['time'] = this.time;
    data['contactPerson'] = this.contactPerson;
    data['Date'] = this.date;
    data['subject'] = this.subject;
    data['show'] = this.show;
    return data;
  }
}
