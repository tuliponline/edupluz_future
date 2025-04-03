// To parse this JSON data, do
//
//     final getExamKey200Response = getExamKey200ResponseFromJson(jsonString);

import 'dart:convert';

GetExamKey200Response getExamKey200ResponseFromJson(String str) =>
    GetExamKey200Response.fromJson(json.decode(str));

String getExamKey200ResponseToJson(GetExamKey200Response data) =>
    json.encode(data.toJson());

class GetExamKey200Response {
  String code;
  String msg;
  Data data;

  GetExamKey200Response({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory GetExamKey200Response.fromJson(Map<String, dynamic> json) =>
      GetExamKey200Response(
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
