

class B2BModel {
  String? status;
  List<ResultsB2B>? results;

  B2BModel({this.status, this.results});

  B2BModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <ResultsB2B>[];
      json['results'].forEach((v) {
        results!.add(new ResultsB2B.fromJson(v));
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

class ResultsB2B {
  String? name;
  String? contactPerson;
  String? companyPhone;
  String? companyEmail;
  String? salesperson;
  String? status;

  ResultsB2B(
      {this.name,
        this.contactPerson,
        this.companyPhone,
        this.companyEmail,
        this.salesperson,
        this.status});

  ResultsB2B.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    contactPerson = json['contactPerson'];
    companyPhone = json['companyPhone'];
    companyEmail = json['companyEmail'];
    salesperson = json['salesperson'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['contactPerson'] = this.contactPerson;
    data['companyPhone'] = this.companyPhone;
    data['companyEmail'] = this.companyEmail;
    data['salesperson'] = this.salesperson;
    data['status'] = this.status;
    return data;
  }
}