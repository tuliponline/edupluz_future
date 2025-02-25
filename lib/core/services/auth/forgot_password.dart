import 'package:edupluz_future/constant/api_path.dart';
import 'package:edupluz_future/core/models/auth/forgot_password_otp_verify_response.dart';
import 'package:edupluz_future/core/models/auth/otp_verify_request.dart';

import 'package:edupluz_future/core/models/auth/register_response_model.dart';
import 'package:edupluz_future/core/services/api/public_api_service.dart';

class ForgotPasswordService {
  Future<RegisterResponseModel> forgotPassword(String email) async {
    try {
      var response = await PublicApiService()
          .post(path: ApiPath.forgotPassword, body: {'email': email});
      return registerResponseModelFromJson(response);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<ForgotPasswordOtpVerifyResponse> forgotPasswordOtpVerify(
      OtpVerifyRequest request) async {
    try {
      final response = await PublicApiService().post(
        path: ApiPath.forgotPasswordOtpVerify,
        body: request.toJson(),
      );
      return forgotPasswordOtpVerifyResponseFromJson(response);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> resetPassword(String token, String password) async {
    try {
      await PublicApiService().post(
          path: ApiPath.resetPassword,
          body: {'token': token, 'password': password});
    } catch (e) {
      throw Exception(e);
    }
  }
}
