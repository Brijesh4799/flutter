class CompleteModel {
  String? status;
  String? comment;
  List<CompleteDutiesList>? completeDuties;

  CompleteModel({this.status, this.comment, this.completeDuties});

  CompleteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    comment = json['comment'];
    if (json['completeDuties'] != null) {
      completeDuties = <CompleteDutiesList>[];
      json['completeDuties'].forEach((v) {
        completeDuties!.add(new CompleteDutiesList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['comment'] = this.comment;
    if (this.completeDuties != null) {
      data['completeDuties'] =
          this.completeDuties!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CompleteDutiesList {
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
  String? pickupTime;
  String? pickupDate="0";
  String? dropTime;
  String? startReading;
  String? endReading;
  String? actualPickupTime;
  String? actualdropTime;
  String? pickupAddress;
  String? serviceType;
  String? tourId;
  String? leadPaxName;
  String? dropAddress;

  CompleteDutiesList(
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
        this.pickupTime,
        this.dropTime,
        this.startReading,
        this.endReading,
        this.actualPickupTime,
        this.actualdropTime,
        this.pickupAddress,
        this.serviceType,
        this.tourId,
        this.leadPaxName,
        this.dropAddress});

  CompleteDutiesList.fromJson(Map<String, dynamic> json) {
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
    startReading = json['startReading'];
    endReading = json['endReading'];
    actualPickupTime = json['actualPickupTime'];
    actualdropTime = json['actualdropTime'];
    pickupAddress = json['pickupAddress'];
    serviceType = json['serviceType'];
    tourId = json['tourId'];
    leadPaxName = json['leadPaxName'];
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
    data['pickupDate'] = this.pickupDate;
    data['guest'] = this.guest;
    data['guestname'] = this.guestname;
    data['guestphone'] = this.guestphone;
    data['night'] = this.night;
    data['pickupTime'] = this.pickupTime;
    data['dropTime'] = this.dropTime;
    data['startReading'] = this.startReading;
    data['endReading'] = this.endReading;
    data['actualPickupTime'] = this.actualPickupTime;
    data['actualdropTime'] = this.actualdropTime;
    data['pickupAddress'] = this.pickupAddress;
    data['serviceType'] = this.serviceType;
    data['tourId'] = this.tourId;
    data['leadPaxName'] = this.leadPaxName;
    data['dropAddress'] = this.dropAddress;
    return data;
  }
}