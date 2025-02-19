import 'package:edupluz_future/core/constant/api_path.dart';
import 'package:edupluz_future/core/models/courses/courses_model.dart';
import 'package:edupluz_future/core/services/api/private_api_service.dart';
import 'package:edupluz_future/core/services/courses/fake_courses.dart';

import 'package:logger/logger.dart';

Future<Item> fetchCourseRandom({
  int page = 1,
  int limit = 1,
}) async {
  Logger().d("Fetching Courses Top Views");
  try {
    // String finalPath = "${ApiPath.courses}/random?limit=$limit";
    // String userData = await PrivateApiService().get(path: finalPath);
    // CoursesModel coursesModel = coursesModelFromJson(userData);
    // return coursesModel.data.items[0];
    return Future.value(FakeCourses.getCourses().data.items[0]);
  } catch (e) {
    Logger().e(e);
    rethrow;
  }
}
