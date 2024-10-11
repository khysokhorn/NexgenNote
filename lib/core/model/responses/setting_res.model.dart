// To parse this JSON data, do
//
//     final settingModel = settingModelFromJson(jsonString);

// import 'dart:convert';

// SettingModel settingModelFromJson(String str) => SettingModel.fromJson(json.decode(str));

// String settingModelToJson(SettingModel data) => json.encode(data.toJson());

class SettingModel {
  final Data? data;
  final bool? status;
  final String? message;
  final int? pageNumber;
  final int? pageSize;
  final int? totalPages;
  final int? totalRecords;

  SettingModel({
    this.data,
    this.status,
    this.message,
    this.pageNumber,
    this.pageSize,
    this.totalPages,
    this.totalRecords,
  });

  factory SettingModel.fromJson(Map<String, dynamic> json) => SettingModel(
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
  final List<ListBranch>? listBranch;
  final List<ListDao>? listDao;
  final List<ListVillage>? listVillage;
  final List<ListCommune>? listCommune;

  Data({
    this.listBranch,
    this.listDao,
    this.listVillage,
    this.listCommune,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        listBranch: json["listBranch"] == null
            ? []
            : List<ListBranch>.from(
                json["listBranch"]!.map((x) => ListBranch.fromJson(x))),
        listDao: json["listDao"] == null
            ? []
            : List<ListDao>.from(
                json["listDao"]!.map((x) => ListDao.fromJson(x))),
        listVillage: json["listVillage"] == null
            ? []
            : List<ListVillage>.from(
                json["listVillage"]!.map((x) => ListVillage.fromJson(x))),
        listCommune: json["listCommune"] == null
            ? []
            : List<ListCommune>.from(
                json["listCommune"]!.map((x) => ListCommune.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "listBranch": listBranch == null
            ? []
            : List<dynamic>.from(listBranch!.map((x) => x.toJson())),
        "listDao": listDao == null
            ? []
            : List<dynamic>.from(listDao!.map((x) => x.toJson())),
        "listVillage": listVillage == null
            ? []
            : List<dynamic>.from(listVillage!.map((x) => x.toJson())),
        "listCommune": listCommune == null
            ? []
            : List<dynamic>.from(listCommune!.map((x) => x.toJson())),
      };
}

class ListBranch {
  final String? objectId;
  final String? branchName;

  ListBranch({
    this.objectId,
    this.branchName,
  });

  factory ListBranch.fromJson(Map<String, dynamic> json) => ListBranch(
        objectId: json["objectID"],
        branchName: json["branchName"],
      );

  Map<String, dynamic> toJson() => {
        "objectID": objectId,
        "branchName": branchName,
      };
}

class ListCommune {
  final String? objectId;
  final String? communeName;

  ListCommune({
    this.objectId,
    this.communeName,
  });

  factory ListCommune.fromJson(Map<String, dynamic> json) => ListCommune(
        objectId: json["objectID"],
        communeName: json["communeName"],
      );

  Map<String, dynamic> toJson() => {
        "objectID": objectId,
        "communeName": communeName,
      };
}

class ListDao {
  final String? objectId;
  final String? employeeName;

  ListDao({
    this.objectId,
    this.employeeName,
  });

  factory ListDao.fromJson(Map<String, dynamic> json) => ListDao(
        objectId: json["objectID"],
        employeeName: json["employeeName"],
      );

  Map<String, dynamic> toJson() => {
        "objectID": objectId,
        "employeeName": employeeName,
      };
}

class ListVillage {
  final String? objectId;
  final String? villageName;

  ListVillage({
    this.objectId,
    this.villageName,
  });

  factory ListVillage.fromJson(Map<String, dynamic> json) => ListVillage(
        objectId: json["objectID"],
        villageName: json["villageName"],
      );

  Map<String, dynamic> toJson() => {
        "objectID": objectId,
        "villageName": villageName,
      };
}
