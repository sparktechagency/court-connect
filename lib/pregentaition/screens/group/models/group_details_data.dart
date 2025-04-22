class GroupDetailsData {
  String? id;
  String? communityName;
  String? communityDescription;
  String? communityImage;
  Creator? creator;
  List<Members>? members;
  int? totalMembers;

  GroupDetailsData({
    this.id,
    this.communityName,
    this.communityDescription,
    this.communityImage,
    this.creator,
    this.members,
    this.totalMembers,
  });

  GroupDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    communityName = json['communityName'];
    communityDescription = json['communityDescription'];
    communityImage = json['communityImage'];
    creator =
        json['creator'] != null ? new Creator.fromJson(json['creator']) : null;
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(new Members.fromJson(v));
      });
    }
    totalMembers = json['totalMembers'];
  }
}

class Creator {
  String? sId;
  String? name;
  Image? image;

  Creator({this.sId, this.name, this.image});

  Creator.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
  }
}

class Image {
  String? publicFileURL;

  Image({this.publicFileURL});

  Image.fromJson(Map<String, dynamic> json) {
    publicFileURL = json['publicFileURL'];
  }
}

class Members {
  String? id;
  String? name;
  String? image;
  String? joiningDate;

  Members({this.id, this.name, this.image, this.joiningDate});

  Members.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    joiningDate = json['joiningDate'];
  }
}
