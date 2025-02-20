import 'package:logger/logger.dart';

fetchImagePromotion(String imgId) async {
  try {
    // String imgUrl = await DirectusApiService().getAssets(path: imgId);
    // return imgUrl;
    return "https://images.unsplash.com/photo-1580828343064-fde4fc206bc6?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
  } catch (e) {
    Logger().e(e);
    rethrow;
  }
}
