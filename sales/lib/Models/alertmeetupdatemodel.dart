class AlertMeetUpdateModel {
  String? status;
  List<ResultAlertMeetUpdate>? result;

  AlertMeetUpdateModel({this.status, this.result});

  AlertMeetUpdateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <ResultAlertMeetUpdate>[];
      json['result'].forEach((v) {
        result!.add(new ResultAlertMeetUpdate.fromJson(v));
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

class ResultAlertMeetUpdate {
  String? msg;

  ResultAlertMeetUpdate({this.msg});

  ResultAlertMeetUpdate.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    return data;
  }
}
