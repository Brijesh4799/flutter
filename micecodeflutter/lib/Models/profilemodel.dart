import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()

class ProfileModel{
  String? status;
  List<ResultsProfile>? results;

  ProfileModel({this.status, this.results});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <ResultsProfile>[];
      json['results'].forEach((v) {
        results!.add(new ResultsProfile.fromJson(v));
      });
    }
  }
}

class ResultsProfile{
  String? id;
  String? firstName;
  String? lastName;
  String? country;
  String? mobile;
  String? email;
  String? dob;
  String? anniversaryDate;
  String? address;
  String? accomodationpreference;
  String? holidaypreference;
  String? mealPreference;
  String? specialassistance;

  ResultsProfile(
      {this.id,
        this.firstName,
        this.lastName,
        this.country,
        this.mobile,
        this.email,
        this.dob,
        this.anniversaryDate,
        this.address,
        this.accomodationpreference,
        this.holidaypreference,
        this.mealPreference,
        this.specialassistance});

  ResultsProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    country = json['country'];
    mobile = json['mobile'];
    email = json['email'];
    dob = json['dob'];
    anniversaryDate = json['anniversaryDate'];
    address = json['address'];
    accomodationpreference = json['accomodationpreference'];
    holidaypreference = json['holidaypreference'];
    mealPreference = json['mealPreference'];
    specialassistance = json['specialassistance'];
  }
}


