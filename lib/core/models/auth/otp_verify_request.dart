// To parse this JSON data, do
//
//     final otpVerifyRequest = otpVerifyRequestFromJson(jsonString);

import 'dart:convert';

OtpVerifyRequest otpVerifyRequestFromJson(String str) =>
    OtpVerifyRequest.fromJson(json.decode(str));

String otpVerifyRequestToJson(OtpVerifyRequest data) =>
    json.encode(data.toJson());

class OtpVerifyRequest {
  String refCode;
  String otpCode;

  OtpVerifyRequest({
    required this.refCode,
    required this.otpCode,
  });

  factory OtpVerifyRequest.fromJson(Map<String, dynamic> json) =>
      OtpVerifyRequest(
        refCode: json["ref_code"],
        otpCode: json["otp_code"],
      );

  Map<String, dynamic> toJson() => {
        "ref_code": refCode,
        "otp_code": otpCode,
      };
}
