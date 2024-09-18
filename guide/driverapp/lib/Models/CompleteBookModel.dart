class CompleteBookModel {
  String? status;
  String? comment;
  List<AcceptBookingComplete>? acceptBooking;

  CompleteBookModel({this.status, this.comment, this.acceptBooking});

  CompleteBookModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    comment = json['comment'];
    if (json['acceptBooking'] != null) {
      acceptBooking = <AcceptBookingComplete>[];
      json['acceptBooking'].forEach((v) {
        acceptBooking!.add(new AcceptBookingComplete.fromJson(v));
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

class AcceptBookingComplete {
  String? message;

  AcceptBookingComplete({this.message});

  AcceptBookingComplete.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}