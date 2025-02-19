import 'package:edupluz_future/core/constant/api_path.dart';
import 'package:edupluz_future/core/services/api/private_api_service.dart';
import 'package:edupluz_future/features/classroom/domain/examination_key_model.dart';
import 'package:logger/logger.dart';

Future<ExaminationKeyModel?> getExaminationKey(String courseId) async {
  try {
    String path = "${ApiPath.examination}/$courseId/key";
    final response = await PrivateApiService().get(path: path);
    ExaminationKeyModel data = examinationKeyModelFromJson(response);

    return data;
  } catch (e) {
    Logger().e(e);
    return null;
  }
}
