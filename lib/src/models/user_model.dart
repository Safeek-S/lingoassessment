class UserModel {
  String? userName;
  String? email;
  String? password;

  UserModel({this.email, this.userName, this.password});

  factory UserModel.fromJson(Map<String, String> json) {
    return UserModel(
      userName: json["username"],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, String> toJson() {
    return {
      "username": userName ?? "",
      'email': email ?? "",
      'password': password ?? "",
    };
  }
}
