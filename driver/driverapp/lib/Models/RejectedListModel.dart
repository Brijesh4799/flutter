class RejectedListModel {
  String? status;
  String? comment;
  List<PendingRejectedList>? pending;

  RejectedListModel({this.status, this.comment, this.pending});

  RejectedListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    comment = json['comment'];
    if (json['pending'] != null) {
      pending = <PendingRejectedList>[];
      json['pending'].forEach((v) {
        pending!.add(new PendingRejectedList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['comment'] = this.comment;
    if (this.pending != null) {
      data['pending'] = this.pending!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PendingRejectedList {
  String? id;
  String? quotationId;
  String? queryId;
  String? transferQuotId;
  String? subject;
  String? destination;
  String? tourDate;
  String? guest;
  String? guestname;
  String? guestphone;
  String? night;
  String? pickupTime="0";
  String? pickupDate="0";
  String? dropTime="0";
  String? pickupAddress="0";
  String? tourId;
  String? serviceType;
  String? leadPaxName;
  String? dropAddress="0";
  String? service="0";

  PendingRejectedList(
      {this.id,
        this.quotationId,
        this.queryId,
        this.transferQuotId,
        this.subject,
        this.destination,
        this.tourDate,
        this.pickupDate,
        this.guest,
        this.guestname,
        this.guestphone,
        this.night,
        required this.pickupTime,
        required this.dropTime,
        required this.pickupAddress,
        this.tourId,
        this.serviceType,
        this.leadPaxName,
        required this.dropAddress,
        required this.service,
      });

  PendingRejectedList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quotationId = json['quotationId'];
    queryId = json['queryId'];
    transferQuotId = json['transferQuotId'];
    subject = json['subject'];
    destination = json['destination'];
    tourDate = json['tourDate'];
    guest = json['guest'];
    guestname = json['guestname'];
    guestphone = json['guestphone'];
    night = json['night'];
    pickupTime = json['pickupTime'];
    pickupDate = json['pickupDate'];
    dropTime = json['dropTime'];
    pickupAddress = json['pickupAddress'];
    tourId = json['tourId'];
    serviceType = json['serviceType'];
    leadPaxName = json['leadPaxName'];
    dropAddress = json['dropAddress'];
    service = json['service'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quotationId'] = this.quotationId;
    data['queryId'] = this.queryId;
    data['transferQuotId'] = this.transferQuotId;
    data['subject'] = this.subject;
    data['destination'] = this.destination;
    data['tourDate'] = this.tourDate;
    data['guest'] = this.guest;
    data['guestname'] = this.guestname;
    data['guestphone'] = this.guestphone;
    data['night'] = this.night;
    data['pickupTime'] = this.pickupTime;
    data['pickupDate'] = this.pickupDate;
    data['dropTime'] = this.dropTime;
    data['pickupAddress'] = this.pickupAddress;
    data['tourId'] = this.tourId;
    data['serviceType'] = this.serviceType;
    data['leadPaxName'] = this.leadPaxName;
    data['dropAddress'] = this.dropAddress;
    return data;
  }
}