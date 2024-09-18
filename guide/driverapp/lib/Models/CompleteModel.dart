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
  String? service;
  String? tourId;
  String? leadPaxName;
  String? actualPickupTime;
  String? actualdropTime;
  String? pickupAndDropTime;
  String? pickupAndDropAddress;
  String? startReading;
  String? endReading;
  String? pickupDate;
  String? pickupTime;
  String? dropTime;

  CompleteDutiesList(
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
        this.service,
        this.tourId,
        this.leadPaxName,
        this.actualPickupTime,
        this.actualdropTime,
        this.pickupAndDropTime,
        this.pickupAndDropAddress,
        this.startReading,
        this.endReading,
        this.pickupDate,
        this.pickupTime,
        this.dropTime});

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
    service = json['service'];
    tourId = json['tourId'];
    leadPaxName = json['leadPaxName'];
    actualPickupTime = json['actualPickupTime'];
    actualdropTime = json['actualdropTime'];
    pickupAndDropTime = json['pickupAndDropTime'];
    pickupAndDropAddress = json['$pickupAndDropAddress'];
    startReading = json['startReading'];
    endReading = json['endReading'];
    pickupDate = json['pickupDate'];
    pickupTime = json['pickupTime'];
    dropTime = json['dropTime'];
  }
}