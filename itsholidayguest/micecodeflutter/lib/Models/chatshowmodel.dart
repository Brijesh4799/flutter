class ChatShowModel {
  String? status;
  List<ResultChatShow>? result;

  ChatShowModel({this.status, this.result});

  ChatShowModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <ResultChatShow>[];
      json['result'].forEach((v) {
        result!.add(new ResultChatShow.fromJson(v));
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

class ResultChatShow {
  String? message;
  String? days;
  String? time;
  String? response;

  ResultChatShow({this.message, this.days, this.time, this.response});

  ResultChatShow.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    days = json['days'];
    time = json['time'];
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['days'] = this.days;
    data['time'] = this.time;
    data['response'] = this.response;
    return data;
  }
}