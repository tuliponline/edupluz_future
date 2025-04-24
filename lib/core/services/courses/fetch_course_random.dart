import 'package:edupluz_future/core/constant/api_path.dart';
import 'package:edupluz_future/core/models/courses/course_model.dart';
import 'package:edupluz_future/core/services/api/private_api_service.dart';
import 'package:logger/logger.dart';

Future<CourseModel> fetchCourseRandom({
  int page = 1,
  int limit = 1,
  bool isEdupluz = true,
  String status = "PUBLISHED",
}) async {
  Logger().d("Fetching random courses");
  try {
    String finalPath =
        "${ApiPath.courses}/random?filters=is_edupluz:$isEdupluz,status:$status";
    String courseData = await PrivateApiService().get(path: finalPath);
    CourseModel courseDataModel = courseModelFromJson(courseData);
    return courseDataModel;
    // return Future.value(FakeCourses.getCourses().data.items[0]);
  } catch (e) {
    Logger().e(e);
    throw Exception(e);
  }
}
