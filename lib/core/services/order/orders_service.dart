import 'package:edupluz_future/core/constant/api_path.dart';
import 'package:edupluz_future/core/enums/enum_language.dart';
import 'package:edupluz_future/core/models/courses/create_order_200_response.dart';
import 'package:edupluz_future/core/services/api/private_api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class OrdersService {
  Future<CreateOrder200Response> createOrder({
    required String productId,
    required String productName,
    required int price,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    try {
      final response = await PrivateApiService().post(
        ref: ref,
        context: context,
        path: "${ApiPath.orders}",
        body: {
          "product_id": productId,
          "product_name": productName,
          "price": price,
        },
        language: LanguageEnum.th,
      );
      return createOrder200ResponseFromJson(response);
    } catch (e) {
      Logger().e(e);
      throw Exception(e);
    }
  }
}
