class AlertMeetDetailModel {
  String? status;
  List<ResultAlertMeetDetail>? result;

  AlertMeetDetailModel({this.status, this.result});

  AlertMeetDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <ResultAlertMeetDetail>[];
      json['result'].forEach((v) {
        result!.add(new ResultAlertMeetDetail.fromJson(v));
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

class ResultAlertMeetDetail {
  String? id;
  String? time;
  String? contactPerson;
  String? date;
  String? company;
  String? product;
  String? subject;
  String? number;

  ResultAlertMeetDetail(
      {this.id,
        this.time,
        this.contactPerson,
        this.date,
        this.company,
        this.product,
        this.subject,
        this.number});

  ResultAlertMeetDetail.fromJson(Map<String, dynamic> json) {
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