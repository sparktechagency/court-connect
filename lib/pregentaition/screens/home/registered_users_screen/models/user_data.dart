class UserData {
  String? id;
  String? name;
  String? email;
  String? image;
  String? bookingDate;

  UserData({
    this.id,
    this.name,
    this.email,
    this.image,
    this.bookingDate,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    bookingDate = json['bookingDate'];
  }
}
