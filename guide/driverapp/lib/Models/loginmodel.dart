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
  String? userotp;
  String? mobileNumber;
  String? message;

  ResultsLogin({this.userotp, this.mobileNumber, this.message});

  ResultsLogin.fromJson(Map<String, dynamic> json) {
    userotp = json['userotp'];
    mobileNumber = json['mobileNumber'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userotp'] = this.userotp;
    data['mobileNumber'] = this.mobileNumber;
    data['message'] = this.message;
    return data;
  }
}