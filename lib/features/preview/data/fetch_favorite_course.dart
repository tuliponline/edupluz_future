// ignore_for_file: use_build_context_synchronously

import 'package:edupluz_future/core/constant/api_path.dart';
import 'package:edupluz_future/core/services/api/private_api_service.dart';

import 'package:flutter/material.dart';

fetchFavoriteCourse(BuildContext context,
    {required String courseId, required bool isFavorite}) async {
  String finalPath = "${ApiPath.saveCourses}/$courseId";

  // if (isFavorite) {
  //   if (await PrivateApiService().delete(path: finalPath, body: {})) {
  //     toast(context, text: "ลบออกจากรายการที่บันทึกแล้ว");
  //   }
  // } else {
  //   if (await PrivateApiService().post(path: finalPath, body: {})) {
  //     toast(context, text: "เพิ่มในรายการที่บันทึกแล้ว");
  //   }
  // }
}
