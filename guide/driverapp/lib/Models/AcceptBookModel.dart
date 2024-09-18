class AcceptBookModel {
  String? status;
  String? comment;
  List<AcceptBookingAccept>? acceptBooking;

  AcceptBookModel({this.status, this.comment, this.acceptBooking});

  AcceptBookModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    comment = json['comment'];
    if (json['acceptBooking'] != null) {
      acceptBooking = <AcceptBookingAccept>[];
      json['acceptBooking'].forEach((v) {
        acceptBooking!.add(new AcceptBookingAccept.fromJson(v));
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

class AcceptBookingAccept {
  String? message;

  AcceptBookingAccept({this.message});

  AcceptBookingAccept.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
