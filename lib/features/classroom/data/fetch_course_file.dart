import 'dart:convert';
import 'dart:io';

import 'package:edupluz_future/core/constant/app_env.dart';
import 'package:edupluz_future/core/services/api/directus_api_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

fetchCourseFile(String slug) async {
  // String courseFilePath = "/items/course_files/$slug?fields=files.*.*";

  // final response = await DirectusApiService().get(path: courseFilePath);
  // final error = jsonDecode(response)['errors'];

  // if (error != null) {
  //   Logger().e('fetchCourseFile Error $response\n');
  // } else {
  //   String fileId =
  //       jsonDecode(response)['data']['files'][0]['directus_files_id']['id'];
  //   Logger().d("fetchCourseFile: $fileId");
  //   String courseFileDownloadPath =
  //       "${dotenv.get(AppEnv.directusBaseApi)}/assets/$fileId?download";

  //   var response2 = await http.get(Uri.parse(courseFileDownloadPath));

  //   var dir = await getTemporaryDirectory();
  //   File file = File('${dir.path}/course-file.pdf');
  //   await file.writeAsBytes(response2.bodyBytes, flush: true);

  //   return file.path;
  // }
  return "https://www.youtube.com/watch?v=dQw4w9WgXcQ";
}

fetchCourseFileUrl(String slug) async {
  // String courseFilePath = "/items/course_files/$slug?fields=files.*.*";
  // final response = await DirectusApiService().get(path: courseFilePath);
  // final error = jsonDecode(response)['errors'];
  // if (error != null) {
  //   Logger().e('fetchCourseFile Error $response\n');
  // } else {
  //   String fileId =
  //       jsonDecode(response)['data']['files'][0]['directus_files_id']['id'];
  //   Logger().d("fetchCourseFile: $fileId");
  //   String courseFileDownloadPath =
  //       "${dotenv.get(AppEnv.directusBaseApi)}/assets/$fileId?download";
  //   return courseFileDownloadPath;
  // }
  return "https://www.youtube.com/watch?v=dQw4w9WgXcQ";
}
