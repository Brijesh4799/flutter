import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()

class AutoModel {
  String? status;
  List<ResultsAuto>? results;

  AutoModel({this.status, this.results});

  AutoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <ResultsAuto>[];
      json['results'].forEach((v) {
        results!.add(new ResultsAuto.fromJson(v));
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

class ResultsAuto {
  String? username;
  String? dob;
  String? error;

  ResultsAuto({this.username, this.dob, this.error});

  ResultsAuto.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    dob = json['dob'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['dob'] = this.dob;
    data['error'] = this.error;
    return data;
  }
}




