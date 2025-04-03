import 'dart:convert';
import 'dart:typed_data';

import 'package:edupluz_future/core/constant/api_path.dart';
import 'package:edupluz_future/core/constant/app_env.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

import 'package:http/http.dart' as http;

import '../../../configs/alice_init.dart';
import '../../enums/enum_language.dart';
import '../auth/authsService_service.dart';
import '../storages/storage_services.dart';

class PrivateApiService {
  Future<String> _getToken() async {
    final loginData = await StorageServices.getLoginData();
    if (loginData == null) {
      throw Exception('Login data not found');
    }
    try {
      final _loginData = await AuthsService().refreshToken(
        refreshToken: loginData.refreshToken,
      );
      return _loginData.data.accessToken;
    } catch (e) {
      throw Exception('Failed to get access token');
    }
  }

  Future<Uint8List> downloadCer(
    String examKey,
  ) async {
    String accessToken = await _getToken();

    Uri uri = Uri.parse(
        "${dotenv.get(AppEnv.apiBasePath)}${ApiPath.exam}/certificate?key=$examKey");
    final response = await http.get(uri, headers: {
      'Content-Type': 'application/octet-stream',
      'Content-Disposition': 'attachment; filename=certificate.jpg',
      'Authorization': "Bearer $accessToken",
    });
    if (response.statusCode == 200) {
      Uint8List data = response.bodyBytes;
      return data;
    } else {
      Logger().e(response.reasonPhrase);
      throw Exception('Failed Call API code ${response.statusCode}');
    }
  }

  Future<String> get({
    required String path,
  }) async {
    Uri uri = Uri.parse("${dotenv.get(AppEnv.apiBasePath)}$path");
    Logger().d(uri.toString());
    final accessToken = await _getToken();

    final response = await http.get(uri, headers: {
      'Accept': 'application/json',
      'Authorization': "Bearer $accessToken",
    });
    alice.onHttpResponse(response, body: response.body);
    if (response.statusCode != 200) {
      Logger().e("error url ${uri.toString()}");
      Logger().e(response.statusCode);
      Logger().e(response.body);
      throw Exception('Failed Call API code ${response.statusCode}');
    }
    return response.body;
  }

  Future<String> post({
    required String path,
    required LanguageEnum language,
    required Map<String, dynamic> body,
  }) async {
    Uri uri = Uri.parse("${dotenv.get(AppEnv.apiBasePath)}$path");
    Logger().d(uri.toString());
    final accessToken = await _getToken();

    final response = await http.post(uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept-Language': (language == LanguageEnum.th) ? 'th-TH' : 'en-US',
          'Authorization': "Bearer $accessToken",
        },
        body: json.encode(body));
    alice.onHttpResponse(response, body: response.body);
    if (response.statusCode != 200) {
      Logger().e("error url ${uri.toString()}");
      Logger().e(response.statusCode);
      Logger().e(response.body);
      throw Exception('Failed Call API code ${response.statusCode}');
    }
    return response.body;
  }

  Future<bool> patch({
    required String path,
    String? id,
    required Map<String, dynamic> body,
  }) async {
    Uri uri = Uri.parse("${dotenv.get(AppEnv.apiBasePath)}$path/${id ?? ""}");
    final accessToken = await _getToken();

    final response = await http.patch(uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $accessToken",
        },
        body: json.encode(body));
    alice.onHttpResponse(response, body: response.body);
    if (response.statusCode != 200) {
      throw Exception('Failed Call API code ${response.statusCode}');
    }
    return true;
  }

  Future<bool> delete({required String path, required String id}) async {
    Uri uri = Uri.parse("${dotenv.get(AppEnv.apiBasePath)}$path/$id");
    final accessToken = await _getToken();

    final response = await http.delete(uri, headers: {
      'Authorization': "Bearer $accessToken",
    });
    alice.onHttpResponse(response, body: response.body);
    if (response.statusCode != 200) {
      Logger().e(response.body);
      throw Exception('Failed Call API code ${response.statusCode}');
    }
    return true;
  }
}
