import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:edupluz_future/core/constant/api_path.dart';
import 'package:edupluz_future/core/constant/app_env.dart';
import 'package:edupluz_future/core/services/storages/login_model/login_model.dart';
import 'package:edupluz_future/core/services/storages/storage_services.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:saver_gallery/saver_gallery.dart';

class CerService {
  Future<Uint8List> downloadCer(
    String examKey,
  ) async {
    Login? login = await StorageServices.getLoginData();
    if (login == null) {
      throw Exception('Login data not found');
    }
    String accessToken = login.accessToken;

    Uri uri = Uri.parse(
        '${dotenv.get(AppEnv.apiBasePath)}${ApiPath.examination}/certificate?key=$examKey');
    final response = await http.get(uri, headers: {
      'Content-Type': 'application/octet-stream',
      'Content-Disposition': 'attachment; filename=certificate.jpg',
      'Authorization': accessToken
    });
    if (response.statusCode == 200) {
      Uint8List data = response.bodyBytes;
      return data;
    } else {
      Logger().e(response.reasonPhrase);
      throw Exception('Failed Call API code ${response.statusCode}');
    }
  }

  Future<void> saveCertificate(Uint8List data) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/certificate.jpg';
    final file = File(path);
    await file.writeAsBytes(data);
  }
}
