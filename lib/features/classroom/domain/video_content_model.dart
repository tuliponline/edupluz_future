// To parse this JSON data, do
//
//     final videoContentModel = videoContentModelFromJson(jsonString);

import 'dart:convert';

VideoContentModel videoContentModelFromJson(String str) =>
    VideoContentModel.fromJson(json.decode(str));

String videoContentModelToJson(VideoContentModel data) =>
    json.encode(data.toJson());

class VideoContentModel {
  String id;
  String name;
  bool free;
  int sequence;
  String url;
  String license;

  VideoContentModel({
    required this.id,
    required this.name,
    required this.free,
    required this.sequence,
    required this.url,
    required this.license,
  });

  factory VideoContentModel.fromJson(Map<String, dynamic> json) =>
      VideoContentModel(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        free: json["free"] ?? false,
        sequence: json["sequence"] ?? 0,
        url: json["url"],
        license: json["license"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "free": free,
        "sequence": sequence,
        "url": url,
        "license": license,
      };
}
