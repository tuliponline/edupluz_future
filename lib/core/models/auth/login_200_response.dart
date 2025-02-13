// To parse this JSON data, do
//
//     final login200Response = login200ResponseFromJson(jsonString);

import 'dart:convert';

Login200Response login200ResponseFromJson(String str) =>
    Login200Response.fromJson(json.decode(str));

String login200ResponseToJson(Login200Response data) =>
    json.encode(data.toJson());

class Login200Response {
  String code;
  String msg;
  Data data;

  Login200Response({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory Login200Response.fromJson(Map<String, dynamic> json) =>
      Login200Response(
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
