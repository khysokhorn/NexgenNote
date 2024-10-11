import 'package:noteapp/core/global_function.dart';
import 'package:noteapp/core/services/global_service.dart';

class LoanScheduleReqModel {
  final String? requestId;
  final int? pageNumber;
  final int? pageSize;
  final Filter? filter;

  LoanScheduleReqModel({
    this.requestId,
    this.pageNumber,
    this.pageSize,
    this.filter,
  });

  factory LoanScheduleReqModel.fromJson(Map<String, dynamic> json) =>
      LoanScheduleReqModel(
        requestId: json["requestID"],
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        filter: json["filter"] == null ? null : Filter.fromJson(json["filter"]),
      );

  Map<String, dynamic> toJson() => {
        "requestID": requestId,
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "filter": filter?.toJson(),
      };
}

class Filter {
  String? loanAccount;
  String? clientName;
  String? branchId;
  String? villageId;
  String? companyId;
  String? employeeId;
  String? status;
  String? fromDate;
  String? toDate;

  Filter({
    this.loanAccount,
    this.clientName,
    this.branchId,
    this.villageId,
    this.companyId,
    this.employeeId,
    this.status,
    this.fromDate,
    this.toDate,
  });

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
        loanAccount: json["loanAccount"],
        clientName: json["clientName"],
        villageId: json["villageID"],
        branchId: json["branchID"],
        companyId: json["companyID"],
        employeeId: json["employeeID"],
        status: json["status"],
        fromDate: json["fromDate"],
        toDate: json["toDate"],
      );

  Map<String, dynamic> toJson() => {
        "loanAccount": loanAccount,
        "clientName": clientName,
        "branchID": branchId,
        "villageID": villageId,
        "companyID": companyId,
        "employeeID": employeeId,
        "status": status,
        "fromDate": fromDate,
        "toDate": toDate,
      };
}
