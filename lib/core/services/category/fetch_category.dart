import 'dart:convert';

import 'package:edupluz_future/core/constant/api_path.dart';
import 'package:edupluz_future/core/models/category/get_categories_200_response.dart';
import 'package:edupluz_future/core/services/api/public_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

Future<GetCategories200Response> fetchCategories(
    {required WidgetRef ref}) async {
  try {
    String finalPath = ApiPath.categories;
    String categoryData = await PublicApiService().get(path: finalPath);
    GetCategories200Response catagoriesData =
        getCategories200ResponseFromJson(categoryData);
    Logger()
        .d("catagories length: ${jsonEncode(catagoriesData.data.items[0])}");
    return catagoriesData;
  } catch (e) {
    Logger().e(e);
    rethrow;
  }
}
