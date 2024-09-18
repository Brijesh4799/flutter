class AlertTaskDetailModel {
  String? status;
  List<ResultAlertTaskDetail>? result;

  AlertTaskDetailModel({this.status, this.result});

  AlertTaskDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <ResultAlertTaskDetail>[];
      json['result'].forEach((v) {
        result!.add(new ResultAlertTaskDetail.fromJson(v));
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

class ResultAlertTaskDetail {
  String? id;
  String? time;
  String? contactPerson;
  String? date;
  String? company;
  String? product;
  String? subject;
  String? number;

  ResultAlertTaskDetail(
      {this.id,
        this.time,
        this.contactPerson,
        this.date,
        this.company,
        this.product,
        this.subject,
        this.number});

  ResultAlertTaskDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    time = json['time'];
    contactPerson = json['contactPerson'];
    date = json['Date'];
    company = json['company'];
    product = json['product'];
    subject = json['subject'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['time'] = this.time;
    data['contactPerson'] = this.contactPerson;
    data['Date'] = this.date;
    data['company'] = this.company;
    data['product'] = this.product;
    data['subject'] = this.subject;
    data['number'] = this.number;
    return data;
  }
}