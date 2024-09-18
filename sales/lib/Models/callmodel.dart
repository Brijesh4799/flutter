class CallModel {
  String? status;
  List<ResultsCall>? results;

  CallModel({this.status, this.results});

  CallModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <ResultsCall>[];
      json['results'].forEach((v) {
        results!.add(new ResultsCall.fromJson(v));
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

class ResultsCall {
  String? id;
  String? leadid;
  String? meetingAgenda;
  String? client;
  String? startdate;
  String? companyname;
  String? status;
  String? contactno;
  String? calltype;
  String? meetingsOutcome;
  String? salesperson;
  String? clientType;
  String? description;
  String? campaign;
  String? starttime;
  String? followupdate;
  String? date;
  String? location;
  String? phoneNo;

  ResultsCall(
      {this.id,
        this.leadid,
        this.meetingAgenda,
        this.client,
        this.startdate,
        this.companyname,
        this.status,
        this.contactno,
        this.calltype,
        this.meetingsOutcome,
        this.salesperson,
        this.clientType,
        this.description,
        this.campaign,
        this.starttime,
        this.followupdate,
        this.date,
        this.location,
        this.phoneNo});

  ResultsCall.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadid = json['leadid'];
    meetingAgenda = json['meeting_agenda'];
    client = json['client'];
    startdate = json['startdate'];
    companyname = json['companyname'];
    status = json['status'];
    contactno = json['contactno'];
    calltype = json['calltype'];
    meetingsOutcome = json['meetingsOutcome'];
    salesperson = json['salesperson'];
    clientType = json['clientType'];
    description = json['description'];
    campaign = json['campaign'];
    starttime = json['starttime'];
    followupdate = json['followupdate'];
    date = json['date'];
    location = json['location'];
    phoneNo = json['phoneNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['leadid'] = this.leadid;
    data['meeting_agenda'] = this.meetingAgenda;
    data['client'] = this.client;
    data['startdate'] = this.startdate;
    data['companyname'] = this.companyname;
    data['status'] = this.status;
    data['contactno'] = this.contactno;
    data['calltype'] = this.calltype;
    data['meetingsOutcome'] = this.meetingsOutcome;
    data['salesperson'] = this.salesperson;
    data['clientType'] = this.clientType;
    data['description'] = this.description;
    data['campaign'] = this.campaign;
    data['starttime'] = this.starttime;
    data['followupdate'] = this.followupdate;
    data['date'] = this.date;
    data['location'] = this.location;
    data['phoneNo'] = this.phoneNo;
    return data;
  }
}
