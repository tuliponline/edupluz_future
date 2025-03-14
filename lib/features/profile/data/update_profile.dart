import 'package:edupluz_future/core/constant/api_path.dart';
import 'package:edupluz_future/core/services/api/private_api_service.dart';
import 'package:edupluz_future/core/services/user/get_user_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

Future<bool> updateProfile({
  required String name,
  required String lastName,
  required String picture,
  required WidgetRef ref,
}) async {
  Logger().d("Fetching Courses");
  Logger().d("name: $name");
  Logger().d("lastName: $lastName");
  Logger().d("picture Base64: $picture");
  try {
    var returnData =
        await PrivateApiService().patch(path: ApiPath.users, body: {
      "first_name": name,
      "last_name": lastName,
      if (picture != "") "avatar": "data:image/png;base64,$picture"
    });
    await getUserService(ref);

    Logger().d(returnData);

    return true;
  } catch (e) {
    Logger().e(e);
    throw Exception(e);
  }
}
