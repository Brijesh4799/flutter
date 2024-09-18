class StartTripModel {
  String? status;
  String? comment;
  List<StartTripBooking>? startTripBooking;

  StartTripModel({this.status, this.comment, this.startTripBooking});

  StartTripModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    comment = json['comment'];
    if (json['startTripBooking'] != null) {
      startTripBooking = <StartTripBooking>[];
      json['startTripBooking'].forEach((v) {
        startTripBooking!.add(new StartTripBooking.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['comment'] = this.comment;
    if (this.startTripBooking != null) {
      data['startTripBooking'] =
          this.startTripBooking!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StartTripBooking {
  String? message;

  StartTripBooking({this.message});

  StartTripBooking.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}