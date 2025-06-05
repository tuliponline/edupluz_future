import 'package:edupluz_future/core/constant/api_path.dart';
import 'package:edupluz_future/core/models/products/products_model.dart';
import 'package:edupluz_future/core/services/api/private_api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class GetProductService {
  Future<ProductsModel> getProductBuffet(
    WidgetRef ref,
    BuildContext context,
  ) async {
    try {
      final response = await PrivateApiService().get(
          ref: ref,
          context: context,
          path:
              "${ApiPath.products}?filters=item_type:BUFFET&order_by=duration:Aasc");
      ProductsModel productsModel = productsModelFromJson(response);
      return productsModel;
    } catch (e) {
      Logger().e(e);
      throw Exception(e);
    }
  }

  Future<ProductsModel> getProductByCourseId(
    String courseId,
    WidgetRef ref,
    BuildContext context,
  ) async {
    try {
      final response = await PrivateApiService().get(
        ref: ref,
        context: context,
        path: "${ApiPath.products}?filters=item_id:$courseId",
      );
      ProductsModel productsModel = productsModelFromJson(response);
      return productsModel;
    } catch (e) {
      Logger().e(e);
      throw Exception(e);
    }
  }
}
