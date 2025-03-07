// To parse this JSON data, do
//
//     final getUser200Response = getUser200ResponseFromJson(jsonString);

import 'dart:convert';

GetUser200Response getUser200ResponseFromJson(String str) =>
    GetUser200Response.fromJson(json.decode(str));

String getUser200ResponseToJson(GetUser200Response data) =>
    json.encode(data.toJson());

class GetUser200Response {
  String code;
  String msg;
  Data data;

  GetUser200Response({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory GetUser200Response.fromJson(Map<String, dynamic> json) =>
      GetUser200Response(
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
  String id;
  String uid;
  String username;
  String firstName;
  String lastName;
  String nationality;
  String sex;
  String phone;
  String email;
  bool emailVerified;
  bool enabled;
  DateTime dateOfBirth;
  Address address;
  IdCard idCard;
  Bank bank;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
    required this.id,
    required this.uid,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.nationality,
    required this.sex,
    required this.phone,
    required this.email,
    required this.emailVerified,
    required this.enabled,
    required this.dateOfBirth,
    required this.address,
    required this.idCard,
    required this.bank,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        uid: json["uid"],
        username: json["username"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        nationality: json["nationality"],
        sex: json["sex"],
        phone: json["phone"],
        email: json["email"],
        emailVerified: json["email_verified"],
        enabled: json["enabled"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        address: Address.fromJson(json["address"]),
        idCard: IdCard.fromJson(json["id_card"]),
        bank: Bank.fromJson(json["bank"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "username": username,
        "first_name": firstName,
        "last_name": lastName,
        "nationality": nationality,
        "sex": sex,
        "phone": phone,
        "email": email,
        "email_verified": emailVerified,
        "enabled": enabled,
        "date_of_birth": dateOfBirth.toIso8601String(),
        "address": address.toJson(),
        "id_card": idCard.toJson(),
        "bank": bank.toJson(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Address {
  String addressLine1;
  String addressLine2;
  String addressLine3;
  String city;
  String district;
  String subDistrict;
  String state;
  String postalCode;
  String country;
  String countryCode;

  Address({
    required this.addressLine1,
    required this.addressLine2,
    required this.addressLine3,
    required this.city,
    required this.district,
    required this.subDistrict,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.countryCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        addressLine1: json["address_line1"],
        addressLine2: json["address_line2"],
        addressLine3: json["address_line3"],
        city: json["city"],
        district: json["district"],
        subDistrict: json["sub_district"],
        state: json["state"],
        postalCode: json["postal_code"],
        country: json["country"],
        countryCode: json["country_code"],
      );

  Map<String, dynamic> toJson() => {
        "address_line1": addressLine1,
        "address_line2": addressLine2,
        "address_line3": addressLine3,
        "city": city,
        "district": district,
        "sub_district": subDistrict,
        "state": state,
        "postal_code": postalCode,
        "country": country,
        "country_code": countryCode,
      };
}

class Bank {
  String bankAccountName;
  String bankAccountNo;
  String bankName;
  String bankBranch;
  String bankBook;

  Bank({
    required this.bankAccountName,
    required this.bankAccountNo,
    required this.bankName,
    required this.bankBranch,
    required this.bankBook,
  });

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        bankAccountName: json["bank_account_name"],
        bankAccountNo: json["bank_account_no"],
        bankName: json["bank_name"],
        bankBranch: json["bank_branch"],
        bankBook: json["bank_book"],
      );

  Map<String, dynamic> toJson() => {
        "bank_account_name": bankAccountName,
        "bank_account_no": bankAccountNo,
        "bank_name": bankName,
        "bank_branch": bankBranch,
        "bank_book": bankBook,
      };
}

class IdCard {
  String idCardFront;
  String idCardBack;

  IdCard({
    required this.idCardFront,
    required this.idCardBack,
  });

  factory IdCard.fromJson(Map<String, dynamic> json) => IdCard(
        idCardFront: json["id_card_front"],
        idCardBack: json["id_card_back"],
      );

  Map<String, dynamic> toJson() => {
        "id_card_front": idCardFront,
        "id_card_back": idCardBack,
      };
}
