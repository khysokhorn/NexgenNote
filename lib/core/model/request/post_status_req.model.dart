// To parse this JSON data, do
//
//     final postStatusReqModel = postStatusReqModelFromJson(jsonString);

// import 'dart:convert';

// PostStatusReqModel postStatusReqModelFromJson(String str) => PostStatusReqModel.fromJson(json.decode(str));

// String postStatusReqModelToJson(PostStatusReqModel data) => json.encode(data.toJson());

class PostStatusReqModel {
  final String? objectId;
  final String? loanAccount;
  final String? clientNameLatin;
  final String? clientNameKh;
  final String? clientPhone;
  final String? loanCurrency;
  final int? outstandingBalance;
  final double? principleAmt;
  final double? interestAmt;
  final double? operationFeeAmount;
  final double? totalPay;
  final int? instalmentPay;
  final DateTime? repyamentDate;
  final String? villageName;
  final String? communeName;
  final String? employeeId;
  final String? employeeName;
  final int? receiveCashKhr;
  final int? receiveCashUsd;
  final int? totalPaid;
  final String? note;
  final String? branchId;
  final String? companyId;
  final String? createdBy;
  final DateTime? createdDate;
  final dynamic modifiedBy;
  final dynamic modifiedDate;
  final String? status;
  final String? coreStatus;
  final String? branchName;

  PostStatusReqModel({
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
    this.villageName,
    this.communeName,
    this.employeeId,
    this.employeeName,
    this.receiveCashKhr,
    this.receiveCashUsd,
    this.totalPaid,
    this.note,
    this.branchId,
    this.companyId,
    this.createdBy,
    this.createdDate,
    this.modifiedBy,
    this.modifiedDate,
    this.status,
    this.coreStatus,
    this.branchName,
  });

  factory PostStatusReqModel.fromJson(Map<String, dynamic> json) =>
      PostStatusReqModel(
        objectId: json["objectID"],
        loanAccount: json["loanAccount"],
        clientNameLatin: json["clientNameLatin"],
        clientNameKh: json["clientNameKH"],
        clientPhone: json["clientPhone"],
        loanCurrency: json["loanCurrency"],
        outstandingBalance: json["outstandingBalance"],
        principleAmt: json["principleAmt"]?.toDouble(),
        interestAmt: json["interestAmt"]?.toDouble(),
        operationFeeAmount: json["operationFeeAmount"]?.toDouble(),
        totalPay: json["totalPay"]?.toDouble(),
        instalmentPay: json["instalmentPay"],
        repyamentDate: json["repyamentDate"] == null
            ? null
            : DateTime.parse(json["repyamentDate"]),
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
        modifiedBy: json["modifiedBy"],
        modifiedDate: json["modifiedDate"],
        status: json["status"],
        coreStatus: json["coreStatus"],
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
        "repyamentDate": repyamentDate?.toIso8601String(),
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
        "modifiedBy": modifiedBy,
        "modifiedDate": modifiedDate,
        "status": status,
        "coreStatus": coreStatus,
        "branchName": branchName,
      };
}
