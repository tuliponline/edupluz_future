import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../constant/api_path.dart';
import '../../models/auth/login_200_response.dart';
import '../../providers/auth/auth_provider.dart';
import '../api/public_api_service.dart';
import '../storages/login_model/login_model.dart';
import '../storages/storage_services.dart';

class LoginService {
  Future<Login200Response> login({
    required String username,
    required String password,
    String? twoFaCode,
    required WidgetRef ref,
  }) async {
    Map<String, dynamic> body = {
      'username': username,
      'password': password,
    };
    if (twoFaCode != null) {
      body['two_fa_code'] = twoFaCode;
    }

    try {
      String response = await PublicApiService().post(
        path: ApiPath.login,
        body: body,
      );
      final loginResponse = login200ResponseFromJson(response);
      Login login = Login(
        accessToken: loginResponse.data.accessToken,
        refreshToken: loginResponse.data.refreshToken,
        expiresAt: loginResponse.data.expiresAt,
      );
      await StorageServices.setLoginData(login);
      ref.read(isSigninProvider.notifier).state = true;
      Logger().d("Login Success");
      return loginResponse;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Login200Response> refreshToken({required String refreshToken}) async {
    try {
      String response = await PublicApiService().post(
        path: ApiPath.refreshToken,
        body: {'refresh_token': refreshToken},
      );
      final loginResponse = login200ResponseFromJson(response);
      Login login = Login(
        accessToken: loginResponse.data.accessToken,
        refreshToken: loginResponse.data.refreshToken,
        expiresAt: loginResponse.data.expiresAt,
      );
      StorageServices.setLoginData(login);
      return loginResponse;
    } catch (e) {
      Logger().e(e);

      throw Exception(e);
    }
  }

  Future<bool> checkIsLogin(WidgetRef ref) async {
    var login = await StorageServices.getLoginData();
    if (login == null) {
      ref.read(isSigninProvider.notifier).state = false;
      return false;
    }
    ref.read(isSigninProvider.notifier).state = true;
    return true;
  }

  Future<void> logout(WidgetRef ref) async {
    await StorageServices.deleteLoginData();
    ref.read(isSigninProvider.notifier).state = false;
  }
}
