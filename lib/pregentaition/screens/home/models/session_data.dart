class SessionData {
  String? sId;
  String? name;
  int? price;
  String? location;
  String? date;
  String? time;
  String? image;
  String? createdAt;
  bool? isbooked;
  Host? host;

  SessionData(
      {this.sId,
        this.name,
        this.price,
        this.location,
        this.date,
        this.time,
        this.image,
        this.createdAt,
        this.isbooked,
        this.host});

  SessionData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    price = json['price'];
    location = json['location'];
    date = json['date'];
    time = json['time'];
    image = json['image'];
    createdAt = json['createdAt'];
    isbooked = json['isbooked'];
    host = json['host'] != null ? new Host.fromJson(json['host']) : null;
  }

}

class Host {
  String? name;
  String? email;
  String? image;

  Host({this.name, this.email, this.image});

  Host.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    image = json['image'];
  }

}
