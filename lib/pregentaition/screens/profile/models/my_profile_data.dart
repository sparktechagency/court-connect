
class ProfileData {
  String? sId;
  String? name;
  String? email;
  String? role;
  String? image;

  ProfileData({this.sId, this.name, this.email, this.role, this.image});

  ProfileData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    image = json['image'];
  }
}
