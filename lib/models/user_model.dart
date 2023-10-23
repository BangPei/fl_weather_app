class UserModel {
  String? email;
  String? fullname;
  String? phoneNumber;
  String? password;

  UserModel({this.email, this.fullname, this.phoneNumber, this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    fullname = json['fullname'];
    phoneNumber = json['phoneNumber'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['fullname'] = fullname;
    data['phoneNumber'] = phoneNumber;
    data['password'] = password;
    return data;
  }
}
