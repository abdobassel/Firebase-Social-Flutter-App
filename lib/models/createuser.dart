class UserModel {
  String? name;
  String? phone;
  String? uId;
  String? email;
  bool? isEmailVer;
  String? image;
  String? cover;
  String? bio;
  UserModel(
      {this.email,
      this.name,
      this.phone,
      this.uId,
      this.isEmailVer,
      this.cover,
      this.bio,
      this.image});
  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    isEmailVer = json['isEmailVer'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'phone': phone,
      'uId': uId,
      'name': name,
      'isEmailVer': isEmailVer
    };
  }
}
