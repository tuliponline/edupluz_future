import 'dart:convert';

import 'package:edupluz_future/core/constant/api_path.dart';
import 'package:edupluz_future/core/models/courses/course_model.dart';
import 'package:edupluz_future/core/services/api/private_api_service.dart';
import 'package:edupluz_future/core/services/courses/fake_courses.dart';

import 'package:logger/logger.dart';

Future<CourseModel> fetchCourseById({required String id}) async {
  try {
    // String finalPath = "${ApiPath.courses}/$id";
    // final responseData = await PrivateApiService().get(path: finalPath);
    // Map jsonData = jsonDecode(responseData)['data'];
    // CourseModel courseModel = courseModelFromJson(jsonEncode(jsonData));
    // return courseModel;
    return Future.value(FakeCourses.courseById());
  } catch (e) {
    Logger().e(e);
    rethrow;
  }
}
