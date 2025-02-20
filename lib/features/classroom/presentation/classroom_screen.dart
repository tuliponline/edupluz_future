import 'dart:typed_data';

import 'package:better_player_plus/better_player_plus.dart';
import 'package:edupluz_future/core/models/courses/course_model.dart';
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
  VideoContentModel? videoContent;
  String chapterId = "";
  String lessonId = "";
  int chapterIndex = 0;
  int lessonIndex = 0;
  bool isLoading = false;
  String? pdfCourseFile;
  ExaminationKeyModel? examinationKey;
  ExaminationCheckModel? examinationCheck;

  late BetterPlayerController betterPlayerController;
  bool isVideoEnded = false;

  _fetchCourseById() async {
    if (widget.courseId != "") {
      course = await fetchCourseById(id: widget.courseId);
      Logger().d("course Progress: ${course!.progress}");
    }

    setState(() {});
  }

  _fetchCourseContentWithVideo() async {
    setState(() {
      isLoading = true;
    });

    if (chapterId == "" && lessonId == "") {
      chapterId = widget.chapterId;
      lessonId = widget.lessonId;
    }

    videoContent = await fetchContentWithVideo(
        widget.courseId, chapterId, lessonId,
        isFree: widget.isFree);

    setState(() {
      isLoading = false;
    });

    setState(() {});
  }

  _fetchCourseFile() async {
    setState(() {
      isLoading = true;
    });

    pdfCourseFile = await fetchCourseFile(course?.slug ?? "");

    setState(() {
      isLoading = false;
    });
  }

  _findIndexAtId() {
    course!.chapters.asMap().forEach((i, chapter) {
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

  _fetchExaminationKey() async {
    examinationKey = await getExaminationKey(widget.courseId);
    Logger().d("get_examination_key: $examinationKey");
    if (examinationKey != null) {
      examinationCheck = await checkExamination(examinationKey!.data.key);
    }
    setState(() {});
  }

  _goToExam() async {
    if (examinationKey != null &&
        examinationCheck != null &&
        course!.progress >= 100) {
      if (!examinationCheck!.data.passed == false || true) {
        EasyLoading.show();
        Logger().i("ทำแบบทดสอบ");
        String examUrl = await getExamUrl(examinationKey!.data.key);
        EasyLoading.dismiss();
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ExamScreen(
                course: course!,
                examUrl: examUrl,
                examKey: examinationKey!.data.key);
          },
        ));
      }
    }
  }

  _initData() async {
    await _fetchCourseById();
    await _fetchCourseContentWithVideo();
    await _findIndexAtId();
    await _fetchCourseFile();
    await _fetchExaminationKey();
  }

  _nextLesson() async {
    EasyLoading.dismiss();
    if (lessonIndex < course!.chapters[chapterIndex].lessons.length - 1) {
      setState(() {
        chapterId = course!.chapters[chapterIndex].id;
        lessonId = course!.chapters[chapterIndex].lessons[lessonIndex + 1].id;
        _fetchCourseContentWithVideo();
        _findIndexAtId();
      });
    } else if (chapterIndex < course!.chapters.length - 1) {
      setState(() {
        chapterId = course!.chapters[chapterIndex + 1].id;
        lessonId = course!.chapters[chapterIndex + 1].lessons[0].id;
        _fetchCourseContentWithVideo();
        _findIndexAtId();
      });
    } else {
      Logger().d("course progress: ${course!.progress}");
      Logger().d("End of course");

      _goToExam();

      // setState(() {
      //   chapterId = course!.chapters[0].id;
      //   lessonId = course!.chapters[0].lessons[0].id;
      //   _fetchCourseContentWithVideo();
      //   _findIndexAtId();
      // });
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
    betterPlayerController.addEventsListener((event) async {
      if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
        isVideoEnded = false;
      }
      if (event.betterPlayerEventType == BetterPlayerEventType.finished) {
        if (!isVideoEnded) {
          EasyLoading.show();
          Duration lessonDuration =
              betterPlayerController.videoPlayerController!.value.duration ??
                  Duration.zero;
          isVideoEnded = true;
          Logger().d("lessonDuration ${lessonDuration.inSeconds}");
          await updateProgress(
            ref: ref,
            progress: lessonDuration,
            betterPlayerController: betterPlayerController,
            course: course!,
            chapterIndex: chapterIndex,
            lessonIndex: lessonIndex,
          );
          await _fetchCourseById();
          await Future.delayed(const Duration(seconds: 3), () {
            _nextLesson();
          });
        }
      }
      if (event.betterPlayerEventType == BetterPlayerEventType.progress) {
        Duration lessonDuration =
            betterPlayerController.videoPlayerController!.value.duration ??
                Duration.zero;
        double progress = ((betterPlayerController
                    .videoPlayerController!.value.position.inSeconds /
                lessonDuration.inSeconds) *
            100);

        if (progress >= 90) {
          if (!isVideoEnded) {
            await updateProgress(
              ref: ref,
              progress: lessonDuration,
              betterPlayerController: betterPlayerController,
              course: course!,
              chapterIndex: chapterIndex,
              lessonIndex: lessonIndex,
            );
          }
        } else {
          Duration currentProgress =
              betterPlayerController.videoPlayerController!.value.position;

          await updateProgress(
            ref: ref,
            progress: currentProgress,
            betterPlayerController: betterPlayerController,
            course: course!,
            chapterIndex: chapterIndex,
            lessonIndex: lessonIndex,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async {
        if (didPop) {
          ref.watch(webSocketServiceProvider).dispose();
        }
      },
      child: course == null || videoContent == null || isLoading
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
                  "คอร์ส",
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
                            url: videoContent?.url ?? "",
                            betterPlayerController: (betterPlayerController) {
                              this.betterPlayerController =
                                  betterPlayerController;
                              _eventListener();
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
                                child: Text(videoContent?.name ?? "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.h4),
                              ),
                              if (pdfCourseFile != null && !widget.isFree)
                                const SizedBox(width: 8),
                              if (pdfCourseFile != null && !widget.isFree)
                                DownloadFile(slug: course?.slug ?? ""),
                            ],
                          ),
                        ),
                        if (pdfCourseFile != null && !widget.isFree)
                          PdfView(pdfCourseFile: pdfCourseFile ?? ""),
                        if (pdfCourseFile == null) const Spacer(),
                        if (!widget.isFree || course!.joined)
                          CourseContent(
                            onCerTap: () async {
                              EasyLoading.show();
                              await _fetchExaminationKey();
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
                            onExamTap: () async {
                              EasyLoading.show();
                              await _fetchExaminationKey();
                              EasyLoading.dismiss();
                              if (course!.progress < 100 ||
                                  examinationCheck!.data.passed) {
                                Logger().e("ความคืบหน้าต้องครบ 100%");
                                await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return InfoDialog(
                                        testCenter: true,
                                        callback: (value) {
                                          Navigator.pop(context);
                                        },
                                        title: examinationCheck!.data.passed
                                            ? "คุณทำแบบทดสอบแล้ว"
                                            : "ไม่สามารถทำแบบทดสอบได้",
                                        detail: examinationCheck!.data.passed
                                            ? "คุณได้ทำแบบทดสอบผ่านแล้ว ไม่สามารถทำแบบทดสอบอีกได้"
                                            : "ความคืบหน้าการเรียนต้องครบ 100%",
                                      );
                                    });
                              } else {
                                _goToExam();
                              }
                            },
                            hasExam: examinationKey != null &&
                                (examinationCheck != null),
                            course: course!,
                            lessonId: lessonId,
                            onLessonClick: (chapterId, lessonId) async {
                              setState(() {
                                this.chapterId = chapterId;
                                this.lessonId = lessonId;
                              });
                              await _fetchCourseContentWithVideo();
                              await _findIndexAtId();
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
