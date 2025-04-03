import 'dart:typed_data';

import 'package:better_player_plus/better_player_plus.dart';
import 'package:edupluz_future/core/app/version_service.dart';
import 'package:edupluz_future/core/models/courses/course_model.dart';
import 'package:edupluz_future/core/models/courses/exam_model.dart' as exam;
import 'package:edupluz_future/core/models/courses/get_exam_key_200_response.dart';
import 'package:edupluz_future/core/providers/version/version_provider.dart';
import 'package:edupluz_future/core/services/api/private_api_service.dart';
import 'package:edupluz_future/core/services/cer_service.dart';
import 'package:edupluz_future/core/services/courses/fetch_course_by_id.dart';
import 'package:edupluz_future/core/services/exam/exam_services.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/core/widgets/better_player/better_player_screen.dart';
import 'package:edupluz_future/core/widgets/dialogs/info_dialog.dart';
import 'package:edupluz_future/features/classroom/domain/examination_check_model.dart';
import 'package:edupluz_future/features/classroom/domain/examination_key_model.dart';
import 'package:edupluz_future/features/classroom/presentation/widget/course_info/modal_course_content.dart';
import 'package:edupluz_future/features/classroom/presentation/widget/download_file.dart';
import 'package:edupluz_future/features/classroom/presentation/widget/exam_widget.dart';
import 'package:edupluz_future/features/classroom/presentation/widget/course_info/pdf_view_widget.dart';
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

  late BetterPlayerController? betterPlayerController;
  bool isVideoEnded = false;

  bool isExam = false;
  exam.ExamModel? examData;
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
      String newVideoUrl = course!.data.chapters[chapterIndex]
              .lessons[lessonIndex].content.video?.url ??
          "";
      isVideoEnded = false;
      betterPlayerController!.setupDataSource(
        BetterPlayerDataSource(
          BetterPlayerDataSourceType.network,
          newVideoUrl,
        ),
      );

      setState(() {});
    } else if (course!.data.chapters[chapterIndex].lessons[lessonIndex].type ==
        "EXAM") {
      isVideoEnded = false;
      _goExam();
    } else {
      isVideoEnded = false;
      setState(() {
        isExam = false;
      });
    }
  }

  @override
  void initState() {
    betterPlayerController = null;
    _initData();
    super.initState();
  }

  @override
  void dispose() {
    betterPlayerController?.dispose();
    super.dispose();
  }

  _eventListener() {
    betterPlayerController?.addEventsListener((event) async {});
  }

  _goExam() async {
    EasyLoading.show();
    var examResponse = await ExamServices().getExam(
      lessonId: lessonId,
    );
    EasyLoading.dismiss();
    if (examResponse.data.items.isNotEmpty &&
        examResponse.data.items.length > 0) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("คุณได้ทำแบบทดสอบแล้ว", style: AppTextStyles.h4),
          content: Text("แบบทดสอบนี้จะไม่สามารถทำได้อีก",
              style: AppTextStyles.bodyLarge),
          actions: [
            TextButton(
                onPressed: () async {
                  try {
                    EasyLoading.show();
                    GetExamKey200Response response =
                        await ExamServices().getExamKey(
                      ref: ref,
                      courseId: course!.data.id,
                      chapterId: course!.data.chapters[chapterIndex].id,
                      lessonId: course!
                          .data.chapters[chapterIndex].lessons[lessonIndex].id,
                    );

                    Logger().d("response.data.key ${response.data.key}");
                    Uint8List cerData = await PrivateApiService()
                        .downloadCer(response.data.key);

                    await CerService().saveCertificate(cerData);
                    EasyLoading.showSuccess("ดาวน์โหลดใบรับรองสำเร็จ");
                  } catch (e) {
                    Logger().e(e);
                    EasyLoading.showError(
                        "เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง");
                  } finally {
                    EasyLoading.dismiss();
                  }
                },
                child: Text("ดาวน์โหลดใบรับรอง")),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text("ตกลง"),
            ),
          ],
        ),
      );
      return;
    }

    var examString = (course!.data.chapters[chapterIndex]);
    Logger().d("examString $examString");

    // Convert the exam data to ExamModel
    var sourceExam =
        course!.data.chapters[chapterIndex].lessons[lessonIndex].content.exam!;
    var convertedExam = exam.Exam(
      questions: sourceExam.questions
          .map((q) => exam.Question(
                id: q.id,
                title: q.title,
                choices: q.choices
                    .map((c) => exam.ChoiceElement(
                          id: c.id,
                          choice: exam.choiceEnumValues.map[c.choice]!,
                          title: c.title,
                          isCorrect: c.isCorrect,
                        ))
                    .toList(),
                sequence: q.sequence,
              ))
          .toList(),
    );

    var examModel = exam.ExamModel(
      id: course!.data.chapters[chapterIndex].lessons[lessonIndex].id,
      type: "EXAM",
      name: course!.data.chapters[chapterIndex].lessons[lessonIndex].name,
      isFree: course!.data.chapters[chapterIndex].lessons[lessonIndex].isFree,
      sequence: course!.data.chapters[chapterIndex].sequence,
      content: exam.Content(
        exam: convertedExam,
      ),
    );

    Logger()
        .d("Converted ExamModel: ${examModel.content.exam.questions.length}");

    setState(() {
      isExam = true;
      examData = examModel;
    });
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
                        if (course!.data.chapters[chapterIndex]
                                .lessons[lessonIndex].type ==
                            "FILE")
                          PdfView(
                            url: course!.data.chapters[chapterIndex]
                                    .lessons[lessonIndex].content.file?.url ??
                                "",
                          ),
                        if ((course!.data.chapters[chapterIndex]
                                    .lessons[lessonIndex].type ==
                                "EXAM" &&
                            examData != null))
                          ExamWidget(
                            exam: examData!,
                            courseId: course!.data.id,
                            chapterId: course!.data.chapters[chapterIndex].id,
                            lessonId: course!.data.chapters[chapterIndex]
                                .lessons[lessonIndex].id,
                          ),
                        if ((course!.data.chapters[chapterIndex]
                                .lessons[lessonIndex].type ==
                            "VIDEO"))
                          ClipRRect(
                            borderRadius: BorderRadius.circular(0),
                            child: BetterPlayerScreen(
                              url: course!
                                      .data
                                      .chapters[chapterIndex]
                                      .lessons[lessonIndex]
                                      .content
                                      .video
                                      ?.url ??
                                  "",
                              betterPlayerController: (controller) {
                                betterPlayerController = controller;
                                _eventListener();
                              },
                              onVideoEnded: () async {
                                Logger().d("onVideoEnded");
                                if (!isVideoEnded &&
                                    betterPlayerController != null) {
                                  Logger().d("onVideoEnded isVideoEnded");
                                  EasyLoading.show();
                                  Duration lessonDuration =
                                      betterPlayerController!
                                              .videoPlayerController
                                              ?.value
                                              .duration ??
                                          Duration.zero;
                                  isVideoEnded = true;

                                  await Future.delayed(
                                      const Duration(seconds: 3), () {
                                    _nextLesson();
                                  });
                                }
                              },
                            ),
                          ),
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
                                  Uint8List cerData = await PrivateApiService()
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
                                          detail:
                                              "คุณต้องทำแบบทดสอบให้ผ่านก่อน",
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
                                  setState(() {
                                    isExam = false;
                                  });

                                  // No need to dispose controller here since we already did it above
                                  String newVideoUrl = course!
                                          .data
                                          .chapters[chapterIndex]
                                          .lessons[lessonIndex]
                                          .content
                                          .video
                                          ?.url ??
                                      "";
                                  if (newVideoUrl.isEmpty) {
                                    EasyLoading.showError("Video URL is empty");
                                    String newVideoUrl = course!
                                            .data
                                            .chapters[chapterIndex]
                                            .lessons[lessonIndex]
                                            .content
                                            .video
                                            ?.url ??
                                        "";

                                    if (newVideoUrl.isNotEmpty) {
                                      betterPlayerController!.setupDataSource(
                                        BetterPlayerDataSource(
                                          BetterPlayerDataSourceType.network,
                                          newVideoUrl,
                                        ),
                                      );
                                    }
                                  } else {
                                    betterPlayerController!.setupDataSource(
                                      BetterPlayerDataSource(
                                        BetterPlayerDataSourceType.network,
                                        newVideoUrl,
                                      ),
                                    );
                                  }
                                } else if (course!.data.chapters[chapterIndex]
                                        .lessons[lessonIndex].type ==
                                    "EXAM") {
                                  _goExam();
                                } else {
                                  setState(() {
                                    isExam = false;
                                  });
                                }
                              }),
                      ],
                    ),
                  ),
                );
              }),
            ),
    );
  }
}
