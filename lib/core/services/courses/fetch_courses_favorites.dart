import 'package:edupluz_future/core/constant/api_path.dart';
import 'package:edupluz_future/core/enums/courses_enum.dart';
import 'package:edupluz_future/core/models/courses/courses_model.dart';
import 'package:edupluz_future/core/providers/courses/courses_favorites_provider.dart';
import 'package:edupluz_future/core/services/api/private_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

Future<CoursesModel> fetchCoursesFavorites({
  int page = 1,
  int limit = 10,
  SortTypr? sort,
  required WidgetRef ref,
}) async {
  Logger().d("Fetching Courses");
  try {
    String finalPath =
        "${ApiPath.courseFavorites}?page=$page&limit=$limit${sort == null ? "" : "&order_by=created_at:${sort.name}"}";
    String userData = await PrivateApiService().get(path: finalPath);
    CoursesModel coursesModel = coursesModelFromJson(userData);
    ref.read(coursesFavoritesProvider.notifier).state = coursesModel;
    Logger().d(coursesModel.data.items.length);

    return coursesModel;
  } catch (e) {
    Logger().e(e);
    rethrow;
  }
}
