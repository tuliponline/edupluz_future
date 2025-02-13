import 'package:edupluz_future/core/providers/language_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../constant/api_path.dart';
import '../../models/auth/register_response_model.dart';
import '../api/public_api_service.dart';

Future<RegisterResponseModel?> registerService(
    {required WidgetRef ref,
    required String email,
    required String password}) async {
  try {
    var response = await PublicApiService().post(
      path: ApiPath.register,
      language: ref.read(languageProvider),
      body: {
        "username": email,
        "password": password,
      },
    );
    RegisterResponseModel registerResponseModel =
        registerResponseModelFromJson(response);

    return registerResponseModel;
  } catch (e) {
    Logger().e(e);
    throw Exception(e);
  }
}
