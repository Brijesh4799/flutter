import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()

class LoginModel {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultsLogin {
  String? id;
  String? guestId;
  String? username;
  String? dob;
  String? type;
  String? otp;
  String? quotationId;
  String? Refid;
  String? queryId;
  String? error;

  ResultsLogin(
      {this.id,
        this.guestId,
        this.username,
        this.dob,
        this.type,
        this.otp,
        this.quotationId,
        this.Refid,
        this.queryId,
        this.error});

  ResultsLogin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    guestId = json['guestId'];
    username = json['username'];
    dob = json['dob'];
    type = json['type'];
    otp = json['otp'];
    quotationId = json['quotationId'];
    Refid = json['Refid'];
    error = json['error'];
    queryId = json['queryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['guestId'] = this.guestId;
    data['username'] = this.username;
    data['dob'] = this.dob;
    data['type'] = this.type;
    data['otp'] = this.otp;
    data['quotationId'] = this.quotationId;
    data['Refid'] = this.Refid;
    data['error'] = this.error;
    data['queryId'] = this.queryId;
    return data;
  }
}




