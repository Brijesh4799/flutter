class ToDoLatModel {
  bool? status;
  String? totalResults;
  List<ArticlesToDoLat>? articles;

  ToDoLatModel({this.status, this.totalResults, this.articles});

  ToDoLatModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = <ArticlesToDoLat>[];
      json['articles'].forEach((v) {
        articles!.add(new ArticlesToDoLat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['totalResults'] = this.totalResults;
    if (this.articles != null) {
      data['articles'] = this.articles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ArticlesToDoLat {
  String? id;
  String? act;
  String? customer;
  String? product;
  String? status;

  ArticlesToDoLat({this.id, this.act, this.customer, this.product, this.status});

  ArticlesToDoLat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    act = json['act'];
    customer = json['customer'];
    product = json['product'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['act'] = this.act;
    data['customer'] = this.customer;
    data['product'] = this.product;
    data['status'] = this.status;
    return data;
  }
}