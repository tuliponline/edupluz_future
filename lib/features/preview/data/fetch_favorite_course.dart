// ignore_for_file: use_build_context_synchronously

import 'package:edupluz_future/core/constant/api_path.dart';
import 'package:edupluz_future/core/enums/enum_language.dart';
import 'package:edupluz_future/core/services/api/private_api_service.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/core/widgets/toast/snack_bar.dart';

import 'package:flutter/material.dart';

fetchFavoriteCourse(BuildContext context,
    {required String courseId, required bool isFavorite}) async {
  if (isFavorite) {
    String finalPath = "${ApiPath.courseFavorites}/course/$courseId";
    if (await PrivateApiService().delete(path: finalPath, id: courseId)) {
      toast(context,
          text: "ลบออกจากรายการที่บันทึกแล้ว",
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary));
    }
  } else {
    String finalPath = ApiPath.courseFavorites;
    await PrivateApiService().post(
        path: finalPath,
        language: LanguageEnum.th,
        body: {"language": "th", "course_id": courseId});
    toast(context,
        text: "เพิ่มในรายการที่บันทึกแล้ว",
        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary));
  }
}
