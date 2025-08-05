class GroupData {
  String? id;
  String? name;
  String? description;
  String? createdAt;
  String? coverPhoto;
  String? photo;
  Creator? creator;
  int? totalMembers;

  GroupData(
      {this.id,
      this.name,
      this.description,
      this.createdAt,
      this.coverPhoto,
      this.photo,
      this.creator,
      this.totalMembers});

  GroupData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['createdAt'];
    coverPhoto = json['coverPhoto'];
    photo = json['photo'];
    creator =
        json['creator'] != null ? Creator.fromJson(json['creator']) : null;
    totalMembers = json['totalMembers'];
  }
}

class Creator {
  String? name;
  String? email;
  String? image;

  Creator({this.name, this.email, this.image});

  Creator.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    image = json['image'];
  }
}
