// To parse this JSON data, do
//
//     final dashboardHomeModel = dashboardHomeModelFromJson(jsonString);

// import 'dart:convert';

// DashboardHomeModel dashboardHomeModelFromJson(String str) => DashboardHomeModel.fromJson(json.decode(str));

// String dashboardHomeModelToJson(DashboardHomeModel data) => json.encode(data.toJson());

class DashboardHomeModel {
  final List<Datum>? data;
  final bool? status;
  final String? message;
  final int? pageNumber;
  final int? pageSize;
  final int? totalPages;
  final int? totalRecords;

  DashboardHomeModel({
    this.data,
    this.status,
    this.message,
    this.pageNumber,
    this.pageSize,
    this.totalPages,
    this.totalRecords,
  });

  factory DashboardHomeModel.fromJson(Map<String, dynamic> json) =>
      DashboardHomeModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        status: json["status"],
        message: json["message"],
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        totalPages: json["totalPages"],
        totalRecords: json["totalRecords"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "status": status,
        "message": message,
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "totalPages": totalPages,
        "totalRecords": totalRecords,
      };
}

class Datum {
  final String? employeeId;
  final String? profileImage;
  final String? employeeName;
  final String? employeeCode;
  final String? employeePosition;
  final double? totalUsd;
  final double? totalKhr;
  final double? collectedUsd;
  final double? collectedKhr;

  Datum({
    this.employeeId,
    this.profileImage,
    this.employeeName,
    this.employeeCode,
    this.employeePosition,
    this.totalUsd,
    this.totalKhr,
    this.collectedUsd,
    this.collectedKhr,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        employeeId: json["employeeID"],
        profileImage: json["profileImage"],
        employeeName: json["employeeName"],
        employeeCode: json["employeeCode"],
        employeePosition: json["employeePosition"],
        totalUsd: json["totalUSD"],
        totalKhr: json["totalKHR"],
        collectedUsd: json["collectedUSD"],
        collectedKhr: json["collectedKHR"],
      );

  Map<String, dynamic> toJson() => {
        "employeeID": employeeId,
        "profileImage": profileImage,
        "employeeName": employeeName,
        "employeeCode": employeeCode,
        "employeePosition": employeePosition,
        "totalUSD": totalUsd,
        "totalKHR": totalKhr,
        "collectedUSD": collectedUsd,
        "collectedKHR": collectedKhr,
      };
}
