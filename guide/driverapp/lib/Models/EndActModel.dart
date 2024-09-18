class EndActModel {
  String? status;
  String? comment;
  List<AcceptBookingEnd>? acceptBooking;

  EndActModel({this.status, this.comment, this.acceptBooking});

  EndActModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    comment = json['comment'];
    if (json['acceptBooking'] != null) {
      acceptBooking = <AcceptBookingEnd>[];
      json['acceptBooking'].forEach((v) {
        acceptBooking!.add(new AcceptBookingEnd.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['comment'] = this.comment;
    if (this.acceptBooking != null) {
      data['acceptBooking'] =
          this.acceptBooking!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AcceptBookingEnd {
  String? message;

  AcceptBookingEnd({this.message});

  AcceptBookingEnd.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}