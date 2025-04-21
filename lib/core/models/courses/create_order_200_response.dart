// To parse this JSON data, do
//
//     final createOrder200Response = createOrder200ResponseFromJson(jsonString);

import 'dart:convert';

CreateOrder200Response createOrder200ResponseFromJson(String str) =>
    CreateOrder200Response.fromJson(json.decode(str));

String createOrder200ResponseToJson(CreateOrder200Response data) =>
    json.encode(data.toJson());

class CreateOrder200Response {
  String code;
  String msg;
  Data data;

  CreateOrder200Response({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory CreateOrder200Response.fromJson(Map<String, dynamic> json) =>
      CreateOrder200Response(
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
  String id;
  String userId;
  String productId;
  String productName;
  String productType;
  int price;
  String status;
  String affliateCode;
  String referenceNo;
  String merchantUrl;
  String merchantId;
  DateTime updatedAt;
  DateTime createdAt;

  Data({
    required this.id,
    required this.userId,
    required this.productId,
    required this.productName,
    required this.productType,
    required this.price,
    required this.status,
    required this.affliateCode,
    required this.referenceNo,
    required this.merchantUrl,
    required this.merchantId,
    required this.updatedAt,
    required this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        productId: json["product_id"],
        productName: json["product_name"],
        productType: json["product_type"],
        price: json["price"],
        status: json["status"],
        affliateCode: json["affliate_code"],
        referenceNo: json["reference_no"],
        merchantUrl: json["merchant_url"],
        merchantId: json["merchant_id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_id": productId,
        "product_name": productName,
        "product_type": productType,
        "price": price,
        "status": status,
        "affliate_code": affliateCode,
        "reference_no": referenceNo,
        "merchant_url": merchantUrl,
        "merchant_id": merchantId,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
      };
}
