class PendingReportModel {
  String? status;
  String? comment;
  List<PendingReport>? pending;

  PendingReportModel({this.status, this.comment, this.pending});

  PendingReportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    comment = json['comment'];
    if (json['pending'] != null) {
      pending = <PendingReport>[];
      json['pending'].forEach((v) {
        pending!.add(new PendingReport.fromJson(v));
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

class PendingReport {
  String? id;
  String? quotationId;
  String? queryId;
  String? transferQuotId;
  String? subject;
  String? destination;
  String? tourDate;
  String? actualPickupTime;
  String? guest;
  String? guestname;
  String? guestphone;
  String? night;
  String? service;
  String? tourId;
  String? leadPaxName;
  String? starttrip;
  String? pickupAndDropTime;
  String? pickupAndDropAddress;
  String? descriptionUrl;
  String? url;
  String? pickupDate;
  String? pickupTime;
  String? dropTime;

  PendingReport(
      {this.id,
        this.quotationId,
        this.queryId,
        this.transferQuotId,
        this.subject,
        this.destination,
        this.tourDate,
        this.actualPickupTime,
        this.guest,
        this.guestname,
        this.guestphone,
        this.night,
        this.service,
        this.tourId,
        this.leadPaxName,
        this.starttrip,
        this.pickupAndDropTime,
        this.pickupAndDropAddress,
        this.descriptionUrl,
        this.url,
        this.pickupDate,
        this.pickupTime,
        this.dropTime});

  PendingReport.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quotationId = json['quotationId'];
    queryId = json['queryId'];
    transferQuotId = json['transferQuotId'];
    subject = json['subject'];
    destination = json['destination'];
    tourDate = json['tourDate'];
    actualPickupTime = json['actualPickupTime'];
    guest = json['guest'];
    guestname = json['guestname'];
    guestphone = json['guestphone'];
    night = json['night'];
    service = json['service'];
    tourId = json['tourId'];
    leadPaxName = json['leadPaxName'];
    starttrip = json['starttrip'];
    pickupAndDropTime = json['pickupAndDropTime'];
    pickupAndDropAddress = json['$pickupAndDropAddress'];
    descriptionUrl = json['descriptionUrl'];
    url = json['url'];
    pickupDate = json['pickupDate'];
    pickupTime = json['pickupTime'];
    dropTime = json['dropTime'];

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
    data['actualPickupTime'] = this.actualPickupTime;
    data['guest'] = this.guest;
    data['guestname'] = this.guestname;
    data['guestphone'] = this.guestphone;
    data['night'] = this.night;
    data['service'] = this.service;
    data['tourId'] = this.tourId;
    data['leadPaxName'] = this.leadPaxName;
    data['starttrip'] = this.starttrip;
    data['pickupAndDropTime'] = this.pickupAndDropTime;
    data['$pickupAndDropAddress'] = this.pickupAndDropAddress;
    data['descriptionUrl'] = this.descriptionUrl;
    data['url'] = this.url;
    data['pickupTime'] = this.pickupTime;
    data['pickupDate'] = this.pickupDate;
    return data;
  }
}