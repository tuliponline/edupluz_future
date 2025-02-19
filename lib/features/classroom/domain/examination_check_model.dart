// To parse this JSON data, do
//
//     final examinationCheckModel = examinationCheckModelFromJson(jsonString);

import 'dart:convert';

ExaminationCheckModel examinationCheckModelFromJson(String str) =>
    ExaminationCheckModel.fromJson(json.decode(str));

String examinationCheckModelToJson(ExaminationCheckModel data) =>
    json.encode(data.toJson());

class ExaminationCheckModel {
  String code;
  String msg;
  Data data;

  ExaminationCheckModel({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory ExaminationCheckModel.fromJson(Map<String, dynamic> json) =>
      ExaminationCheckModel(
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
  int correctChoices;
  int correctPercent;
  int totalChoices;
  bool passed;

  Data({
    required this.correctChoices,
    required this.correctPercent,
    required this.totalChoices,
    required this.passed,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        correctChoices: json["correctChoices"],
        correctPercent: json["correctPercent"],
        totalChoices: json["totalChoices"],
        passed: json["passed"],
      );

  Map<String, dynamic> toJson() => {
        "correctChoices": correctChoices,
        "correctPercent": correctPercent,
        "totalChoices": totalChoices,
        "passed": passed,
      };
}
