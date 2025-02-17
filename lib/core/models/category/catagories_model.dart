// To parse this JSON data, do
//
//     final catagoriesModel = catagoriesModelFromJson(jsonString);

import 'dart:convert';

CatagoriesModel catagoriesModelFromJson(String str) =>
    CatagoriesModel.fromJson(json.decode(str));

String catagoriesModelToJson(CatagoriesModel data) =>
    json.encode(data.toJson());

class CatagoriesModel {
  String code;
  String msg;
  Data data;

  CatagoriesModel({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory CatagoriesModel.fromJson(Map<String, dynamic> json) =>
      CatagoriesModel(
        code: json["code"],
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "msg": msg,
        "data": data.toJson(),
      };
}

class Data {
  List<Item> items;
  Meta meta;

  Data({
    required this.items,
    required this.meta,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class Item {
  String id;
  String name;
  String description;
  List<Item>? subCategories;
  int count;

  Item({
    required this.id,
    required this.name,
    required this.description,
    this.subCategories,
    required this.count,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        subCategories: json["sub_categories"] == null
            ? []
            : List<Item>.from(
                json["sub_categories"]!.map((x) => Item.fromJson(x))),
        count: json["count"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "sub_categories": subCategories == null
            ? []
            : List<dynamic>.from(subCategories!.map((x) => x.toJson())),
        "count": count,
      };
}

class Meta {
  int page;
  int limit;
  int itemCount;
  int totalPages;
  int totalItems;

  Meta({
    required this.page,
    required this.limit,
    required this.itemCount,
    required this.totalPages,
    required this.totalItems,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        page: json["page"],
        limit: json["limit"],
        itemCount: json["item_count"],
        totalPages: json["total_pages"],
        totalItems: json["total_items"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "limit": limit,
        "item_count": itemCount,
        "total_pages": totalPages,
        "total_items": totalItems,
      };
}
