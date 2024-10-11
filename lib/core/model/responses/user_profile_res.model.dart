import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) => UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) => json.encode(data.toJson());

class UserProfileModel {
  final Data? data;
  final bool? status;
  final String? message;
  final int? pageNumber;
  final int? pageSize;
  final int? totalPages;
  final int? totalRecords;

  UserProfileModel({
    this.data,
    this.status,
    this.message,
    this.pageNumber,
    this.pageSize,
    this.totalPages,
    this.totalRecords,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        totalPages: json["totalPages"],
        totalRecords: json["totalRecords"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "status": status,
        "message": message,
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "totalPages": totalPages,
        "totalRecords": totalRecords,
      };
}

class Data {
  final String? objectId;
  final String? fullname;
  final String? gender;
  final String? phoneNumber;
  final String? address;
  final String? employeeId;
  final String? branchCode;
  final String? branchId;
  final String? companyId;
  final String? createdBy;
  final DateTime? createdDate;
  final dynamic modifiedBy;
  final dynamic modifiedDate;
  final int? isActive;
  final String? branchName;
  final String? companyName;

  Data({
    this.objectId,
    this.fullname,
    this.gender,
    this.phoneNumber,
    this.address,
    this.employeeId,
    this.branchCode,
    this.branchId,
    this.companyId,
    this.createdBy,
    this.createdDate,
    this.modifiedBy,
    this.modifiedDate,
    this.isActive,
    this.branchName,
    this.companyName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        objectId: json["objectID"],
        fullname: json["fullname"],
        gender: json["gender"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        employeeId: json["employeeID"],
        branchCode: json["branchCode"],
        branchId: json["branchID"],
        companyId: json["companyID"],
        createdBy: json["createdBy"],
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        modifiedBy: json["modifiedBy"],
        modifiedDate: json["modifiedDate"],
        isActive: json["isActive"],
        branchName: json["branchName"],
        companyName: json["companyName"],
      );

  Map<String, dynamic> toJson() => {
        "objectID": objectId,
        "fullname": fullname,
        "gender": gender,
        "phoneNumber": phoneNumber,
        "address": address,
        "employeeID": employeeId,
        "branchCode": branchCode,
        "branchID": branchId,
        "companyID": companyId,
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "modifiedBy": modifiedBy,
        "modifiedDate": modifiedDate,
        "isActive": isActive,
        "branchName": branchName,
        "companyName": companyName,
      };
}
