class MeetingModel {
  String? status;
  List<ResultsMeeting>? results;

  MeetingModel({this.status, this.results});

  MeetingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <ResultsMeeting>[];
      json['results'].forEach((v) {
        results!.add(new ResultsMeeting.fromJson(v));
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

class ResultsMeeting {
  String? id;
  String? leadid;
  String? meetingAgenda;
  String? client;
  String? startdate;
  String? name;
  String? status;
  String? contactno;
  String? callsType;
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

  ResultsMeeting(
      {this.id,
        this.leadid,
        this.meetingAgenda,
        this.client,
        this.startdate,
        this.name,
        this.status,
        this.contactno,
        this.callsType,
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

  ResultsMeeting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadid = json['leadid'];
    meetingAgenda = json['meeting_agenda'];
    client = json['client'];
    startdate = json['startdate'];
    name = json['name'];
    status = json['status'];
    contactno = json['contactno'];
    callsType = json['calls type'];
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
    data['name'] = this.name;
    data['status'] = this.status;
    data['contactno'] = this.contactno;
    data['calls type'] = this.callsType;
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