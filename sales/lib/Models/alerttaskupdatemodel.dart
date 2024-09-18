class AlertTaskUpdateModel  {
  String? status;
  List<ResultAlertTaskUpdate>? result;

  AlertTaskUpdateModel({this.status, this.result});

  AlertTaskUpdateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <ResultAlertTaskUpdate>[];
      json['result'].forEach((v) {
        result!.add(new ResultAlertTaskUpdate.fromJson(v));
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

class ResultAlertTaskUpdate {
  String? msg;

  ResultAlertTaskUpdate({this.msg});

  ResultAlertTaskUpdate.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    return data;
  }
}