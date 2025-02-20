import 'package:edupluz_future/features/discover/domain/promotion_model.dart';
import 'package:logger/logger.dart';

Future<PromotionModel> fetchPromotion() async {
  try {
    // final responseData =
    //     await DirectusApiService().get(path: DirectusPath.promotion);
    // return promotionModelFromJson(responseData);
    return PromotionModel(
        data: Data(
            id: "1",
            status: "published",
            title: "ทดสอบ โปรโมชั่น",
            descriptionn: "ทดสอบ โปรโมชั่น",
            imageLink:
                "https://images.unsplash.com/photo-1580828343064-fde4fc206bc6?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
            popUpTitle: "ทดสอบ โปรโมชั่น",
            popUpDescription: "ทดสอบ โปรโมชั่น Edupluz 2025",
            image:
                "https://images.unsplash.com/photo-1580828343064-fde4fc206bc6?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"));
  } catch (e) {
    Logger().e(e);
    rethrow;
  }
}
