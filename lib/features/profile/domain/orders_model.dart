// To parse this JSON data, do
//
//     final ordersModel = ordersModelFromJson(jsonString);

import 'dart:convert';

OrdersModel ordersModelFromJson(String str) =>
    OrdersModel.fromJson(json.decode(str));

String ordersModelToJson(OrdersModel data) => json.encode(data.toJson());

class OrdersModel {
  String code;
  String msg;
  Data data;

  OrdersModel({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
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
  String userId;
  String productId;
  String productName;
  int price;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  String referenceNo;
  String id;

  Item({
    required this.userId,
    required this.productId,
    required this.productName,
    required this.price,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.referenceNo,
    required this.id,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        userId: json["user_id"],
        productId: json["product_id"],
        productName: json["product_name"],
        price: json["price"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        referenceNo: json["reference_no"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "product_id": productId,
        "product_name": productName,
        "price": price,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "reference_no": referenceNo,
        "id": id,
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
