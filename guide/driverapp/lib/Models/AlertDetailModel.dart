class AlertDetailModel {
  String? status;
  List<DutyDetailsAlert>? dutyDetails;

  AlertDetailModel({this.status, this.dutyDetails});

  AlertDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['dutyDetails'] != null) {
      dutyDetails = <DutyDetailsAlert>[];
      json['dutyDetails'].forEach((v) {
        dutyDetails!.add(new DutyDetailsAlert.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.dutyDetails != null) {
      data['dutyDetails'] = this.dutyDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DutyDetailsAlert {
  String? id;
  String? tourName;
  String? tourId;
  String? startReading;
  String? endReading;
  String? actualPickupTime;
  String? actualdropTime;
  String? tourDate;

  DutyDetailsAlert(
      {this.id,
        this.tourName,
        this.tourId,
        this.startReading,
        this.endReading,
        this.actualPickupTime,
        this.actualdropTime,
        this.tourDate});

  DutyDetailsAlert.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tourName = json['tourName'];
    tourId = json['tourId'];
    startReading = json['startReading'];
    endReading = json['endReading'];
    actualPickupTime = json['actualPickupTime'];
    actualdropTime = json['actualdropTime'];
    tourDate = json['tourDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tourName'] = this.tourName;
    data['tourId'] = this.tourId;
    data['startReading'] = this.startReading;
    data['endReading'] = this.endReading;
    data['actualPickupTime'] = this.actualPickupTime;
    data['actualdropTime'] = this.actualdropTime;
    data['tourDate'] = this.tourDate;
    return data;
  }
}