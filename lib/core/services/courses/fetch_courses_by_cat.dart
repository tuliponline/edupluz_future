import 'package:edupluz_future/core/constant/api_path.dart';
import 'package:edupluz_future/core/enums/courses_enum.dart';
import 'package:edupluz_future/core/models/courses/courses_model.dart';
import 'package:edupluz_future/core/services/api/private_api_service.dart';

import 'package:logger/logger.dart';

Future<CoursesModel> fetchCoursesBycat(
    {required String catId,
    int page = 1,
    int limit = 10,
    bool isEdupluz = true,
    String status = "PUBLISHED",
    SortTypr? sort}) async {
  Logger().d("Fetching Courses ิ by category");
  try {
    String finalPath =
        "${ApiPath.courses}?filters=category_ids:$catId,status:$status,is_edupluz:$isEdupluz&page=$page&limit=$limit${sort == null ? "" : "&order_by=created_at:${sort.name}"}";
    Logger().d("finalPath $finalPath");
    String userData = await PrivateApiService().get(path: finalPath);
    CoursesModel coursesModel = coursesModelFromJson(userData);
    Logger().d(coursesModel.data.items.length);
    return coursesModel;
  } catch (e) {
    Logger().e(e);
    throw Exception(e);
  }
}
