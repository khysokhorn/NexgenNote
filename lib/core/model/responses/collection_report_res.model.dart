// To parse this JSON data, do
//
//     final collectionReportModel = collectionReportModelFromJson(jsonString);

// import 'dart:convert';

// CollectionReportModel collectionReportModelFromJson(String str) => CollectionReportModel.fromJson(json.decode(str));

// String collectionReportModelToJson(CollectionReportModel data) => json.encode(data.toJson());

class CollectionReportModel {
  final List<Datum>? data;
  final bool? status;
  final String? message;
  final int? pageNumber;
  final int? pageSize;
  final int? totalPages;
  final int? totalRecords;

  CollectionReportModel({
    this.data,
    this.status,
    this.message,
    this.pageNumber,
    this.pageSize,
    this.totalPages,
    this.totalRecords,
  });

  factory CollectionReportModel.fromJson(Map<String, dynamic> json) =>
      CollectionReportModel(
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
  final String? clientNameLatin;
  final String? clientNameKh;
  final String? clientPhone;
  final String? loanCurrency;
  final double? outstandingBalance;
  final double? principleAmt;
  final double? interestAmt;
  final double? operationFeeAmount;
  final double? totalPay;
  final String? instalmentPay;
  final DateTime? repyamentDate;
  final String? repaymentFreq;
  final String? villageName;
  final String? communeName;
  final String? employeeId;
  final String? employeeName;
  final double? receiveCashKhr;
  final double? receiveCashUsd;
  final double? totalPaid;
  final String? note;
  final String? branchId;
  final String? companyId;
  final String? createdBy;
  final DateTime? createdDate;
  final String? status;
  final String? coreStatus;
  final String? branchName;
  final double? sumTotalReceiveCashKHR;
  final double? sumTotalReceiveCashUSD;
  // final double? sumTotalPaid;

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
    this.receiveCashKhr,
    this.receiveCashUsd,
    this.note,
    this.branchId,
    this.companyId,
    this.createdBy,
    this.createdDate,
    this.status,
    this.coreStatus,
    this.branchName,
    this.totalPaid,
    this.sumTotalReceiveCashKHR,
    this.sumTotalReceiveCashUSD,
    // this.sumTotalPaid,
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
        repyamentDate: json["repyamentDate"] == null
            ? null
            : DateTime.parse(json["repyamentDate"]),
        repaymentFreq: json["repaymentFreq"],
        villageName: json["villageName"],
        communeName: json["communeName"],
        employeeId: json["employeeID"],
        employeeName: json["employeeName"],
        receiveCashKhr: json["receiveCashKHR"],
        receiveCashUsd: json["receiveCashUSD"],
        totalPaid: json["totalPaid"],
        note: json["note"],
        branchId: json["branchID"],
        companyId: json["companyID"],
        createdBy: json["createdBy"],
        createdDate: json["createdDate"] == null
            ? null
            : DateTime.parse(json["createdDate"]),
        status: json["status"],
        coreStatus: json["coreStatus"],
        branchName: json["branchName"],
        sumTotalReceiveCashKHR: json["sumTotalReceiveCashKHR"],
        sumTotalReceiveCashUSD: json["sumTotalReceiveCashUSD"],
        // sumTotalPaid: json["sumTotalPaid"],
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
        "repyamentDate": repyamentDate?.toIso8601String(),
        "repaymentFreq": repaymentFreq,
        "villageName": villageName,
        "communeName": communeName,
        "employeeID": employeeId,
        "employeeName": employeeName,
        "receiveCashKHR": receiveCashKhr,
        "receiveCashUSD": receiveCashUsd,
        "totalPaid": totalPaid,
        "note": note,
        "branchID": branchId,
        "companyID": companyId,
        "createdBy": createdBy,
        "createdDate": createdDate?.toIso8601String(),
        "coreStatus": coreStatus,
        "status": status,
        "branchName": branchName,
        "sumTotalReceiveCashKHR": sumTotalReceiveCashKHR,
        "sumTotalReceiveCashUSD": sumTotalReceiveCashUSD,
        // "sumTotalPaid": sumTotalPaid
      };
}
