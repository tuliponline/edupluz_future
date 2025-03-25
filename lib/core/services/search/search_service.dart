import 'package:edupluz_future/core/constant/api_path.dart';
import 'package:edupluz_future/core/models/courses/courses_model.dart';
import 'package:edupluz_future/core/services/api/public_api_service.dart';
import 'package:logger/logger.dart';

class SearchService {
  Future<CoursesModel> searchWithKeyword(
      {required String keyword,
      required int page,
      required String orderBy,
      bool isMastery = false}) async {
    String apiUrl =
        "${ApiPath.courses}?page=$page&limit=10&filters=title:$keyword&order_by=$orderBy";

    try {
      final response = await PublicApiService().get(path: apiUrl);
      return coursesModelFromJson(response);
    } catch (e) {
      Logger().e('Exception when calling SearchApi->searchWithKeyword: $e\n');
      throw Exception(e);
    }
  }
}
