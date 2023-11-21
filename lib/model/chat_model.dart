class ChatModel {
  String? id;
  String? senderId;
  String? receiverId;
  String? message;
  String? messageType;
  String? chatId;
  String? createdAt;
  String? updatedAt;

  ChatModel(
      {this.id,
        this.senderId,
        this.receiverId,
        this.message,
        this.messageType,
        this.chatId,
        this.createdAt,
        this.updatedAt});

  ChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    message = json['message'];
    messageType = json['messageType'];
    chatId = json['chatId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['senderId'] = this.senderId;
    data['receiverId'] = this.receiverId;
    data['message'] = this.message;
    data['messageType'] = this.messageType;
    data['chatId'] = this.chatId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
