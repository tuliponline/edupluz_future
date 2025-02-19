// To parse this JSON data, do
//
//     final examinationKeyModel = examinationKeyModelFromJson(jsonString);

import 'dart:convert';

ExaminationKeyModel examinationKeyModelFromJson(String str) =>
    ExaminationKeyModel.fromJson(json.decode(str));

String examinationKeyModelToJson(ExaminationKeyModel data) =>
    json.encode(data.toJson());

class ExaminationKeyModel {
  String code;
  String msg;
  Data data;

  ExaminationKeyModel({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory ExaminationKeyModel.fromJson(Map<String, dynamic> json) =>
      ExaminationKeyModel(
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
  String key;

  Data({
    required this.key,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        key: json["key"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
      };
}
