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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalPage'] = this.totalPage;
    data['currentPage'] = this.currentPage;
    data['prevPage'] = this.prevPage;
    data['nextPage'] = this.nextPage;
    data['limit'] = this.limit;
    data['totalItem'] = this.totalItem;
    return data;
  }
}




class ChatListData {
  String? chatId;
  Receiver? receiver;
  LastMessage? lastMessage;
  int? unreadCount;
  BlockBy? blockBy;

  ChatListData(
      {this.chatId,
        this.receiver,
        this.lastMessage,
        this.unreadCount,
        this.blockBy});

  ChatListData.fromJson(Map<String, dynamic> json) {
    chatId = json['chatId'];
    receiver = json['receiver'] != null
        ? new Receiver.fromJson(json['receiver'])
        : null;
    lastMessage = json['lastMessage'] != null
        ? new LastMessage.fromJson(json['lastMessage'])
        : null;
    unreadCount = json['unreadCount'];
    blockBy =
    json['blockBy'] != null ? new BlockBy.fromJson(json['blockBy']) : null;
  }

}

class Receiver {
  String? id;
  String? name;
  String? email;
  String? image;
  String? status;
  String? lastActive;

  Receiver(
      {this.id,
        this.name,
        this.email,
        this.image,
        this.status,
        this.lastActive});

  Receiver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    status = json['status'];
    lastActive = json['lastActive'];
  }


  Receiver copyWith({String? status,String? name, String ? id }){
    return Receiver(
      status: status,
      name: name,
      id: id
    );
  }

}





class LastMessage {
  String? message;
  String? createdAt;

  LastMessage({this.message, this.createdAt});

  LastMessage.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    createdAt = json['createdAt'];
  }

}

class BlockBy {
  String? id;
  String? name;

  BlockBy({this.id, this.name});

  BlockBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
