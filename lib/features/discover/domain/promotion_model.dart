// To parse this JSON data, do
//
//     final promotionModel = promotionModelFromJson(jsonString);

import 'dart:convert';

PromotionModel promotionModelFromJson(String str) =>
    PromotionModel.fromJson(json.decode(str));

String promotionModelToJson(PromotionModel data) => json.encode(data.toJson());

class PromotionModel {
  Data data;

  PromotionModel({
    required this.data,
  });

  factory PromotionModel.fromJson(Map<String, dynamic> json) => PromotionModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  String id;
  String status;
  String title;
  String descriptionn;
  String imageLink;
  String popUpTitle;
  String popUpDescription;
  String image;

  Data({
    required this.id,
    required this.status,
    required this.title,
    required this.descriptionn,
    required this.imageLink,
    required this.popUpTitle,
    required this.popUpDescription,
    required this.image,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        status: json["status"],
        title: json["title"],
        descriptionn: json["descriptionn"],
        imageLink: json["image_link"],
        popUpTitle: json["pop_up_title"],
        popUpDescription: json["pop_up_description"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "title": title,
        "descriptionn": descriptionn,
        "image_link": imageLink,
        "pop_up_title": popUpTitle,
        "pop_up_description": popUpDescription,
        "image": image,
      };
}
