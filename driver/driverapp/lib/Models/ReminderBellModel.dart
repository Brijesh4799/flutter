class ReminderBellModel{
  String? status;
  List<ResultReminderBell>? result;

  ReminderBellModel({this.status, this.result});

  ReminderBellModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <ResultReminderBell>[];
      json['result'].forEach((v) {
        result!.add(new ResultReminderBell.fromJson(v));
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

class ResultReminderBell {
  String? transferQuoteId;
  String? reminder;
  String? guestname;
  String? pickupdate;
  String? pickupTime;
  String? pickupadd;
  String? phone;

  ResultReminderBell(
      {this.transferQuoteId,
        this.reminder,
        this.guestname,
        this.pickupdate,
        this.pickupTime,
        this.pickupadd,
        this.phone});

  ResultReminderBell.fromJson(Map<String, dynamic> json) {
    transferQuoteId = json['transferQuoteId'];
    reminder = json['reminder'];
    guestname = json['guestname'];
    pickupdate = json['pickupdate'];
    pickupTime = json['pickupTime'];
    pickupadd = json['pickupadd'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transferQuoteId'] = this.transferQuoteId;
    data['reminder'] = this.reminder;
    data['guestname'] = this.guestname;
    data['pickupdate'] = this.pickupdate;
    data['pickupTime'] = this.pickupTime;
    data['pickupadd'] = this.pickupadd;
    data['phone'] = this.phone;
    return data;
  }
}