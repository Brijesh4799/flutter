class ProfileModel {
  String? status;
  List<ProfileData>? profileData;

  ProfileModel({this.status, this.profileData});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['profileData'] != null) {
      profileData = <ProfileData>[];
      json['profileData'].forEach((v) {
        profileData!.add(new ProfileData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.profileData != null) {
      data['profileData'] = this.profileData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfileData {
  String? id;
  String? fullName;
  String? mobile;
  String? document;
  String? license;
  String? expiryDate;
  String? driverImage;

  ProfileData(
      {this.id,
        this.fullName,
        this.mobile,
        this.document,
        this.license,
        this.expiryDate,
        this.driverImage});

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    mobile = json['mobile'];
    document = json['document'];
    license = json['license'];
    expiryDate = json['expiryDate'];
    driverImage = json['driverImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['mobile'] = this.mobile;
    data['document'] = this.document;
    data['license'] = this.license;
    data['expiryDate'] = this.expiryDate;
    data['driverImage'] = this.driverImage;
    return data;
  }
}