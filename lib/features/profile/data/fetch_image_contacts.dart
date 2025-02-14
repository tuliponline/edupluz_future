import 'package:edupluz_future/core/services/api/directus_api_service.dart';
import 'package:logger/logger.dart';

Future<String> fetchImageContacts(String imgId) async {
  try {
    String imgUrl = await DirectusApiService().getAssets(path: imgId);
    return imgUrl;
  } catch (e) {
    Logger().e(e);
    rethrow;
  }
}
