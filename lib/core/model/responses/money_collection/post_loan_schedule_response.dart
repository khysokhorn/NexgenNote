// To parse this JSON data, do
//

import 'dart:convert';

import '../../request/post_loan_collection.dart';

PostLoanScheduleResponse postLoanScheduleResponseFromJson(String str) => PostLoanScheduleResponse.fromJson(json.decode(str));

String postLoanScheduleResponseToJson(PostLoanScheduleResponse data) => json.encode(data.toJson());

class PostLoanScheduleResponse {
  PostLoanCollection data;
  bool status;
  String message;
  int pageNumber;
  int pageSize;
  int totalPages;
  int totalRecords;

  PostLoanScheduleResponse({
    required this.data,
    required this.status,
    required this.message,
    required this.pageNumber,
    required this.pageSize,
    required this.totalPages,
    required this.totalRecords,
  });

  factory PostLoanScheduleResponse.fromJson(Map<String, dynamic> json) => PostLoanScheduleResponse(
        data: PostLoanCollection.fromJson(json["data"]),
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
