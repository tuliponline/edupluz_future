import 'package:edupluz_future/core/constant/app_env.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class DirectusApiService {
  Future<String> get({required String path}) async {
    Uri uri = Uri.parse("${dotenv.get(AppEnv.directusBaseApi)}$path");
    Logger().d("Directus Url $uri");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      Logger().d("response.body: ${response.body}");
      return response.body;
    } else {
      Logger().e('Failed Call API code ${response.statusCode} url:$uri');
      return response.body;
    }
  }

  Future<String> getAssets({required String path}) async {
    Uri uri = Uri.parse("${dotenv.get(AppEnv.directusBaseApi)}/assets/$path");
    return uri.toString();
  }
}
