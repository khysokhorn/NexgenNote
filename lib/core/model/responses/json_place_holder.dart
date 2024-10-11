import 'dart:convert';

List<JsonPlaceHolderModel> jsonPlaceHolderModelFromJson(String str) => List<JsonPlaceHolderModel>.from(json.decode(str).map((x) => JsonPlaceHolderModel.fromJson(x)));

String jsonPlaceHolderModelToJson(List<JsonPlaceHolderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JsonPlaceHolderModel {
    int? userId;
    int? id;
    String? title;
    String? body;

    JsonPlaceHolderModel({
        this.userId,
        this.id,
        this.title,
        this.body,
    });

    factory JsonPlaceHolderModel.fromJson(Map<String, dynamic> json) => JsonPlaceHolderModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
    };
}
