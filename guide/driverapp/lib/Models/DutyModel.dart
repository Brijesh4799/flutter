

class DutyModel {
  String? status;
  List<CircleList>? circleList;

  DutyModel({this.status, this.circleList});

  DutyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['CircleList'] != null) {
      circleList = <CircleList>[];
      json['CircleList'].forEach((v) {
        circleList!.add(new CircleList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.circleList != null) {
      data['CircleList'] = this.circleList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CircleList {
  String? totalasign;
  String? totalcompletedduty;
  String? pendingDuty;

  CircleList({this.totalasign, this.totalcompletedduty, this.pendingDuty});

  CircleList.fromJson(Map<String, dynamic> json) {
    totalasign = json['totalasign'];
    totalcompletedduty = json['totalcompletedduty'];
    pendingDuty = json['pendingDuty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalasign'] = this.totalasign;
    data['totalcompletedduty'] = this.totalcompletedduty;
    data['pendingDuty'] = this.pendingDuty;
    return data;
  }
}