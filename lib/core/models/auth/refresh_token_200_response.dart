// To parse this JSON data, do
//
//     final refreshToken200Response = refreshToken200ResponseFromJson(jsonString);

import 'dart:convert';

RefreshToken200Response refreshToken200ResponseFromJson(String str) =>
    RefreshToken200Response.fromJson(json.decode(str));

String refreshToken200ResponseToJson(RefreshToken200Response data) =>
    json.encode(data.toJson());

class RefreshToken200Response {
  String code;
  String msg;
  Data data;

  RefreshToken200Response({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory RefreshToken200Response.fromJson(Map<String, dynamic> json) =>
      RefreshToken200Response(
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
  String accessToken;
  String refreshToken;
  int expiresAt;
  String tokenType;

  Data({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
    required this.tokenType,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        expiresAt: json["expires_at"],
        tokenType: json["token_type"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "expires_at": expiresAt,
        "token_type": tokenType,
      };
}
