import 'package:edupluz_future/core/constant/api_path.dart';
import 'package:edupluz_future/core/models/products/products_model.dart';
import 'package:edupluz_future/core/services/api/private_api_service.dart';
import 'package:logger/logger.dart';

class GetProductService {
  Future<ProductsModel> getProductBuffet() async {
    try {
      final response = await PrivateApiService()
          .get(path: "${ApiPath.products}?filters=item_type:BUFFET");
      ProductsModel productsModel = productsModelFromJson(response);
      return productsModel;
    } catch (e) {
      Logger().e(e);
      throw Exception(e);
    }
  }

  Future<ProductsModel> getProductByCourseId(String courseId) async {
    try {
      final response = await PrivateApiService()
          .get(path: "${ApiPath.products}?filters=item_id:$courseId");
      ProductsModel productsModel = productsModelFromJson(response);
      return productsModel;
    } catch (e) {
      Logger().e(e);
      throw Exception(e);
    }
  }
}
