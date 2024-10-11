class LoginResponse {
  bool status;
  String token;
  Data data;

  LoginResponse({
    required this.status,
    required this.token,
    required this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"],
        token: json["token"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "token": token,
        "data": data.toJson(),
      };
}

class Data {
  String objectId;
  String userObjectId;
  String username;
  String password;
  int isBlocked;
  String userRoleId;
  String userRole;
  String createdBy;
  DateTime createdDate;
  dynamic modifiedBy;
  dynamic modifiedDate;
  String? expiredDate;
  int isActive;

  Data({
    required this.objectId,
    required this.userObjectId,
    required this.username,
    required this.password,
    required this.isBlocked,
    required this.userRoleId,
    required this.userRole,
    required this.createdBy,
    required this.createdDate,
    required this.modifiedBy,
    required this.modifiedDate,
    required this.expiredDate,
    required this.isActive,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        objectId: json["objectID"],
        userObjectId: json["userObjectID"],
        username: json["username"],
        password: json["password"],
        isBlocked: json["isBlocked"],
        userRoleId: json["userRoleID"],
        userRole: json["userRole"],
        createdBy: json["createdBy"],
        createdDate: DateTime.parse(json["createdDate"]),
        modifiedBy: json["modifiedBy"],
        modifiedDate: json["modifiedDate"],
        expiredDate: json["expiredDate"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "objectID": objectId,
        "userObjectID": userObjectId,
        "username": username,
        "password": password,
        "isBlocked": isBlocked,
        "userRoleID": userRoleId,
        "userRole": userRole,
        "createdBy": createdBy,
        "createdDate": createdDate.toIso8601String(),
        "modifiedBy": modifiedBy,
        "modifiedDate": modifiedDate,
        "expiredDate": expiredDate,
        "isActive": isActive,
      };
}
