
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
  String? service;
  String? tourId;
  String? leadPaxName;
  String? pickupAndDropTime;
  String? pickupAndDropAddress;
  String? pickupDate;
  String? pickupTime;

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
        this.service,
        this.tourId,
        this.leadPaxName,
        this.pickupAndDropTime,
        this.pickupAndDropAddress,
        this.pickupDate,
        this.pickupTime});

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
    service = json['service'];
    tourId = json['tourId'];
    leadPaxName = json['leadPaxName'];
    pickupAndDropTime = json['pickupAndDropTime'];
    pickupAndDropAddress = json['$pickupAndDropAddress'];
    pickupDate = json['pickupDate'];
    pickupTime = json['pickupTime'];
  }
}