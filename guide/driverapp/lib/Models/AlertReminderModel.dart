class AlertReminderModel {
  String? status;
  List<ResultAlertReminder>? result;

  AlertReminderModel({this.status, this.result});

  AlertReminderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <ResultAlertReminder>[];
      json['result'].forEach((v) {
        result!.add(new ResultAlertReminder.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultAlertReminder {
  String? massege;

  ResultAlertReminder({this.massege});

  ResultAlertReminder.fromJson(Map<String, dynamic> json) {
    massege = json['massege'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['massege'] = this.massege;
    return data;
  }
}