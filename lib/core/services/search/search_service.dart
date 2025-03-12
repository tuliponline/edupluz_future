import 'package:edupluz_future/core/constant/api_path.dart';
import 'package:edupluz_future/core/models/courses/courses_model.dart';
import 'package:edupluz_future/core/services/api/public_api_service.dart';
import 'package:edupluz_future/core/services/courses/fake_courses.dart';
import 'package:logger/logger.dart';

class SearchService {
  Future<CoursesModel> searchWithKeyword(
      {required String keyword,
      required int page,
      required String orderBy,
      bool isMastery = false}) async {
    String apiUrl =
        "${ApiPath.courseSearch}?page=$page&limit=10&name=$keyword&order_by=$orderBy&is_mastery=$isMastery";

    try {
      // final response = await PublicApiService().get(path: apiUrl);
      // return coursesModelFromJson(response);
      return Future.value(FakeCourses.getCourses());
    } catch (e) {
      Logger().e('Exception when calling SearchApi->searchWithKeyword: $e\n');
      throw Exception(e);
    }
  }
}
