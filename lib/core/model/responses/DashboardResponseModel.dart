// To parse this JSON data, do
//
//     final dashboardResponseModel = dashboardResponseModelFromJson(jsonString);

import 'dart:convert';

DashboardResponseOCRModel dashboardResponseModelFromJson(String str) =>
    DashboardResponseOCRModel.fromJson(json.decode(str));

String dashboardResponseModelToJson(DashboardResponseOCRModel data) =>
    json.encode(data.toJson());

class DashboardResponseOCRModel {
  Data data;
  bool status;
  String message;
  int pageNumber;
  int pageSize;
  int totalPages;
  int totalRecords;

  DashboardResponseOCRModel({
    required this.data,
    required this.status,
    required this.message,
    required this.pageNumber,
    required this.pageSize,
    required this.totalPages,
    required this.totalRecords,
  });

  factory DashboardResponseOCRModel.fromJson(Map<String, dynamic> json) =>
      DashboardResponseOCRModel(
        data: Data.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        totalPages: json["totalPages"],
        totalRecords: json["totalRecords"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
        "message": message,
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "totalPages": totalPages,
        "totalRecords": totalRecords,
      };
}

class Data {
  dynamic employeeId;
  dynamic profileImage;
  dynamic employeeName;
  dynamic employeePosition;
  double? totalUsd;
  double? totalKhr;
  double? collectedUsd;
  double? collectedKhr;
  String? totalCollectedCount;
  String? totalPendingCollectCount;

  Data({
    required this.employeeId,
    required this.profileImage,
    required this.employeeName,
    required this.employeePosition,
    required this.totalUsd,
    required this.totalKhr,
    required this.collectedUsd,
    required this.collectedKhr,
    required this.totalCollectedCount,
    required this.totalPendingCollectCount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        employeeId: json["employeeID"],
        profileImage: json["profileImage"],
        employeeName: json["employeeName"],
        employeePosition: json["employeePosition"],
        totalUsd: json["totalUSD"],
        totalKhr: json["totalKHR"],
        collectedUsd: json["collectedUSD"]?.toDouble(),
        collectedKhr: json["collectedKHR"]?.toDouble(),
        totalCollectedCount: json["totalCollectedCount"],
        totalPendingCollectCount: json["totalPendingCollectCount"],
      );

  Map<String, dynamic> toJson() => {
        "employeeID": employeeId,
        "profileImage": profileImage,
        "employeeName": employeeName,
        "employeePosition": employeePosition,
        "totalUSD": totalUsd,
        "totalKHR": totalKhr,
        "collectedUSD": collectedUsd,
        "collectedKHR": collectedKhr,
        "totalCollectedCount": totalCollectedCount,
        "totalPendingCollectCount": totalPendingCollectCount,
      };
}
