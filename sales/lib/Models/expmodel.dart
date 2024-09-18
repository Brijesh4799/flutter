class ExpModel {
  String? status;
  List<ResultsExp>? results;

  ExpModel({this.status, this.results});

  ExpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['results'] != null) {
      results = <ResultsExp>[];
      json['results'].forEach((v) {
        results!.add(new ResultsExp.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultsExp {
  String? id;
  String? status;
  String? type;
  String? expenseAmount;
  String? expenseDate;
  String? attachment;

  ResultsExp(
      {this.id,
        this.status,
        this.type,
        this.expenseAmount,
        this.expenseDate,
        this.attachment});

  ResultsExp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    type = json['type'];
    expenseAmount = json['expenseAmount'];
    expenseDate = json['expenseDate'];
    attachment = json['attachment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['type'] = this.type;
    data['expenseAmount'] = this.expenseAmount;
    data['expenseDate'] = this.expenseDate;
    data['attachment'] = this.attachment;
    return data;
  }
}
