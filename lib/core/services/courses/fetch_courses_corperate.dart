import 'package:edupluz_future/core/constant/api_path.dart';
import 'package:edupluz_future/core/models/courses/courses_model.dart';
import 'package:edupluz_future/core/services/api/private_api_service.dart';
import 'package:edupluz_future/core/services/courses/fake_courses.dart';

import 'package:logger/logger.dart';

Future<CoursesModel> fetchCoursesCorperate({
  int page = 1,
  int limit = 10,
}) async {
  Logger().d("Fetching Courses Corporate");
  try {
    // String finalPath =
    //     "${ApiPath.courseSearch}?is_business=true&page=$page&limit=$limit";
    // String userData = await PrivateApiService().get(path: finalPath);
    // CoursesModel coursesModel = coursesModelFromJson(userData);
    // coursesModel.data.items.shuffle();
    // Logger().d(coursesModel.data.items.length);
    // return coursesModel;
    return FakeCourses.getCourses();
  } catch (e) {
    Logger().e(e);
    rethrow;
  }
}
