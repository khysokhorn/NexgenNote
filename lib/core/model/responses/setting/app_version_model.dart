
import 'dart:convert';

AppVersionModel appVersionModelFromJson(String str) =>
    AppVersionModel.fromJson(json.decode(str));

String appVersionModelToJson(AppVersionModel data) =>
    json.encode(data.toJson());

class AppVersionModel {
  AppVersionData? data;
  bool? status;
  String? message;
  int? pageNumber;
  int? pageSize;
  int? totalPages;
  int? totalRecords;

  AppVersionModel({
    required this.data,
    required this.status,
    required this.message,
    required this.pageNumber,
    required this.pageSize,
    required this.totalPages,
    required this.totalRecords,
  });

  factory AppVersionModel.fromJson(Map<String, dynamic> json) =>
      AppVersionModel(
        data: AppVersionData.fromJson(json["data"]),
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

class AppVersionData {
  String objectId;
  String version;
  DateTime releaseDate;
  String remark;
  DateTime createdDate;
  int status;

  AppVersionData({
    required this.objectId,
    required this.version,
    required this.releaseDate,
    required this.remark,
    required this.createdDate,
    required this.status,
  });

  factory AppVersionData.fromJson(Map<String, dynamic> json) => AppVersionData(
        objectId: json["objectID"],
        version: json["version"],
        releaseDate: DateTime.parse(json["releaseDate"]),
        remark: json["remark"],
        createdDate: DateTime.parse(json["createdDate"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "objectID": objectId,
        "version": version,
        "releaseDate": releaseDate.toIso8601String(),
        "remark": remark,
        "createdDate": createdDate.toIso8601String(),
        "status": status,
      };
}
