// To parse this JSON data, do
//
//     final userAuthModel = userAuthModelFromJson(jsonString);

// import 'dart:convert';

// UserAuthModel userAuthModelFromJson(String str) => UserAuthModel.fromJson(json.decode(str));

// String userAuthModelToJson(UserAuthModel data) => json.encode(data.toJson());

class UserAuthModel {
  final bool? status;
  final String? token;
  final Data? data;

  UserAuthModel({
    this.status,
    this.token,
    this.data,
  });

  factory UserAuthModel.fromJson(Map<String, dynamic> json) => UserAuthModel(
        status: json["status"],
        token: json["token"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "token": token,
        "data": data?.toJson(),
      };
}

class Data {
  final User? user;

  Data({
    this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
      };
}

class User {
  final String? objectId;
  final String? userObjectId;
  final String? username;
  final String? password;
  final int? isBlocked;
  final String? userRoleId;
  final String? createdBy;
  final DateTime? createdDate;
  final dynamic modifiedBy;
  final dynamic modifiedDate;
  final DateTime? expiredDate;
  final int? isActive;

  User({
    this.objectId,
    this.userObjectId,
    this.username,
    this.password,
    this.isBlocked,
    this.userRoleId,
    this.createdBy,
    this.createdDate,
    this.modifiedBy,
    this.modifiedDate,
    this.expiredDate,
    this.isActive,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        objectId: json["ObjectID"],
        userObjectId: json["UserObjectID"],
        username: json["Username"],
        password: json["Password"],
        isBlocked: json["IsBlocked"],
        userRoleId: json["UserRoleID"],
        createdBy: json["CreatedBy"],
        createdDate: json["CreatedDate"] == null
            ? null
            : DateTime.parse(json["CreatedDate"]),
        modifiedBy: json["ModifiedBy"],
        modifiedDate: json["ModifiedDate"],
        expiredDate: json["ExpiredDate"] == null
            ? null
            : DateTime.parse(json["ExpiredDate"]),
        isActive: json["IsActive"],
      );

  Map<String, dynamic> toJson() => {
        "ObjectID": objectId,
        "UserObjectID": userObjectId,
        "Username": username,
        "Password": password,
        "IsBlocked": isBlocked,
        "UserRoleID": userRoleId,
        "CreatedBy": createdBy,
        "CreatedDate": createdDate?.toIso8601String(),
        "ModifiedBy": modifiedBy,
        "ModifiedDate": modifiedDate,
        "ExpiredDate": expiredDate?.toIso8601String(),
        "IsActive": isActive,
      };
}
