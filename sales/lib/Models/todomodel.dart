class ToDoModel {
  String? sales;
  String? percentage;
  String? target;
  bool? status;
  String? totalResults;
  List<ArticlesTodo>? articles;

  ToDoModel(
      {this.sales,
        this.percentage,
        this.target,
        this.status,
        this.totalResults,
        this.articles});

  ToDoModel.fromJson(Map<String, dynamic> json) {
    sales = json['sales'];
    percentage = json['percentage'];
    target = json['target'];
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = <ArticlesTodo>[];
      json['articles'].forEach((v) {
        articles!.add(new ArticlesTodo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sales'] = this.sales;
    data['percentage'] = this.percentage;
    data['target'] = this.target;
    data['status'] = this.status;
    data['totalResults'] = this.totalResults;
    if (this.articles != null) {
      data['articles'] = this.articles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ArticlesTodo {
  String? id;
  String? module;
  String? view;
  String? queryId;
  String? clientname;
  String? clientphone;
  String? date;
  bool? isExpired;
  String? time;
  String? type;
  String? act;
  String? customer;
  String? product;

  ArticlesTodo(
      {this.id,
        this.module,
        this.view,
        this.queryId,
        this.clientname,
        this.clientphone,
        this.date,
        this.isExpired,
        this.time,
        this.type,
        this.act,
        this.customer,
        this.product});

  ArticlesTodo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    module = json['module'];
    view = json['view'];
    queryId = json['QueryId'];
    clientname = json['clientname'];
    clientphone = json['clientphone'];
    date = json['Date'];
    isExpired = json['isExpired'];
    time = json['Time'];
    type = json['Type'];
    act = json['act'];
    customer = json['customer'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['module'] = this.module;
    data['view'] = this.view;
    data['QueryId'] = this.queryId;
    data['clientname'] = this.clientname;
    data['clientphone'] = this.clientphone;
    data['Date'] = this.date;
    data['isExpired'] = this.isExpired;
    data['Time'] = this.time;
    data['Type'] = this.type;
    data['act'] = this.act;
    data['customer'] = this.customer;
    data['product'] = this.product;
    return data;
  }
}