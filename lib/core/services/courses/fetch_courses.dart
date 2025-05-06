import 'package:edupluz_future/core/constant/api_path.dart';
import 'package:edupluz_future/core/models/courses/courses_model.dart';
import 'package:edupluz_future/core/services/api/private_api_service.dart';
import 'package:logger/logger.dart';

Future<CoursesModel> fetchCourses({
  int page = 1,
  int limit = 10,
  String orderBy = "",
  String status = "PUBLISHED",
  bool isEdupluz = true,
  String? filter,
}) async {
  Logger().d("Fetching Courses");
  try {
    String finalPath =
        "${ApiPath.courses}?page=$page&limit=$limit&order_by=$orderBy&filters=status:$status,is_edupluz:$isEdupluz";
    if (filter != null) {
      finalPath += ",$filter";
    }
    Logger().d(finalPath);
    String userData = await PrivateApiService().get(path: finalPath);
    CoursesModel coursesModel = coursesModelFromJson(userData);
    Logger().d(coursesModel.data.items.length);

    return coursesModel;
  } catch (e) {
    Logger().e(e);
    throw Exception(e);
  }
}
