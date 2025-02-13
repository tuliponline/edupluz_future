import 'package:logger/logger.dart';

import '../../../constant/api_path.dart';
import '../api/public_api_service.dart';

Future<void> resendEmailService({
  required String refCode,
  required RegisterAction action,
}) async {
  try {
    await PublicApiService().post(
      path: ApiPath.resendOtp,
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
