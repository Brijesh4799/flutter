
class AllMeetName {
  String? status;
  List<ResultsNameMeet>? results;

  AllMeetName({this.status, this.results});

  AllMeetName.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <ResultsNameMeet>[];
      json['results'].forEach((v) {
        results!.add(new ResultsNameMeet.fromJson(v));
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

class ResultsNameMeet {
  String? name;
  String? contactPerson;
  String? contactNo;

  ResultsNameMeet({this.name, this.contactPerson, this.contactNo});

  ResultsNameMeet.fromJson(Map<String, dynamic> json) {
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