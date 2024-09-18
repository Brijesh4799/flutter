class AcceptedListModel {
  String? status;
  String? comment;
  List<PendingAcceptedList>? pending;

  AcceptedListModel({this.status, this.comment, this.pending});

  AcceptedListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    comment = json['comment'];
    if (json['pending'] != null) {
      pending = <PendingAcceptedList>[];
      json['pending'].forEach((v) {
        pending!.add(new PendingAcceptedList.fromJson(v));
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

class PendingAcceptedList {
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
  String? pickupDate;
  String? pickupTime;
  String? actualPickupTime;
  String? dropTime;
  String? pickupAddress;
  String? dropAddress;
  String? descriptionUrl;
  String? tourId;
  String? serviceType;
  String? starttrip;
  String? leadPaxName;
  String? url;

  PendingAcceptedList(
      {this.id,
        this.quotationId,
        this.queryId,
        this.transferQuotId,
        this.subject,
        this.destination,
        this.tourDate,
        this.guest,
        this.guestname,
        this.guestphone,
        this.night,
        this.pickupDate,
        this.pickupTime,
        this.actualPickupTime,
        this.dropTime,
        this.pickupAddress,
        this.dropAddress,
        this.descriptionUrl,
        this.tourId,
        this.serviceType,
        this.starttrip,
        this.leadPaxName,
        this.url});

  PendingAcceptedList.fromJson(Map<String, dynamic> json) {
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
    pickupDate = json['pickupDate'];
    pickupTime = json['pickupTime'];
    actualPickupTime = json['actualPickupTime'];
    dropTime = json['dropTime'];
    pickupAddress = json['pickupAddress'];
    dropAddress = json['dropAddress'];
    descriptionUrl = json['descriptionUrl'];
    tourId = json['tourId'];
    serviceType = json['serviceType'];
    starttrip = json['starttrip'];
    leadPaxName = json['leadPaxName'];
    url = json['url'];
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
    data['pickupDate'] = this.pickupDate;
    data['pickupTime'] = this.pickupTime;
    data['actualPickupTime'] = this.actualPickupTime;
    data['dropTime'] = this.dropTime;
    data['pickupAddress'] = this.pickupAddress;
    data['dropAddress'] = this.dropAddress;
    data['descriptionUrl'] = this.descriptionUrl;
    data['tourId'] = this.tourId;
    data['serviceType'] = this.serviceType;
    data['starttrip'] = this.starttrip;
    data['leadPaxName'] = this.leadPaxName;
    data['url'] = this.url;
    return data;
  }
}