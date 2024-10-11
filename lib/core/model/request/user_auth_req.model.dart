// To parse this JSON data, do
//
//     final userAuthReqModel = userAuthReqModelFromJson(jsonString);

// import 'dart:convert';

// UserAuthReqModel userAuthReqModelFromJson(String str) => UserAuthReqModel.fromJson(json.decode(str));

// String userAuthReqModelToJson(UserAuthReqModel data) => json.encode(data.toJson());

class UserAuthReqModel {
  final String? userName;
  final String? password;

  UserAuthReqModel({
    this.userName,
    this.password,
  });

  factory UserAuthReqModel.fromJson(Map<String, dynamic> json) =>
      UserAuthReqModel(
        userName: json["userName"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "password": password,
      };
}
