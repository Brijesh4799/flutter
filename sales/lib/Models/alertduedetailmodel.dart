class AlertDueDetailModel {
  String? status;
  List<ResultAlertDueDetail>? result;

  AlertDueDetailModel({this.status, this.result});

  AlertDueDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <ResultAlertDueDetail>[];
      json['result'].forEach((v) {
        result!.add(new ResultAlertDueDetail.fromJson(v));
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

class ResultAlertDueDetail {
  String? id;
  String? tourid;
  String? traveldate;
  String? agentname;
  String? contactperson;
  String? contactnumber;
  String? agenttotalamount;
  String? paymentduedate;
  String? overdueamount;
  String? aging;

  ResultAlertDueDetail(
      {this.id,
        this.tourid,
        this.traveldate,
        this.agentname,
        this.contactperson,
        this.contactnumber,
        this.agenttotalamount,
        this.paymentduedate,
        this.overdueamount,
        this.aging});

  ResultAlertDueDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tourid = json['tourid'];
    traveldate = json['traveldate'];
    agentname = json['agentname'];
    contactperson = json['contactperson'];
    contactnumber = json['contactnumber'];
    agenttotalamount = json['agenttotalamount'];
    paymentduedate = json['paymentduedate'];
    overdueamount = json['overdueamount'];
    aging = json['aging'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tourid'] = this.tourid;
    data['traveldate'] = this.traveldate;
    data['agentname'] = this.agentname;
    data['contactperson'] = this.contactperson;
    data['contactnumber'] = this.contactnumber;
    data['agenttotalamount'] = this.agenttotalamount;
    data['paymentduedate'] = this.paymentduedate;
    data['overdueamount'] = this.overdueamount;
    data['aging'] = this.aging;
    return data;
  }
}