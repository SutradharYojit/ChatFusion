class UsersModel {
  String? id;
  String? userName;
  String? email;
  String? profileUrl;
  String? bio;
  String? createdAt;
  String? updatedAt;

  UsersModel(
      {this.id,
        this.userName,
        this.email,
        this.profileUrl,
        this.bio,
        this.createdAt,
        this.updatedAt});

  UsersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    email = json['email'];
    profileUrl = json['profileUrl']??"";
    bio = json['bio']??"";
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['profileUrl'] = this.profileUrl;
    data['bio'] = this.bio;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
