// To parse this JSON data, do
//
//     final contactsModel = contactsModelFromJson(jsonString);

import 'dart:convert';

ContactsModel contactsModelFromJson(String str) =>
    ContactsModel.fromJson(json.decode(str));

String contactsModelToJson(ContactsModel data) => json.encode(data.toJson());

class ContactsModel {
  List<Datum> data;

  ContactsModel({
    required this.data,
  });

  factory ContactsModel.fromJson(Map<String, dynamic> json) => ContactsModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String id;
  String status;
  String name;
  String icon;
  String url;

  Datum({
    required this.id,
    required this.status,
    required this.name,
    required this.icon,
    required this.url,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        status: json["status"],
        name: json["name"],
        icon: json["icon"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "name": name,
        "icon": icon,
        "url": url,
      };
}
