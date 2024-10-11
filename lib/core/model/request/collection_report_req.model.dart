// To parse this JSON data, do
//
//     final collectionReportReqModel = collectionReportReqModelFromJson(jsonString);

// import 'dart:convert';

// CollectionReportReqModel collectionReportReqModelFromJson(String str) => CollectionReportReqModel.fromJson(json.decode(str));

// String collectionReportReqModelToJson(CollectionReportReqModel data) => json.encode(data.toJson());

import 'dart:convert';

import 'package:noteapp/core/model/request/loan_schedule_req.model.dart';

class CollectionReportReqModel {
  final String? requestId;
  final int? pageNumber;
  final int? pageSize;
  final Filter? filter;

  CollectionReportReqModel({
    this.requestId,
    this.pageNumber,
    this.pageSize,
    this.filter,
  });

  factory CollectionReportReqModel.fromJson(Map<String, dynamic> json) =>
      CollectionReportReqModel(
        requestId: json["requestID"],
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        filter: json["filter"] == null ? null : Filter.fromJson(json["filter"]),
      );

  Map<String, dynamic> toJson() {
    var body = {
      "requestID": requestId,
      "pageNumber": pageNumber,
      "pageSize": pageSize,
      "filter": filter?.toJson(),
    };
    var a = jsonEncode(body);
    return body;
  }
}

// class Filter {
//   String? loanAccount;
//   String? clientName;
//   String? branchId;
//   String? villageId;
//   String? companyId;
//   String? employeeId;

//   Filter(
//       {this.loanAccount,
//       this.clientName,
//       this.branchId,
//       this.villageId,
//       this.companyId,
//       this.employeeId});

//   factory Filter.fromJson(Map<String, dynamic> json) => Filter(
//       loanAccount: json["loanAccount"],
//       clientName: json["clientName"],
//       branchId: json["branchID"],
//       villageId: json["villageID"],
//       companyId: json["companyID"],
//       employeeId: json["employeeID"]);

//   Map<String, dynamic> toJson() => {
//         "loanAccount": loanAccount,
//         "clientName": clientName,
//         "branchID": branchId,
//         "villageID": villageId,
//         "companyID": companyId,
//         "employeeID": employeeId,
//       };
// }


