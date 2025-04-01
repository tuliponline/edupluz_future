// To parse this JSON data, do
//
//     final checkExam200Response = checkExam200ResponseFromJson(jsonString);

import 'dart:convert';

CheckExam200Response checkExam200ResponseFromJson(String str) =>
    CheckExam200Response.fromJson(json.decode(str));

String checkExam200ResponseToJson(CheckExam200Response data) =>
    json.encode(data.toJson());

class CheckExam200Response {
  String code;
  String msg;
  Data data;

  CheckExam200Response({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory CheckExam200Response.fromJson(Map<String, dynamic> json) =>
      CheckExam200Response(
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
  int totalQuestions;
  int correctChoices;
  int correctPercent;
  bool isPassed;

  Data({
    required this.totalQuestions,
    required this.correctChoices,
    required this.correctPercent,
    required this.isPassed,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalQuestions: json["total_questions"],
        correctChoices: json["correct_choices"],
        correctPercent: json["correct_percent"],
        isPassed: json["is_passed"],
      );

  Map<String, dynamic> toJson() => {
        "total_questions": totalQuestions,
        "correct_choices": correctChoices,
        "correct_percent": correctPercent,
        "is_passed": isPassed,
      };
}
