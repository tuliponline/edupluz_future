// To parse this JSON data, do
//
//     final forgotPasswordOtpVerifyResponse = forgotPasswordOtpVerifyResponseFromJson(jsonString);

import 'dart:convert';

ForgotPasswordOtpVerifyResponse forgotPasswordOtpVerifyResponseFromJson(
        String str) =>
    ForgotPasswordOtpVerifyResponse.fromJson(json.decode(str));

String forgotPasswordOtpVerifyResponseToJson(
        ForgotPasswordOtpVerifyResponse data) =>
    json.encode(data.toJson());

class ForgotPasswordOtpVerifyResponse {
  String code;
  String msg;
  Data data;

  ForgotPasswordOtpVerifyResponse({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory ForgotPasswordOtpVerifyResponse.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordOtpVerifyResponse(
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
  String token;

  Data({
    required this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
