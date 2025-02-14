import 'package:edupluz_future/core/constant/directus_path.dart';
import 'package:edupluz_future/core/services/api/directus_api_service.dart';
import 'package:edupluz_future/features/profile/domain/contacts_model.dart';
import 'package:logger/logger.dart';

Future<ContactsModel> fetchContacts() async {
  try {
    final responseData =
        await DirectusApiService().get(path: DirectusPath.contacts);
    return contactsModelFromJson(responseData);
  } catch (e) {
    Logger().e(e);
    rethrow;
  }
}
