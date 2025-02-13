// To parse this JSON data, do
//
//     final registerResponseModel = registerResponseModelFromJson(jsonString);

import 'dart:convert';

RegisterResponseModel registerResponseModelFromJson(String str) =>
    RegisterResponseModel.fromJson(json.decode(str));

String registerResponseModelToJson(RegisterResponseModel data) =>
    json.encode(data.toJson());

class RegisterResponseModel {
  String code;
  String msg;
  Data data;

  RegisterResponseModel({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterResponseModel(
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
  String refCode;

  Data({
    required this.refCode,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        refCode: json["ref_code"],
      );

  Map<String, dynamic> toJson() => {
        "ref_code": refCode,
      };
}
