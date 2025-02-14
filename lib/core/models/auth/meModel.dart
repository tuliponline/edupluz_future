// To parse this JSON data, do
//
//     final meModel = meModelFromJson(jsonString);

import 'dart:convert';

MeModel meModelFromJson(String str) => MeModel.fromJson(json.decode(str));

String meModelToJson(MeModel data) => json.encode(data.toJson());

class MeModel {
  String id;
  String email;
  String firstName;
  String lastName;
  String phoneNumber;
  String picture;

  MeModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.picture,
  });

  factory MeModel.fromJson(Map<String, dynamic> json) => MeModel(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        picture: json["picture"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "picture": picture,
      };
}
