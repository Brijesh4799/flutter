class AlertModel {
  String? status;
  List<AlertDetailsAlert>? alertDetails;

  AlertModel({this.status, this.alertDetails});

  AlertModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['alertDetails'] != null) {
      alertDetails = <AlertDetailsAlert>[];
      json['alertDetails'].forEach((v) {
        alertDetails!.add(new AlertDetailsAlert.fromJson(v));
      });
    }
  }
}

class AlertDetailsAlert {
  String? id;
  String? dutystatus;
  String? message;
  String? show;
 // bool? isClickSet = false;

  AlertDetailsAlert({this.id, this.dutystatus, this.message});

  AlertDetailsAlert.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dutystatus = json['dutystatus'];
    message = json['message'];
    show = json['show'];
   // isClickSet = json['isClickSet'];
  }
}