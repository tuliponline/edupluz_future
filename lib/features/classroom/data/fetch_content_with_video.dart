import 'dart:convert';
import 'dart:io';

import 'package:edupluz_future/core/constant/api_path.dart';
import 'package:edupluz_future/core/services/api/private_api_service.dart';
import 'package:edupluz_future/core/services/api/public_api_service.dart';
import 'package:edupluz_future/features/classroom/domain/video_content_model.dart';
import 'package:logger/logger.dart';

fetchContentWithVideo(String courseId, String chapterId, String lessonId,
    {bool isFree = false}) async {
  String drmType;
  String videoType;

  if (Platform.isIOS) {
    drmType = "FAIRPLAY";
    videoType = "HLS";
  } else {
    drmType = "WIDEVINE";
    videoType = "DASH";
  }

  try {
    // if (isFree) {
    //   String freePath =
    //       "${ApiPath.courses}/$courseId/chapters/$chapterId/lessons/$lessonId/preview?type=$videoType&drm_type=$drmType";

    //   final responseData = await PublicApiService().get(path: freePath);
    //   Map jsonData = jsonDecode(responseData)['data'];
    //   VideoContentModel contentData =
    //       videoContentModelFromJson(jsonEncode(jsonData));
    //   return contentData;
    // } else {
    //   String paidPath =
    //       "${ApiPath.courses}/$courseId/chapters/$chapterId/contents/$lessonId/video?type=$videoType&drm_type=$drmType";
    //   final responseData = await PrivateApiService().get(path: paidPath);
    //   Map jsonData = jsonDecode(responseData)['data'];
    //   VideoContentModel contentData =
    //       videoContentModelFromJson(jsonEncode(jsonData));

    //   return contentData;
    // }
    return VideoContentModel(
      id: "1",
      name: "Test",
      free: true,
      sequence: 1,
      url: "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
      license: "Test",
    );
  } catch (e) {
    Logger().e(e);
    rethrow;
  }
}
