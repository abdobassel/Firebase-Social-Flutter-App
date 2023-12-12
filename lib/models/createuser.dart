class UserModel {
  String? name;
  String? phone;
  String? uId;
  String? email;
  UserModel({
    this.email,
    this.name,
    this.phone,
    this.uId,
  });
  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
  }

  Map<String, dynamic> toMap() {
    return {'email': email, 'phone': phone, 'uId': uId, 'name': name};
  }
}
