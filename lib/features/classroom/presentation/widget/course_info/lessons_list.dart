import 'package:edupluz_future/core/models/courses/course_model.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/features/classroom/presentation/widget/course_info/course_progress.dart';
import 'package:edupluz_future/features/classroom/presentation/widget/course_info/lesson_item.dart';

import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:logger/logger.dart';

class LessonsList extends StatefulWidget {
  final CourseModel course;
  final String lessonId;
  final Function(String, String) onLessonClick;
  final Function() onExamTap;
  final Function() onCerTap;

  final bool hasExam;
  const LessonsList(
      {super.key,
      required this.course,
      required this.onLessonClick,
      required this.onExamTap,
      this.hasExam = false,
      required this.onCerTap,
      required this.lessonId});

  @override
  State<LessonsList> createState() => _LessonsListState();
}

class _LessonsListState extends State<LessonsList> {
  String chapterId = "";
  String lessonId = "";

  @override
  void initState() {
    lessonId = widget.lessonId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        color: AppColors.background,
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                LucideIcons.list,
                color: AppColors.textPrimary,
              ),
              title: Text(
                "เนื้อหาคอร์ส",
                style: AppTextStyles.h4,
              ),
              trailing: const Icon(
                LucideIcons.chevron_down,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const Divider(color: AppColors.background),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                // CourseProgress(course: widget.course),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: (widget.hasExam)
                      ? widget.course.data.chapters.length + 2
                      : widget.course.data.chapters.length,
                  itemBuilder: (context, i) {
                    // ignore: curly_braces_in_flow_control_structures
                    if (widget.hasExam &&
                        i == widget.course.data.chapters.length + 1) {
                      return GestureDetector(
                        onTap: () {
                          widget.onCerTap();
                        },
                        child: LessonItem(
                            course: widget.course,
                            isCer: true,
                            isExam: true,
                            isHighlighted: false),
                      );
                    }

                    if (widget.hasExam &&
                        i == widget.course.data.chapters.length) {
                      return GestureDetector(
                        onTap: () {
                          widget.onExamTap();
                        },
                        child: LessonItem(
                            course: widget.course,
                            isExam: true,
                            isHighlighted: false),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.course.data.chapters[i].lessons.length,
                      itemBuilder: (context, j) {
                        return GestureDetector(
                          onTap: () {
                            Logger().d("onLessonTap");
                            setState(() {
                              chapterId = widget.course.data.chapters[i].id;
                              lessonId =
                                  widget.course.data.chapters[i].lessons[j].id;
                            });
                            widget.onLessonClick(chapterId, lessonId);
                          },
                          child: LessonItem(
                            course: widget.course,
                            lesson: widget.course.data.chapters[i].lessons[j],
                            isHighlighted: lessonId ==
                                widget.course.data.chapters[i].lessons[j].id,
                            isPlaying: lessonId ==
                                widget.course.data.chapters[i].lessons[j].id,
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
