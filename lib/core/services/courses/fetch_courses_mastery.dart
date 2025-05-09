import 'package:edupluz_future/core/constant/api_path.dart';
import 'package:edupluz_future/core/models/courses/courses_model.dart';
import 'package:edupluz_future/core/services/api/private_api_service.dart';
import 'package:logger/logger.dart';

Future<CoursesModel> fetchCoursesMastery({
  int page = 1,
  int limit = 10,
}) async {
  Logger().d("Fetching Courses Top Views");
  try {
    String finalPath = "${ApiPath.courses}?page=$page&limit=$limit";
    Logger().d(finalPath);
    String userData = await PrivateApiService().get(path: finalPath);
    CoursesModel coursesModel = coursesModelFromJson(userData);
    coursesModel.data.items.shuffle();
    Logger().d(coursesModel.data.items.length);
    return coursesModel;
  } catch (e) {
    Logger().e(e);
    rethrow;
  }
}
