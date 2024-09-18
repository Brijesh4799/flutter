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
}

class ResultsLogin {
  String? id;
  String? error;

  ResultsLogin({this.id, this.error});

  ResultsLogin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    error = json['error'];
  }
}