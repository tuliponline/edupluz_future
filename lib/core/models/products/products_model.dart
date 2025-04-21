// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'dart:convert';

ProductsModel productsModelFromJson(String str) =>
    ProductsModel.fromJson(json.decode(str));

String productsModelToJson(ProductsModel data) => json.encode(data.toJson());

class ProductsModel {
  String code;
  String msg;
  Data data;

  ProductsModel({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
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
  String itemId;
  ItemType itemType;
  String name;
  String slug;
  int duration;
  String description;
  Status thumbnail;
  String sku;
  int price;
  Status status;
  bool isFree;
  dynamic bundles;
  String workspaceId;
  DateTime createdAt;
  DateTime updatedAt;

  Item({
    required this.id,
    required this.itemId,
    required this.itemType,
    required this.name,
    required this.slug,
    required this.duration,
    required this.description,
    required this.thumbnail,
    required this.sku,
    required this.price,
    required this.status,
    required this.isFree,
    required this.bundles,
    required this.workspaceId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        itemId: json["item_id"],
        itemType: itemTypeValues.map[json["item_type"]]!,
        name: json["name"],
        slug: json["slug"],
        duration: json["duration"],
        description: json["description"],
        thumbnail: statusValues.map[json["thumbnail"]]!,
        sku: json["sku"],
        price: json["price"],
        status: statusValues.map[json["status"]]!,
        isFree: json["is_free"],
        bundles: json["bundles"],
        workspaceId: json["workspace_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_id": itemId,
        "item_type": itemTypeValues.reverse[itemType],
        "name": name,
        "slug": slug,
        "duration": duration,
        "description": description,
        "thumbnail": statusValues.reverse[thumbnail],
        "sku": sku,
        "price": price,
        "status": statusValues.reverse[status],
        "is_free": isFree,
        "bundles": bundles,
        "workspace_id": workspaceId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

enum ItemType { BUFFET, COURSE, PLAN, BUNDLE }

final itemTypeValues = EnumValues({
  "BUFFET": ItemType.BUFFET,
  "COURSE": ItemType.COURSE,
  "PLAN": ItemType.PLAN,
  "BUNDLE": ItemType.BUNDLE
});

enum Status { ACTIVE, INACTIVE, EMPTY }

final statusValues = EnumValues(
    {"ACTIVE": Status.ACTIVE, "INACTIVE": Status.INACTIVE, "": Status.EMPTY});

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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
