class PassPortFeed {
  String? status;
  List<ResultsPassPort>? result;

  PassPortFeed({this.status, this.result});

  PassPortFeed.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <ResultsPassPort>[];
      json['result'].forEach((v) {
        result!.add(new ResultsPassPort.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultsPassPort {
  String? msg;
  String? img1;
  String? passportno;
  String? passissueDate;
  String? passexDate;

  ResultsPassPort({this.msg, this.img1, this.passportno, this.passissueDate, this.passexDate});

  ResultsPassPort.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    img1 = json['img1'];
    passportno = json['passportno'];
    passissueDate = json['passissueDate'];
    passexDate = json['passexDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['img1'] = this.img1;
    data['passportno'] = this.passportno;
    data['passissueDate'] = this.passissueDate;
    data['passexDate'] = this.passexDate;
    return data;
  }
}