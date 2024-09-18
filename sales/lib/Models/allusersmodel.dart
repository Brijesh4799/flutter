class AllUserModel {
  bool? status;
  List<ArticlesUsers>? articles;

  AllUserModel({this.status, this.articles});

  AllUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['articles'] != null) {
      articles = <ArticlesUsers>[];
      json['articles'].forEach((v) {
        articles!.add(new ArticlesUsers.fromJson(v));
      });
    }
  }
}

class ArticlesUsers {
  String? id;
  String? username;

  ArticlesUsers({this.id, this.username});

  ArticlesUsers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
  }
}

