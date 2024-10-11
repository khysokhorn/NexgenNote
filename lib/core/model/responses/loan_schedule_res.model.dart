// To parse this JSON data, do
//
//     final loanScheduleListModel = loanScheduleListModelFromJson(jsonString);

import 'dart:convert';

import 'package:noteapp/core/model/responses/pagination.model.dart';

LoanScheduleListModel loanScheduleListModelFromJson(String str) =>
    LoanScheduleListModel.fromJson(json.decode(str));

String loanScheduleListModelToJson(LoanScheduleListModel data) =>
    json.encode(data.toJson());

class LoanScheduleListModel {
  List<Datum>? data;
  final bool? status;
  final String? message;
  final int? pageNumber;
  final int? pageSize;
  final int? totalPages;
  final int? totalRecords;

  PaginationModel get pagination =>
      PaginationModel(pageNumber, pageSize, totalPages, totalRecords);

  LoanScheduleListModel({
    this.data,
    this.status,
    this.message,
    this.pageNumber,
    this.pageSize,
    this.totalPages,
    this.totalRecords,
  });

  factory LoanScheduleListModel.fromJson(Map<String, dynamic> json) =>
      LoanScheduleListModel(
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
  final String? objectId;
  final String? loanAccount;
  final dynamic clientNameLatin;
  final String? clientNameKh;
  final dynamic clientPhone;
  final String? loanCurrency;
  final double? outstandingBalance;
  final double? principleAmt;
  final double? interestAmt;
  final double? operationFeeAmount;
  final double? totalPay;
  final dynamic instalmentPay;
  final dynamic repyamentDate;
  final String? repaymentFreq;
  final String? villageName;
  final dynamic communeName;
  final String? employeeId;
  final String? employeeName;
  final String? branchId;
  final String? companyId;
  final String? createdBy;
  final DateTime? createdDate;
  final String? status;
  final String? branchName;
  bool? isCollected = false;

  Datum({
    this.objectId,
    this.loanAccount,
    this.clientNameLatin,
    this.clientNameKh,
    this.clientPhone,
    this.loanCurrency,
    this.outstandingBalance,
    this.principleAmt,
    this.interestAmt,
    this.operationFeeAmount,
    this.totalPay,
    this.instalmentPay,
    this.repyamentDate,
    this.repaymentFreq,
    this.villageName,
    this.communeName,
    this.employeeId,
    this.employeeName,
    this.branchId,
    this.companyId,
    this.createdBy,
    this.createdDate,
    this.status,
    this.branchName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        objectId: json["objectID"],
        loanAccount: json["loanAccount"],
        clientNameLatin: json["clientNameLatin"],
        clientNameKh: json["clientNameKH"],
        clientPhone: json["clientPhone"],
        loanCurrency: json["loanCurrency"],
        outstandingBalance: json["outstandingBalance"],
        principleAmt: json["principleAmt"],
        interestAmt: json["interestAmt"],
        operationFeeAmount: json["operationFeeAmount"],
        totalPay: json["totalPay"],
        instalmentPay: json["instalmentPay"],
        repyamentDate: json["repyamentDate"],
        repaymentFreq: json["repaymentFreq"],
        villageName: json["villageName"],
        communeName: json["communeName"],
        employeeId: json["employeeID"],
        employeeName: json["employeeName"],
        branchId: json["branchID"],
        companyId: json["companyID"],
        createdBy: json["createdBy"],
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        status: json["status"],
        branchName: json["branchName"],
      );

  Map<String, dynamic> toJson() => {
        "objectID": objectId,
        "loanAccount": loanAccount,
        "clientNameLatin": clientNameLatin,
        "clientNameKH": clientNameKh,
        "clientPhone": clientPhone,
        "loanCurrency": loanCurrency,
        "outstandingBalance": outstandingBalance,
        "principleAmt": principleAmt,
        "interestAmt": interestAmt,
        "operationFeeAmount": operationFeeAmount,
        "totalPay": totalPay,
        "instalmentPay": instalmentPay,
        "repyamentDate": repyamentDate,
        "repaymentFreq": repaymentFreq,
        "villageName": villageName,
        "communeName": communeName,
        "employeeID": employeeId,
        "employeeName": employeeName,
        "branchID": branchId,
        "companyID": companyId,
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "status": status,
        "branchName": branchName,
        "isCollected": isCollected,
      };
}
