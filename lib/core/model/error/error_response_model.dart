// To parse this JSON data, do
//
//     final errorResponseModel = errorResponseModelFromJson(jsonString);

import 'dart:convert';

ErrorResponseModel errorResponseModelFromJson(String str) => ErrorResponseModel.fromJson(json.decode(str));

String errorResponseModelToJson(ErrorResponseModel data) => json.encode(data.toJson());

class ErrorResponseModel {
    String type;
    String title;
    int status;
    String traceId;
    Errors errors;

    ErrorResponseModel({
        required this.type,
        required this.title,
        required this.status,
        required this.traceId,
        required this.errors,
    });

    factory ErrorResponseModel.fromJson(Map<String, dynamic> json) => ErrorResponseModel(
        type: json["type"],
        title: json["title"],
        status: json["status"],
        traceId: json["traceId"],
        errors: Errors.fromJson(json["errors"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
        "status": status,
        "traceId": traceId,
        "errors": errors.toJson(),
    };
}

class Errors {
    List<String> empty;
    List<String> userLogin;

    Errors({
        required this.empty,
        required this.userLogin,
    });

    factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        empty: List<String>.from(json[""].map((x) => x)),
        userLogin: List<String>.from(json["userLogin"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "": List<dynamic>.from(empty.map((x) => x)),
        "userLogin": List<dynamic>.from(userLogin.map((x) => x)),
    };
}
