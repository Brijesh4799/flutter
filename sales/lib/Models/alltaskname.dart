class AllTaskName{
  String? status;
  List<ResultsTaskName>? results;

  AllTaskName({this.status, this.results});

  AllTaskName.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <ResultsTaskName>[];
      json['results'].forEach((v) {
        results!.add(new ResultsTaskName.fromJson(v));
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

class ResultsTaskName {
  String? name;
  String? contactPerson;
  String? contactNo;

  ResultsTaskName({this.name, this.contactPerson, this.contactNo});

  ResultsTaskName.fromJson(Map<String, dynamic> json) {
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
