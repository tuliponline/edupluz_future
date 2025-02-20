import 'package:edupluz_future/core/models/courses/courses_model.dart';
import 'package:edupluz_future/core/services/courses/fake_courses.dart';
import 'package:logger/logger.dart';

Future<CoursesModel> fetchCourses({
  int page = 1,
  int limit = 10,
  String orderBy = "",
}) async {
  Logger().d("Fetching Courses");
  try {
    // String finalPath =
    //     "${ApiPath.courseSearch}?page=$page&limit=$limit&order_by=$orderBy";
    // String userData = await PrivateApiService().get(path: finalPath);
    // CoursesModel coursesModel = coursesModelFromJson(userData);
    // Logger().d(coursesModel.data.items.length);

    // return coursesModel;
    return FakeCourses.getCourses();
  } catch (e) {
    Logger().e(e);
    rethrow;
  }
}
