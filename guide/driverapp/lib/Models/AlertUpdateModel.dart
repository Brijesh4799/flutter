class AlertUpdateModel {
  String? status;
  List<AlertDetailsUpdate>? alertDetails;

  AlertUpdateModel({this.status, this.alertDetails});

  AlertUpdateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['alertDetails'] != null) {
      alertDetails = <AlertDetailsUpdate>[];
      json['alertDetails'].forEach((v) {
        alertDetails!.add(new AlertDetailsUpdate.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.alertDetails != null) {
      data['alertDetails'] = this.alertDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AlertDetailsUpdate {
  String? message;

  AlertDetailsUpdate({this.message});

  AlertDetailsUpdate.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
