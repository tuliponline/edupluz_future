import 'dart:typed_data';

import 'package:better_player_plus/better_player_plus.dart';
import 'package:edupluz_future/core/app/version_service.dart';
import 'package:edupluz_future/core/models/courses/course_model.dart';
import 'package:edupluz_future/core/providers/version/version_provider.dart';
import 'package:edupluz_future/core/services/cer_service.dart';
import 'package:edupluz_future/core/services/courses/fetch_course_by_id.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/core/widgets/better_player/better_player_screen.dart';
import 'package:edupluz_future/core/widgets/dialogs/info_dialog.dart';
import 'package:edupluz_future/features/classroom/data/check_examination.dart';
import 'package:edupluz_future/features/classroom/data/fetch_content_with_video.dart';
import 'package:edupluz_future/features/classroom/data/fetch_course_file.dart';
import 'package:edupluz_future/features/classroom/data/get_exam_url.dart';
import 'package:edupluz_future/features/classroom/data/get_examination_key.dart';
import 'package:edupluz_future/features/classroom/data/update_progress.dart';
import 'package:edupluz_future/features/classroom/domain/examination_check_model.dart';
import 'package:edupluz_future/features/classroom/domain/examination_key_model.dart';
import 'package:edupluz_future/features/classroom/domain/video_content_model.dart';
import 'package:edupluz_future/features/classroom/presentation/exam_screen.dart';
import 'package:edupluz_future/features/classroom/presentation/widget/course_info/modal_course_content.dart';
import 'package:edupluz_future/features/classroom/presentation/widget/download_file.dart';
import 'package:edupluz_future/features/classroom/presentation/widget/pdf_view.dart';
import 'package:edupluz_future/features/classroom/provider/web_socket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class ClassroomPage extends ConsumerStatefulWidget {
  final String courseId;
  final String chapterId;
  final String lessonId;
  final bool isFree;
  const ClassroomPage(
      {super.key,
      required this.courseId,
      required this.chapterId,
      required this.lessonId,
      this.isFree = false});

  @override
  ConsumerState<ClassroomPage> createState() => _ClassroomPageState();
}

class _ClassroomPageState extends ConsumerState<ClassroomPage> {
  CourseModel? course;

  String chapterId = "";
  String lessonId = "";
  int chapterIndex = 0;
  int lessonIndex = 0;
  bool isLoading = false;
  ExaminationKeyModel? examinationKey;
  ExaminationCheckModel? examinationCheck;

  late BetterPlayerController betterPlayerController;
  bool isVideoEnded = false;

  _fetchCourseById() async {
    if (widget.courseId != "") {
      course = await fetchCourseById(id: widget.courseId);
    }

    setState(() {});
  }

  _findIndexAtId() {
    course!.data.chapters.asMap().forEach((i, chapter) {
      if (chapter.id == chapterId) {
        chapterIndex = i;
      }

      chapter.lessons.asMap().forEach((j, lesson) {
        if (lesson.id == lessonId) {
          lessonIndex = j;
        }
      });
    });

    setState(() {});
  }

  _initData() async {
    if (chapterId == "" && lessonId == "") {
      chapterId = widget.chapterId;
      lessonId = widget.lessonId;
    }
    await _fetchCourseById();
    await _findIndexAtId();
  }

  _nextLesson() async {
    EasyLoading.dismiss();
    Logger().d("oldChapterId ${chapterId}");
    Logger().d("oldLessonId ${lessonId}");
    if (lessonIndex < course!.data.chapters[chapterIndex].lessons.length - 1) {
      setState(() {
        chapterId = course!.data.chapters[chapterIndex].id;
        lessonId =
            course!.data.chapters[chapterIndex].lessons[lessonIndex + 1].id;

        _findIndexAtId();
      });
    } else if (chapterIndex < course!.data.chapters.length - 1) {
      setState(() {
        chapterId = course!.data.chapters[chapterIndex + 1].id;
        lessonId = course!.data.chapters[chapterIndex + 1].lessons[0].id;

        _findIndexAtId();
      });
    }

    Logger().d("newChapterId ${chapterId}");
    Logger().d("newLessonId ${lessonId}");
    if (course!.data.chapters[chapterIndex].lessons[lessonIndex].type ==
        "VIDEO") {
      isVideoEnded = false;
      betterPlayerController.setupDataSource(
        BetterPlayerDataSource(
          BetterPlayerDataSourceType.network,
          course!.data.chapters[chapterIndex].lessons[lessonIndex].content.video
                  ?.url ??
              "",
        ),
      );
    } else {
      isVideoEnded = false;

      launchUrl(Uri.parse(course!.data.chapters[chapterIndex]
              .lessons[lessonIndex].content.file?.url ??
          ""));
    }
  }

  @override
  void initState() {
    _initData();
    super.initState();
  }

  @override
  void dispose() {
    betterPlayerController.dispose();
    super.dispose();
  }

  _eventListener() {
    betterPlayerController.addEventsListener((event) async {});
  }

  @override
  Widget build(BuildContext context) {
    VersionStatus? versionStatus = ref.watch(versionProvider);
    return PopScope(
      onPopInvoked: (didPop) async {
        if (didPop) {
          ref.read(webSocketServiceProvider).dispose();
        }
      },
      child: course == null || isLoading
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                automaticallyImplyLeading: false,
                backgroundColor: AppColors.background,
                title: Text(
                  course!.data.title.length > 30
                      ? "${course!.data.title.substring(0, 30)}..."
                      : course!.data.title,
                  style: AppTextStyles.h4,
                ),
              ),
              body: LayoutBuilder(builder: (context, constraints) {
                return SingleChildScrollView(
                  child: SizedBox(
                    height: constraints.maxHeight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: BetterPlayerScreen(
                            url: course!.data.chapters[chapterIndex]
                                    .lessons[lessonIndex].content.video?.url ??
                                "",
                            betterPlayerController: (betterPlayerController) {
                              this.betterPlayerController =
                                  betterPlayerController;
                              _eventListener();
                            },
                            onVideoEnded: () async {
                              Logger().d("onVideoEnded");
                              if (!isVideoEnded) {
                                Logger().d("onVideoEnded isVideoEnded");
                                EasyLoading.show();
                                Duration lessonDuration = betterPlayerController
                                        .videoPlayerController!
                                        .value
                                        .duration ??
                                    Duration.zero;
                                isVideoEnded = true;

                                await Future.delayed(const Duration(seconds: 3),
                                    () {
                                  _nextLesson();
                                });
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Text(
                                    course!.data.chapters[chapterIndex]
                                        .lessons[lessonIndex].name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.h4),
                              ),
                              if (course!.data.chapters[chapterIndex]
                                          .lessons[lessonIndex].type ==
                                      "FILE" &&
                                  !widget.isFree)
                                const SizedBox(width: 8),
                              if (course!.data.chapters[chapterIndex]
                                          .lessons[lessonIndex].type ==
                                      "FILE" &&
                                  !widget.isFree)
                                DownloadFile(
                                    url: course!
                                            .data
                                            .chapters[chapterIndex]
                                            .lessons[lessonIndex]
                                            .content
                                            .file
                                            ?.url ??
                                        ""),
                            ],
                          ),
                        ),
                        if (course!.data.chapters[chapterIndex]
                                    .lessons[lessonIndex].type ==
                                "FILE" &&
                            !widget.isFree)
                          PdfView(
                              pdfCourseFile: course!.data.chapters[chapterIndex]
                                      .lessons[lessonIndex].content.file?.url ??
                                  ""),
                        if (course!.data.chapters[chapterIndex]
                                .lessons[lessonIndex].type ==
                            "VIDEO")
                          const Spacer(),
                        if (versionStatus == VersionStatus.higher ||
                            course!.data.isFree ||
                            widget.isFree ||
                            course!.data.joined)
                          CourseContent(
                            onCerTap: () async {
                              EasyLoading.show();

                              if (examinationCheck != null &&
                                  examinationCheck!.data.passed) {
                                Uint8List cerData = await CerService()
                                    .downloadCer(examinationKey!.data.key);
                                await CerService().saveCertificate(cerData);

                                EasyLoading.dismiss();
                              } else {
                                EasyLoading.dismiss();
                                await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return InfoDialog(
                                        testCenter: true,
                                        callback: (value) {
                                          Navigator.pop(context);
                                        },
                                        title: "ไม่สามารถดาวน์โหลดได้",
                                        detail: "คุณต้องทำแบบทดสอบให้ผ่านก่อน",
                                      );
                                    });
                              }
                            },
                            onExamTap: () async {},
                            hasExam: false,
                            course: course!,
                            lessonId: lessonId,
                            onLessonClick: (chapterId, lessonId) async {
                              Logger().d("onLessonClick On Classroom");
                              setState(() {
                                this.chapterId = chapterId;
                                this.lessonId = lessonId;
                              });

                              await _findIndexAtId();

                              if (course!.data.chapters[chapterIndex]
                                      .lessons[lessonIndex].type ==
                                  "VIDEO") {
                                String newVideoUrl = course!
                                        .data
                                        .chapters[chapterIndex]
                                        .lessons[lessonIndex]
                                        .content
                                        .video
                                        ?.url ??
                                    "";
                                if (newVideoUrl.isNotEmpty) {
                                  betterPlayerController.setupDataSource(
                                    BetterPlayerDataSource(
                                      BetterPlayerDataSourceType.network,
                                      newVideoUrl,
                                    ),
                                  );
                                }
                              } else {
                                EasyLoading.show();
                                try {
                                  Uri uri = Uri.parse(course!
                                          .data
                                          .chapters[chapterIndex]
                                          .lessons[lessonIndex]
                                          .content
                                          .file
                                          ?.url ??
                                      "");
                                  await launchUrl(uri);
                                } catch (e) {
                                  EasyLoading.dismiss();
                                  EasyLoading.showError(e.toString());
                                } finally {
                                  EasyLoading.dismiss();
                                }
                              }
                            },
                          ),
                      ],
                    ),
                  ),
                );
              }),
            ),
    );
  }
}
