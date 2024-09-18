class NotificationModel {
  String? status;
  List<NotificationsList>? notifications;

  NotificationModel({this.status, this.notifications});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['notifications'] != null) {
      notifications = <NotificationsList>[];
      json['notifications'].forEach((v) {
        notifications!.add(new NotificationsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationsList {
  String? countorders;

  NotificationsList({this.countorders});

  NotificationsList.fromJson(Map<String, dynamic> json) {
    countorders = json['countorders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countorders'] = this.countorders;
    return data;
  }
}