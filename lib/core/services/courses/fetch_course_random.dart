import 'package:edupluz_future/core/constant/api_path.dart';
import 'package:edupluz_future/core/models/courses/course_model.dart';
import 'package:edupluz_future/core/services/api/private_api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

Future<CourseModel> fetchCourseRandom({
  int page = 1,
  int limit = 1,
  bool isEdupluz = true,
  String status = "PUBLISHED",
  required WidgetRef ref,
  required BuildContext context,
}) async {
  Logger().d("Fetching random courses");
  try {
    String finalPath =
        "${ApiPath.courses}/random?filters=is_edupluz:$isEdupluz,status:$status";
    String courseData = await PrivateApiService().get(
      path: finalPath,
      ref: ref,
      context: context,
    );
    CourseModel courseDataModel = courseModelFromJson(courseData);
    return courseDataModel;
    // return Future.value(FakeCourses.getCourses().data.items[0]);
  } catch (e) {
    Logger().e(e);
    throw Exception(e);
  }
}
