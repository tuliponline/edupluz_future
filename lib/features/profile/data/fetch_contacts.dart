import 'package:edupluz_future/core/constant/directus_path.dart';
import 'package:edupluz_future/core/services/api/directus_api_service.dart';
import 'package:edupluz_future/features/profile/domain/contacts_model.dart';
import 'package:logger/logger.dart';

Future<ContactsModel> fetchContacts() async {
  try {
    // final responseData =
    //     await DirectusApiService().get(path: DirectusPath.contacts);
    // return contactsModelFromJson(responseData);
    return ContactsModel(
      data: [
        Datum(
          id: '1',
          name: 'Facebook Edupluz',
          status: 'active',
          icon:
              'https://cdn3.iconfinder.com/data/icons/picons-social/57/46-facebook-512.png',
          url: 'https://www.facebook.com/Edupluzofficial',
        ),
        Datum(
          id: '2',
          name: 'Line Edupluz',
          status: 'active',
          icon:
              'https://static-00.iconduck.com/assets.00/social-line-icon-2048x1958-zbkbki0t.png',
          url: 'https://line.me/R/ti/p/%40edupluz',
        ),
      ],
    );
  } catch (e) {
    Logger().e(e);
    rethrow;
  }
}
