import 'dart:io';

import 'package:edupluz_future/core/models/auth/meModel.dart';
import 'package:edupluz_future/core/models/courses/course_model.dart';
import 'package:edupluz_future/core/providers/auth/user_me_provider.dart';
import 'package:edupluz_future/features/classroom/data/get_device_id_service.dart';
import 'package:edupluz_future/features/classroom/data/get_ip_address_service.dart';
import 'package:edupluz_future/features/classroom/data/get_session_id_service.dart';
import 'package:edupluz_future/features/classroom/data/web_socket_service.dart';
import 'package:edupluz_future/features/classroom/domain/metric_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

updateProgress({
  required WidgetRef ref,
  required Duration progress,
  required betterPlayerController,
  required CourseModel course,
  required int chapterIndex,
  required int lessonIndex,
}) async {
  // final MeModel? meData = ref.watch(userMeProvider);
  // String deviceId = await getDeviceId(ref);
  // String sessionId = await getSessionId(ref);
  // String ipAddress = await getIpAddress(ref);

  // Duration totalDuration =
  //     betterPlayerController.videoPlayerController!.value.duration ??
  //         Duration.zero;
  // // Calculate playback percentage
  // double playbackPercentage =
  //     (progress.inMilliseconds / totalDuration.inMilliseconds) * 100;
  // Logger().d("playbackPercentage: $playbackPercentage");

  // MetricModel progressData = MetricModel(
  //     event: 'metric',
  //     metric: Metric(
  //       sessionId: sessionId,
  //       eventType: "progress",
  //       userId: meData?.id ?? "",
  //       deviceId: deviceId,
  //       ipAddress: ipAddress,
  //       city: '',
  //       country: 'Thailand',
  //       contentId: course.chapters[chapterIndex].lessons[lessonIndex].id,
  //       contentTitle: course.chapters[chapterIndex].lessons[lessonIndex].name,
  //       streamType: Platform.isIOS ? 'hls' : 'dash',
  //       streamingFormat: Platform.isIOS ? "fairplay" : "widevine",
  //       qualityResolution:
  //           "${betterPlayerController.videoPlayerController?.value.size?.width ?? 0.00}x${betterPlayerController.videoPlayerController?.value.size?.height ?? 0.00}",
  //       encodedBitrate: 664000,
  //       bufferLength: betterPlayerController
  //           .videoPlayerController!.value.buffered.length
  //           .toDouble(),
  //       duration: betterPlayerController
  //               .videoPlayerController?.value.duration?.inSeconds
  //               .toDouble() ??
  //           0.00,
  //       volume: (betterPlayerController.videoPlayerController!.value.volume)
  //           .toInt(),
  //       muted: betterPlayerController.videoPlayerController!.value.volume == 0,
  //       playbackRate:
  //           betterPlayerController.videoPlayerController!.value.speed.toInt(),
  //       playbackPercentage:
  //           playbackPercentage.isNaN ? 0.00 : playbackPercentage,
  //       playbackCurrentTime: betterPlayerController
  //           .videoPlayerController!.value.position.inSeconds
  //           .toDouble(),
  //       measuredThroughput: 0,
  //       topBitrate: 664000,
  //       deviceModel: Platform.isIOS ? 'iPhone' : 'Android',
  //       deviceBrand: Platform.isIOS ? 'iPhone' : 'Android',
  //       browser: Platform.isIOS ? 'iPhone' : 'Android',
  //       browserVersion: "",
  //       operatingSystem: Platform.isIOS ? 'iPhone' : 'Android',
  //       operatingSystemVersion: Platform.isIOS ? 'iPhone' : 'Android',
  //       extraParams: ExtraParams(
  //         courseId: course.id,
  //         chapterId: course.chapters[chapterIndex].id,
  //         lessonId: course.chapters[chapterIndex].lessons[lessonIndex].id,
  //       ),
  //     ));

  // WebSocketService().sendProgress(progressData);
}
