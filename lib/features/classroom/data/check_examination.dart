import 'dart:convert';

import 'package:edupluz_future/core/constant/api_path.dart';
import 'package:edupluz_future/core/services/api/private_api_service.dart';
import 'package:edupluz_future/features/classroom/domain/examination_check_model.dart';

import 'package:logger/logger.dart';

Future<ExaminationCheckModel?> checkExamination(String key) async {
  try {
    // String path = "${ApiPath.examination}/check?key=$key";
    // final response = await PrivateApiService().get(path: path);
    // ExaminationCheckModel data = examinationCheckModelFromJson(response);
    // Logger().d("Check Examination: ${jsonEncode(data.data)}");
    // return data;
    return null;
  } catch (e) {
    Logger().e(e);
    return null;
  }
}
