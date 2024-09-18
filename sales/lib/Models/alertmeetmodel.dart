class AlertsMeetModel {
  String? status;
  List<ResultsAlertMeet>? results;

  AlertsMeetModel({this.status, this.results});

  AlertsMeetModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <ResultsAlertMeet>[];
      json['results'].forEach((v) {
        results!.add(new ResultsAlertMeet.fromJson(v));
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

class ResultsAlertMeet {
  String? id;
  String? time;
  String? contactPerson;
  String? date;
  String? show;

  ResultsAlertMeet({this.id, this.time, this.contactPerson, this.date, this.show});

  ResultsAlertMeet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    time = json['time'];
    contactPerson = json['contactPerson'];
    date = json['Date'];
    show = json['show'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['time'] = this.time;
    data['contactPerson'] = this.contactPerson;
    data['Date'] = this.date;
    data['show'] = this.show;
    return data;
  }
}