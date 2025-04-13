class BannerData {
  String? id;
  String? name;
  String? link;
  String? image;

  BannerData(
      {this.id,
        this.name,
        this.link,
        this.image,
      });

  BannerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    link = json['link'];
    image = json['image'];
  }

}

