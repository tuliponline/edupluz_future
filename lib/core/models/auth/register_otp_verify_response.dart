// To parse this JSON data, do
//
//     final registerOtpVerifyResponse = registerOtpVerifyResponseFromJson(jsonString);

import 'dart:convert';

RegisterOtpVerifyResponse registerOtpVerifyResponseFromJson(String str) =>
    RegisterOtpVerifyResponse.fromJson(json.decode(str));

String registerOtpVerifyResponseToJson(RegisterOtpVerifyResponse data) =>
    json.encode(data.toJson());

class RegisterOtpVerifyResponse {
  String code;
  String msg;
  Data data;

  RegisterOtpVerifyResponse({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory RegisterOtpVerifyResponse.fromJson(Map<String, dynamic> json) =>
      RegisterOtpVerifyResponse(
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
