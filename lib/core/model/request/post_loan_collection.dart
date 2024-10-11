import 'dart:convert';

import 'package:noteapp/core/model/responses/loan_schedule_res.model.dart'
    as laonList;
import 'package:noteapp/core/model/responses/user_profile_res.model.dart';

PostLoanCollection postLoanCollectionModelFromJson(String str) =>
    PostLoanCollection.fromJson(json.decode(str));

String postLoanCollectionModelToJson(PostLoanCollection data) =>
    json.encode(data.toJson());

PostLoanCollectionLocalLists postLoanCollectionModelLocalFromJson(String str) =>
    PostLoanCollectionLocalLists.fromJson(json.decode(str));

String postLoanCollectionModelLocalToJson(PostLoanCollectionLocalLists data) =>
    json.encode(data.toJson());

class PostLoanCollectionLocalLists {
  List<PostLoanCollection>? data;
  PostLoanCollectionLocalLists({this.data});
  factory PostLoanCollectionLocalLists.fromJson(Map<String, dynamic> json) =>
      PostLoanCollectionLocalLists(
        data: json["data"] == null
            ? []
            : List<PostLoanCollection>.from(
                json["data"]!.map((x) => PostLoanCollection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson()))
      };
}

class PostLoanCollection {
  String? key;
  String? loanAccount;
  String? clientNameLatin;
  String? clientNameKh;
  String? clientPhone;
  String? loanCurrency;
  double? outstandingBalance;
  double? principleAmt;
  double? interestAmt;
  double? operationFeeAmount;
  double? totalPay;
  String? instalmentPay;
  String? repyamentDate;
  String? villageName;
  String? communeName;
  String? employeeId;
  String? employeeName;
  double? receiveCashKhr;
  double? receiveCashUsd;
  double? totalPaid;
  String? note;
  String? branchId;
  String? companyId;
  Map<String, dynamic>? requestDataJson;

  PostLoanCollection(
      {this.loanAccount,
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
      this.note,
      this.branchId,
      this.companyId,
      this.requestDataJson,
      this.totalPaid});

  factory PostLoanCollection.fromJson(Map<String, dynamic> json) =>
      PostLoanCollection(
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
        villageName: json["villageName"],
        communeName: json["communeName"],
        employeeId: json["employeeID"],
        employeeName: json["employeeName"],
        receiveCashKhr:
            double.tryParse(json["receiveCashKHR"].toString()) ?? 0.0,
        receiveCashUsd:
            double.tryParse(json["receiveCashUSD"].toString()) ?? 0.0,
        note: json["note"],
        branchId: json["branchID"],
        companyId: json["companyID"],
        totalPaid: json["totalPaid"],
        requestDataJson: json["requestDataJson"],
      );

  Map<String, dynamic> toJson() {
    var a = {
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
      "villageName": villageName,
      "communeName": communeName,
      "employeeID": employeeId,
      "employeeName": employeeName,
      "receiveCashKHR": receiveCashKhr ?? 0.0,
      "receiveCashUSD": receiveCashUsd ?? 0.0,
      "totalPaid": totalPaid ?? 0.0,
      "note": note,
      "branchID": branchId,
      "companyID": companyId,
      "key": key,
      "requestDataJson": requestDataJson,
    };
    // var json = jsonEncode(a);
    // print("Body ${jsonEncode(a)}");
    return a;
  }

  PostLoanCollection converter(
    laonList.Datum? data,
    UserProfileModel? userProfileModel,
    double? receiveCashKhr,
    double? receiveCashUSD,
    double? totalPaid,
    String? note,
  ) {
    requestDataJson = data?.toJson();
    var userProfile = userProfileModel?.data;
    loanAccount = data?.loanAccount;
    clientNameLatin = data?.clientNameLatin;
    clientNameKh = data?.clientNameKh;
    clientPhone = data?.clientPhone;
    loanCurrency = data?.loanCurrency;
    outstandingBalance = data?.outstandingBalance;
    principleAmt = data?.principleAmt;
    interestAmt = data?.interestAmt;
    operationFeeAmount = data?.operationFeeAmount;
    totalPay = data?.totalPay;
    instalmentPay = data?.instalmentPay;
    repyamentDate = data?.repyamentDate;
    villageName = data?.villageName;
    communeName = data?.communeName;
    employeeId = userProfile?.objectId;
    employeeName = userProfile?.fullname;
    this.receiveCashKhr = receiveCashKhr;
    receiveCashUsd = receiveCashUSD;
    this.totalPaid = totalPaid;
    this.note = note;
    branchId = userProfile?.branchId;
    companyId = userProfile?.companyId;
    return this;
  }
}
