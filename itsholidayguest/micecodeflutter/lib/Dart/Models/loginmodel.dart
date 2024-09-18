import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()

class LoginModel{
  String? status;
  List<ResultsLogin>? results;

  LoginModel({this.status, this.results});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <ResultsLogin>[];
      json['results'].forEach((v) {
        results!.add(new ResultsLogin.fromJson(v));
      });
    }
  }
}

class ResultsLogin {
  String? mobRefId;
  String? id;
  String? type;
  String? otp;
  String? error;
  String? quotationId;

  ResultsLogin({this.mobRefId, this.id, this.type, this.otp, this.error/*,this.quotationId*/});

  ResultsLogin.fromJson(Map<String, dynamic> json) {
    mobRefId = json['mobRefId'];
    id = json['id'];
    type = json['type'];
    otp = json['otp'];
    error = json['error'];
    quotationId = json['quotationId'];
  }
 Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobRefId'] = this.mobRefId;
    data['id'] = this.id;
    data['type'] = this.type;
    data['otp'] = this.otp;
    data['quotationId'] = this.quotationId;
    return data;
  }
}


