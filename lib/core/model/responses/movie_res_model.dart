// To parse this JSON data, do
//
//     final moviesResModel = moviesResModelFromJson(jsonString);

import 'dart:convert';

MoviesResModel moviesResModelFromJson(String str) =>
    MoviesResModel.fromJson(json.decode(str));

String moviesResModelToJson(MoviesResModel data) => json.encode(data.toJson());

class MoviesResModel {
  MoviesResModel({
    this.data,
    this.success,
  });

  Data? data;
  bool? success;

  factory MoviesResModel.fromJson(Map<String, dynamic> json) => MoviesResModel(
        data: Data.fromJson(json["data"]),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "success": success,
      };
}

class Data {
  Data({
    this.currentPage,
    this.movies,
    this.pages,
    this.type,
  });

  int? currentPage;
  List<Movie>? movies;
  int? pages;
  String? type;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["currentPage"],
        movies: List<Movie>.from(json["movies"].map((x) => Movie.fromJson(x))),
        pages: json["pages"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "currentPage": currentPage,
        "movies": List<dynamic>.from(movies!.map((x) => x.toJson())),
        "pages": pages,
        "type": type,
      };
}

class Movie {
  Movie({
    this.cover,
    this.duration,
    this.imdb,
    this.link,
    this.quality,
    this.title,
    this.type,
    this.year,
  });

  String? cover;
  String? duration;
  String? imdb;
  String? link;
  String? quality;
  String? title;
  String? type;
  String? year;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        cover: json["cover"],
        duration: json["duration"],
        imdb: json["imdb"],
        link: json["link"],
        quality: json["quality"],
        title: json["title"],
        type: json["type"],
        year: json["year"],
      );

  Map<String, dynamic> toJson() => {
        "cover": cover,
        "duration": duration,
        "imdb": imdb,
        "link": link,
        "quality": quality,
        "title": title,
        "type": type,
        "year": year,
      };
}
