class TaskModel {
  String? status;
  List<ResultsTask>? results;

  TaskModel({this.status, this.results});

  TaskModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <ResultsTask>[];
      json['results'].forEach((v) {
        results!.add(new ResultsTask.fromJson(v));
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

class ResultsTask {
  String? id;
  String? leadid;
  String? taskSubject;
  String? client;
  String? startdate;
  String? name;
  String? status;
  String? contactno;
  String? clientType;
  String? description;
  String? starttime;
  String? followupdate;
  String? date;
  String? reminderTime;
  String? priorty;
  String? location;
  String? phoneNo;
  String? meeting_agenda;
  String? salesperson;

  ResultsTask(
      {this.id,
        this.leadid,
        this.taskSubject,
        this.client,
        this.startdate,
        this.name,
        this.status,
        this.salesperson,
        this.contactno,
        this.clientType,
        this.description,
        this.starttime,
        this.followupdate,
        this.date,
        this.reminderTime,
        this.priorty,
        this.location,
        this.meeting_agenda,
        this.phoneNo});

  ResultsTask.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadid = json['leadid'];
    taskSubject = json['Task_subject'];
    client = json['client'];
    startdate = json['startdate'];
    name = json['name'];
    status = json['status'];
    salesperson = json['salesperson'];
    contactno = json['contactno'];
    clientType = json['clientType'];
    description = json['description'];
    starttime = json['starttime'];
    followupdate = json['followupdate'];
    date = json['date'];
    reminderTime = json['reminderTime'];
    priorty = json['priorty'];
    location = json['location'];
    meeting_agenda = json['meeting_agenda'];
    phoneNo = json['phoneNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['leadid'] = this.leadid;
    data['Task_subject'] = this.taskSubject;
    data['client'] = this.client;
    data['startdate'] = this.startdate;
    data['name'] = this.name;
    data['status'] = this.status;
    data['salesperson'] = this.salesperson;
    data['contactno'] = this.contactno;
    data['clientType'] = this.clientType;
    data['description'] = this.description;
    data['starttime'] = this.starttime;
    data['followupdate'] = this.followupdate;
    data['date'] = this.date;
    data['reminderTime'] = this.reminderTime;
    data['priorty'] = this.priorty;
    data['location'] = this.location;
    data['meeting_agenda'] =this.meeting_agenda;
    data['phoneNo'] = this.phoneNo;
    return data;
  }
}