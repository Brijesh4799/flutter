class TourAssistanceModel {
  String? status;
  List<ResultsTour>? results;

  TourAssistanceModel({this.status, this.results});

  TourAssistanceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <ResultsTour>[];
      json['results'].forEach((v) {
        results!.add(new ResultsTour.fromJson(v));
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

class ResultsTour {
  String? name;
  String? email;
  String? phoneno;
  String? language;
  String? id;

  ResultsTour({this.name, this.email, this.phoneno, this.language,this.id});

  ResultsTour.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phoneno = json['phoneno'];
    language = json['language'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phoneno'] = this.phoneno;
    data['language'] = this.language;
    data['id'] = this.id;
    return data;
  }
}