import 'package:edupluz_future/core/models/courses/course_model.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/features/classroom/presentation/widget/course_info/lessons_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class CourseContent extends StatelessWidget {
  final CourseModel course;
  final String lessonId;
  final Function(String, String) onLessonClick;
  final Function() onExamTap;
  final Function() onCerTap;

  final bool hasExam;
  const CourseContent({
    super.key,
    required this.course,
    required this.onLessonClick,
    required this.onExamTap,
    required this.onCerTap,
    this.hasExam = false,
    required this.lessonId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return LessonsList(
                hasExam: hasExam,
                course: course,
                lessonId: lessonId,
                onExamTap: onExamTap,
                onCerTap: onCerTap,
                onLessonClick: onLessonClick,
              );
            });
      },
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        leading: const Icon(
          LucideIcons.list,
          color: AppColors.textPrimary,
        ),
        title: Text(
          "เนื้อหาคอร์ส",
          style: AppTextStyles.h4,
        ),
        trailing: const Icon(
          LucideIcons.chevron_up,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
