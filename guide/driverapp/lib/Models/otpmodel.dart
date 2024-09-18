class OtpModel {
  String? status;
  String? comment;
  List<PolicyOtp>? policy;

  OtpModel({this.status, this.comment, this.policy});

  OtpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    comment = json['comment'];
    if (json['policy'] != null) {
      policy = <PolicyOtp>[];
      json['policy'].forEach((v) {
        policy!.add(new PolicyOtp.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['comment'] = this.comment;
    if (this.policy != null) {
      data['policy'] = this.policy!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PolicyOtp {
  String? userid;
  String? role;
  String? mobileNumber;
  String? onlineStatus;

  PolicyOtp({this.userid, this.role, this.mobileNumber, this.onlineStatus});

  PolicyOtp.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    role = json['role'];
    mobileNumber = json['mobileNumber'];
    onlineStatus = json['onlineStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['role'] = this.role;
    data['mobileNumber'] = this.mobileNumber;
    data['onlineStatus'] = this.onlineStatus;
    return data;
  }
}