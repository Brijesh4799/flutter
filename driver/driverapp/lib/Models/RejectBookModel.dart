class RejectBookModel {
  String? status;
  String? comment;
  List<RejectBookingReject>? rejectBooking;

  RejectBookModel({this.status, this.comment, this.rejectBooking});

  RejectBookModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    comment = json['comment'];
    if (json['rejectBooking'] != null) {
      rejectBooking = <RejectBookingReject>[];
      json['rejectBooking'].forEach((v) {
        rejectBooking!.add(new RejectBookingReject.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['comment'] = this.comment;
    if (this.rejectBooking != null) {
      data['rejectBooking'] =
          this.rejectBooking!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RejectBookingReject {
  String? message;

  RejectBookingReject({this.message});

  RejectBookingReject.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}