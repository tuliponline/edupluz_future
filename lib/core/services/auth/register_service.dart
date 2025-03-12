import 'package:edupluz_future/core/constant/api_path.dart';
import 'package:edupluz_future/core/models/auth/otp_verify_request.dart';
import 'package:edupluz_future/core/models/auth/register_otp_verify_response.dart';
import 'package:edupluz_future/core/providers/language_provider.dart';
import 'package:edupluz_future/core/services/auth/register_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../models/auth/register_response_model.dart';
import '../api/public_api_service.dart';

Future<RegisterResponseModel?> registerService(
    {required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phone}) async {
  try {
    Logger().d({
      "username": email,
      "password": password,
      "first_name": firstName,
      "last_name": lastName,
      "phone": phone,
    });
    var response = await PublicApiService().post(
      path: ApiPath.register,
      body: {
        "username": email,
        "password": password,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
      },
    );
    Logger().d("register success");
    RegisterResponseModel registerResponseModel =
        registerResponseModelFromJson(response);
    return registerResponseModel;
  } catch (e) {
    Logger().e(e);
    throw Exception(e);
  }
}

Future<RegisterOtpVerifyResponse> registerOtpVerify(
    OtpVerifyRequest request) async {
  try {
    final response = await PublicApiService().post(
      path: ApiPath.registerOtpVerify,
      body: request.toJson(),
    );
    RegisterOtpVerifyResponse responseModel =
        registerOtpVerifyResponseFromJson(response);
    return responseModel;
  } catch (e) {
    Logger().e(e);
    throw Exception(e);
  }
}

Future<void> resendEmail({
  required String refCode,
  required RegisterAction action,
}) async {
  try {
    await PublicApiService().post(
      path: ApiPath.resendEmail,
      body: {'ref_code': refCode, 'action': action.name},
    );
  } catch (e) {
    Logger().e(e);
    throw Exception(e);
  }
}

enum RegisterAction {
  register,
  forgot_password;

  String get name => this.toString().split('.').last;
}
