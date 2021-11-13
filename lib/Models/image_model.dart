// To parse this JSON data, do
//
//     final imageModel = imageModelFromJson(jsonString);

import 'dart:convert';

ImageModel imageModelFromJson(String str) => ImageModel.fromJson(json.decode(str));

String imageModelToJson(ImageModel data) => json.encode(data.toJson());

class ImageModel {
  ImageModel({
    required this.copyright,
    required this.date,
    required this.explanation,
    required this.hdurl,
    required this.mediaType,
    required this.serviceVersion,
    required this.title,
    required this.url,
  });

  String copyright = " ";
  DateTime date = DateTime.now();
  String explanation = " ";
  String hdurl = " ";
  String mediaType = " ";
  String serviceVersion = " ";
  String title = " ";
  String url = " ";

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
    copyright: json["copyright"]!=null?json["copyright"]:" ",
    date: DateTime.parse(json["date"]),
    explanation: json["explanation"]!=null?json["explanation"]:" ",
    hdurl: json["hdurl"]!=null?json["hdurl"]:" ",
    mediaType: json["media_type"]!=null?json["media_type"]:" ",
    serviceVersion: json["service_version"]!=null?json["service_version"]:" ",
    title: json["title"]!=null?json["title"]: " ",
    url: json["url"]!=null?json["url"]:" ",
  );

  Map<String, dynamic> toJson() => {
    "copyright": copyright,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "explanation": explanation,
    "hdurl": hdurl,
    "media_type": mediaType,
    "service_version": serviceVersion,
    "title": title,
    "url": url,
  };
}
