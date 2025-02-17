import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../../configs/alice_init.dart';
import '../../../constant/app_env.dart';
import '../../enums/enum_language.dart';

// Create Alice instance

class PublicApiService {
  Future<String> get({
    required String path,
  }) async {
    Uri uri = Uri.parse("${dotenv.get(AppEnv.apiBasePath)}$path");
    Logger().d(uri.toString());
    final response =
        await http.get(uri, headers: {'Accept': 'application/json'});
    // Using dart:convert, we then decode the JSON payload into a Map data structure.
    Logger().d(uri.toString());
    alice.onHttpResponse(response, body: response.body);
    if (response.statusCode != 200) {
      Logger().e("${response.statusCode} ${response.body}");

      throw Exception('Failed Call API code ${response.statusCode}');
    } else {
      Logger().d(response.statusCode);
    }
    final json = jsonDecode(response.body);
    return jsonEncode(json);
  }

  Future<String> post(
      {required String path,
      LanguageEnum? language,
      required Map<String, dynamic> body}) async {
    Uri uri = Uri.parse("${dotenv.get(AppEnv.apiBasePath)}$path");
    final response = await http.post(uri,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Accept-Language': (language == LanguageEnum.th) ? 'th-TH' : 'en-US'
        },
        body: jsonEncode(body));

    alice.onHttpResponse(response, body: response.body);
    if (response.statusCode != 200) {
      Logger().e("error url ${uri.toString()}");
      Logger().e(response.statusCode);
      Logger().e(response.body);
      throw Exception(response.body);
    }
    return response.body;
  }
}
