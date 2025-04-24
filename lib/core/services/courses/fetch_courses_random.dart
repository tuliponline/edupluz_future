import 'package:edupluz_future/core/constant/api_path.dart';
import 'package:edupluz_future/core/models/courses/courses_model.dart';
import 'package:edupluz_future/core/services/api/private_api_service.dart';
import 'package:edupluz_future/core/services/courses/fake_courses.dart';
import 'package:logger/logger.dart';

Future<CoursesModel> fetchCoursesRandom({
  int page = 1,
  int limit = 10,
  String status = "PUBLISHED",
  bool isEdupluz = true,
}) async {
  Logger().d("Fetching Courses Top Views");
  try {
    String finalPath =
        "${ApiPath.courses}?page=$page&limit=$limit&filters=status:$status,is_edupluz:$isEdupluz";
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
