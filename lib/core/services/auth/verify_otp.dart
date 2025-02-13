import 'package:logger/logger.dart';

import '../../../constant/api_path.dart';
import '../api/public_api_service.dart';

Future<bool> verifyOtpService(
    {required String refCode, required String otp}) async {
  try {
    await PublicApiService().post(
      path: ApiPath.verifyOtp,
      body: {
        "ref_code": refCode,
        "otp_code": otp,
      },
    );
    return true;
  } catch (e) {
    Logger().e(e);
    return false;
  }
}
