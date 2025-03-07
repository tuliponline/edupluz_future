import 'package:edupluz_future/core/constant/api_path.dart';
import 'package:edupluz_future/core/constant/app_env.dart';
import 'package:edupluz_future/core/services/storages/login_model/login_model.dart';
import 'package:edupluz_future/core/services/storages/storage_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

Future<String> getExamUrl(String examKey) async {
  Login? login = await StorageServices.getLoginData();
  if (login == null) {
    throw Exception('Login data not found');
  }
  String accessToken = login.accessToken;
  String url =
      "${dotenv.get(AppEnv.examHost)}${ApiPath.examPath}/$examKey?token=$accessToken";
  Logger().d("getExamUre: $url");
  return url;
}
