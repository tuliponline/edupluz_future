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
  List<DataItem> items;
  Meta meta;

  Data({
    required this.items,
    required this.meta,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        items:
            List<DataItem>.from(json["items"].map((x) => DataItem.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class DataItem {
  String id;
  String number;
  List<ItemItem> items;
  Price price;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  DataItem({
    required this.id,
    required this.number,
    required this.items,
    required this.price,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DataItem.fromJson(Map<String, dynamic> json) => DataItem(
        id: json["id"],
        number: json["number"],
        items:
            List<ItemItem>.from(json["items"].map((x) => ItemItem.fromJson(x))),
        price: Price.fromJson(json["price"]),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "price": price.toJson(),
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class ItemItem {
  String id;
  String name;
  int qty;
  int price;

  ItemItem({
    required this.id,
    required this.name,
    required this.qty,
    required this.price,
  });

  factory ItemItem.fromJson(Map<String, dynamic> json) => ItemItem(
        id: json["id"],
        name: json["name"],
        qty: json["qty"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "qty": qty,
        "price": price,
      };
}

class Price {
  int discountPrice;
  int totalPrice;

  Price({
    required this.discountPrice,
    required this.totalPrice,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        discountPrice: json["discount_price"],
        totalPrice: json["total_price"],
      );

  Map<String, dynamic> toJson() => {
        "discount_price": discountPrice,
        "total_price": totalPrice,
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
