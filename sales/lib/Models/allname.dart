class AllNameModel {
  String? status;
  List<ResultsAllName>? results;

  AllNameModel({this.status, this.results});

  AllNameModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <ResultsAllName>[];
      json['results'].forEach((v) {
        results!.add(new ResultsAllName.fromJson(v));
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

class ResultsAllName {
  String? name;
  String? contactPerson;
  String? contactNo;

  ResultsAllName({this.name, this.contactPerson, this.contactNo});

  ResultsAllName.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    contactPerson = json['contactPerson'];
    contactNo = json['contact no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['contactPerson'] = this.contactPerson;
    data['contact no'] = this.contactNo;
    return data;
  }
}