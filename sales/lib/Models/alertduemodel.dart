class AlertDueModel {
  String? status;
  List<JsonResultAlertDue>? jsonResult;

  AlertDueModel({this.status, this.jsonResult});

  AlertDueModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['json_result'] != null) {
      jsonResult = <JsonResultAlertDue>[];
      json['json_result'].forEach((v) {
        jsonResult!.add(new JsonResultAlertDue.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.jsonResult != null) {
      data['json_result'] = this.jsonResult!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JsonResultAlertDue {
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
  String? showid;

  JsonResultAlertDue(
      {this.id,
        this.tourid,
        this.traveldate,
        this.agentname,
        this.contactperson,
        this.contactnumber,
        this.agenttotalamount,
        this.paymentduedate,
        this.overdueamount,
        this.aging,
        this.showid});

  JsonResultAlertDue.fromJson(Map<String, dynamic> json) {
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
    showid = json['showid'];
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
    data['showid'] = this.showid;
    return data;
  }
}
