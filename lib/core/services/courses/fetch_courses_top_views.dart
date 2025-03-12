import 'package:edupluz_future/core/models/courses/courses_model.dart';
import 'package:edupluz_future/core/services/api/private_api_service.dart';
import 'package:edupluz_future/core/services/courses/fake_courses.dart';

import 'package:logger/logger.dart';

Future<CoursesModel> fetchCoursesTopViews({
  int page = 1,
  int limit = 10,
}) async {
  Logger().d("Fetching Courses Top Views");
  try {
    // String finalPath =
    //     "${ApiPath.courseSearch}?page=$page&limit=$limit&order_by=views:desc";
    // String userData = await PrivateApiService().get(path: finalPath);
    // CoursesModel coursesModel = coursesModelFromJson(userData);
    // Logger().d(coursesModel.data.items.length);
    // return coursesModel;
    return Future.value(FakeCourses.getCourses());
  } catch (e) {
    Logger().e(e);
    rethrow;
  }
}
