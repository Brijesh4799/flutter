class B2CModel {
  String? status;
  List<ResultsB2c>? results;

  B2CModel({this.status, this.results});

  B2CModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <ResultsB2c>[];
      json['results'].forEach((v) {
        results!.add(new ResultsB2c.fromJson(v));
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

class ResultsB2c {
  String? salesperson;
  String? address;
  String? phone;
  String? email;

  ResultsB2c({this.salesperson, this.address, this.phone, this.email});

  ResultsB2c.fromJson(Map<String, dynamic> json) {
    salesperson = json['salesperson'];
    address = json['address'];
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salesperson'] = this.salesperson;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['email'] = this.email;
    return data;
  }
}

