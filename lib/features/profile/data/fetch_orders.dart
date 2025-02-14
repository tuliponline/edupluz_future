import 'package:edupluz_future/constant/api_path.dart';
import 'package:edupluz_future/core/enums/courses_enum.dart';
import 'package:edupluz_future/core/services/api/private_api_service.dart';
import 'package:edupluz_future/features/profile/domain/orders_model.dart';
import 'package:logger/logger.dart';

Future<OrdersModel> fetchOrders({
  int page = 1,
  int limit = 10,
  SortTypr? sort,
}) async {
  Logger().d("Fetching Courses");
  try {
    String finalPath =
        "${ApiPath.orders}?page=$page&limit=$limit${sort == null ? "" : "&order_by=created_at"}";
    String ordersData = await PrivateApiService().get(path: finalPath);
    OrdersModel ordersModel = ordersModelFromJson(ordersData);

    return ordersModel;
  } catch (e) {
    Logger().e(e);
    rethrow;
  }
}
