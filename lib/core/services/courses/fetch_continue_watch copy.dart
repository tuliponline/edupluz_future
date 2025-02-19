import 'package:edupluz_future/core/constant/api_path.dart';
import 'package:edupluz_future/core/models/courses/courses_model.dart';
import 'package:edupluz_future/core/providers/courses/continue_watch_provider.dart';
import 'package:edupluz_future/core/services/api/private_api_service.dart';
import 'package:edupluz_future/core/services/courses/fake_courses.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

Future<CoursesModel> fetchContinueWatch({
  int page = 1,
  int limit = 10,
  required WidgetRef ref,
}) async {
  try {
    // String finalPath = "${ApiPath.continueWatch}?page=$page&limit=$limit";
    // String responseData = await PrivateApiService().get(path: finalPath);
    // CoursesModel coursesModel = coursesModelFromJson(responseData);
    // ref.read(continueWatchProvider.notifier).state = coursesModel;
    // return coursesModel;
    return FakeCourses.getCourses();
  } catch (e) {
    Logger().e(e);
    rethrow;
  }
}
