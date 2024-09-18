class ChatMsgModel {
  String? status;
  List<ResultChatMsg>? result;

  ChatMsgModel({this.status, this.result});

  ChatMsgModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <ResultChatMsg>[];
      json['result'].forEach((v) {
        result!.add(new ResultChatMsg.fromJson(v));
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

class ResultChatMsg {
  String? message;

  ResultChatMsg({this.message});

  ResultChatMsg.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}