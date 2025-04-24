class Pagination {
  int? totalPage;
  int? currentPage;
  int? prevPage;
  int? nextPage;
  int? limit;
  int? totalItem;

  Pagination(
      {this.totalPage,
      this.currentPage,
      this.prevPage,
      this.nextPage,
      this.limit,
      this.totalItem});

  Pagination.fromJson(Map<String, dynamic> json) {
    totalPage = json['totalPage'];
    currentPage = json['currentPage'];
    prevPage = json['prevPage'];
    nextPage = json['nextPage'];
    limit = json['limit'];
    totalItem = json['totalItem'];
  }
}

class CommentData {
  String? sId;
  String? comment;
  String? createdAt;
  User? user;

  CommentData({this.sId, this.comment, this.createdAt, this.user});

  CommentData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    comment = json['comment'];
    createdAt = json['createdAt'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
}

class User {
  String? sId;
  String? name;
  String? email;
  String? image;

  User({this.sId, this.name, this.email, this.image});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
  }
}
