class AddNewMeetModel {
  String? status;
  List<ResultsAddNewMeet>? results;

  AddNewMeetModel({this.status, this.results});

  AddNewMeetModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <ResultsAddNewMeet>[];
      json['results'].forEach((v) {
        results!.add(new ResultsAddNewMeet.fromJson(v));
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

class ResultsAddNewMeet {
  String? bussinessType;
  String? name;
  String? companyname;
  String? contactPerson;
  String? companyPhone;
  String? email;
  String? address;
  String? designation;
  String? img;
  String? msg;

  ResultsAddNewMeet(
      {this.bussinessType,
        this.name,
        this.companyname,
        this.contactPerson,
        this.companyPhone,
        this.email,
        this.address,
        this.designation,
        this.img,
        this.msg});

  ResultsAddNewMeet.fromJson(Map<String, dynamic> json) {
    bussinessType = json['bussinessType'];
    name = json['name'];
    companyname = json['companyname'];
    contactPerson = json['contactPerson'];
    companyPhone = json['companyPhone'];
    email = json['email'];
    address = json['address'];
    designation = json['designation'];
    img = json['img'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bussinessType'] = this.bussinessType;
    data['name'] = this.name;
    data['companyname'] = this.companyname;
    data['contactPerson'] = this.contactPerson;
    data['companyPhone'] = this.companyPhone;
    data['email'] = this.email;
    data['address'] = this.address;
    data['designation'] = this.designation;
    data['img'] = this.img;
    data['msg'] = this.msg;
    return data;
  }
}
