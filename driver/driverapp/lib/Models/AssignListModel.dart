class AssignListModel {
  String? status;
  String? comment;
  List<PendingAssignList>? pending;

  AssignListModel({this.status, this.comment, this.pending});

  AssignListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    comment = json['comment'];
    if (json['pending'] != null) {
      pending = <PendingAssignList>[];
      json['pending'].forEach((v) {
        pending!.add(new PendingAssignList.fromJson(v));
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

class PendingAssignList {
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
  String? dropTime;
  String? pickupAddress;
  String? tourId;
  String? leadPaxName;
  String? serviceType;
  String? dropAddress;

  PendingAssignList(
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
        this.dropTime,
        this.pickupAddress,
        this.tourId,
        this.leadPaxName,
        this.serviceType,
        this.dropAddress});

  PendingAssignList.fromJson(Map<String, dynamic> json) {
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
    dropTime = json['dropTime'];
    pickupAddress = json['pickupAddress'];
    tourId = json['tourId'];
    leadPaxName = json['leadPaxName'];
    serviceType = json['serviceType'];
    dropAddress = json['dropAddress'];
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
    data['dropTime'] = this.dropTime;
    data['pickupAddress'] = this.pickupAddress;
    data['tourId'] = this.tourId;
    data['leadPaxName'] = this.leadPaxName;
    data['serviceType'] = this.serviceType;
    data['dropAddress'] = this.dropAddress;
    return data;
  }
}