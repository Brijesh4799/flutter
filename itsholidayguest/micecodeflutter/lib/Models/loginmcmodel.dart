class LoginmcModel {
  String? status;
  List<ResultsLoginmc>? results;

  LoginmcModel({this.status, this.results});

  LoginmcModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <ResultsLoginmc>[];
      json['results'].forEach((v) {
        results!.add(new ResultsLoginmc.fromJson(v));
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

class ResultsLoginmc {
  String? mobRefId;
  String? queryId;
  String? id;
  String? type;
  String? otp;
  String? adhaar;
  String? pan;
  String? pass;
  String? vacc;
  String? quotationId;
  String? mobile;
  String? error;

  ResultsLoginmc(
      {this.mobRefId,
        this.queryId,
        this.id,
        this.type,
        this.otp,
        this.adhaar,
        this.pan,
        this.pass,
        this.vacc,
        this.mobile,
        this.quotationId,
      this.error});

  ResultsLoginmc.fromJson(Map<String, dynamic> json) {
    mobRefId = json['mobRefId'];
    queryId = json['queryId'];
    id = json['id'];
    type = json['type'];
    otp = json['otp'];
    adhaar = json['adhaar'];
    pan = json['pan'];
    pass = json['pass'];
    vacc = json['Vacc'];
    quotationId = json['quotationId'];
    mobile = json['mobile'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobRefId'] = this.mobRefId;
    data['queryId'] = this.queryId;
    data['id'] = this.id;
    data['type'] = this.type;
    data['otp'] = this.otp;
    data['adhaar'] = this.adhaar;
    data['pan'] = this.pan;
    data['pass'] = this.pass;
    data['Vacc'] = this.vacc;
    data['quotationId'] = this.quotationId;
    data['mobile'] = this.mobile;
    data['error'] = this.error;
    return data;
  }
}
