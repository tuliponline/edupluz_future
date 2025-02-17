import 'dart:convert';

import 'package:edupluz_future/constant/api_path.dart';
import 'package:edupluz_future/core/models/category/catagories_model.dart';
import 'package:edupluz_future/core/services/api/public_api_service.dart';
import 'package:edupluz_future/core/services/category/fake_category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

Future<CatagoriesModel> fetchCategories({required WidgetRef ref}) async {
  try {
    // String finalPath = ApiPath.categories;
    // String categoryData = await PublicApiService().get(path: finalPath);
    // CatagoriesModel catagoriesModel = catagoriesModelFromJson(categoryData);
    // Logger()
    //     .d("catagories length: ${jsonEncode(catagoriesModel.data.items[0])}");
    // return catagoriesModel;
    return FakeCategory.getCategories();
  } catch (e) {
    Logger().e(e);
    rethrow;
  }
}
