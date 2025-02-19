import 'package:edupluz_future/core/constant/api_path.dart';
import 'package:edupluz_future/core/constant/app_env.dart';
import 'package:edupluz_future/core/services/auth/fetch_access_token.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

Future<String> getExamUrl(String examKey) async {
  String accessToken = await fetchAccessToken();
  String url =
      "${dotenv.get(AppEnv.examHost)}${ApiPath.examPath}/$examKey?token=$accessToken";
  Logger().d("getExamUre: $url");
  return url;
}
