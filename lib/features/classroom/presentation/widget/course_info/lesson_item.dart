import 'package:edupluz_future/core/constant/app_size.dart';
import 'package:edupluz_future/core/models/courses/course_model.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/core/utili/format_duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class LessonItem extends StatelessWidget {
  final CourseModel course;
  final Lesson? lesson;
  final bool isHighlighted;
  final bool isExam;
  final bool isCer;
  const LessonItem(
      {super.key,
      required this.course,
      this.lesson,
      required this.isHighlighted,
      this.isCer = false,
      this.isExam = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 6),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: (isExam)
                  ? AppColors.secondary
                  : isHighlighted
                      ? AppColors.primary
                      : lesson!.watched
                          ? AppColors.primary
                          : AppColors.secondary,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  blurRadius: 30,
                )
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: AppSize.screenWidth(context) * 0.65,
                    child: Wrap(
                      children: [
                        Text(
                          (isExam && !isCer)
                              ? "แบบทดสอบหลังเรียน"
                              : (isExam && isCer)
                                  ? "รับใบรับรอง"
                                  : lesson!.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodyMedium,
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    (isExam)
                        ? "ความคืบหน้าการเรียน ${course.progress} %"
                        : (isCer)
                            ? ""
                            : formatDuration(lesson!.duration),
                    style: AppTextStyles.displaySmall,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: AppColors.buttonSecondary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  (isExam && !isCer)
                      ? LucideIcons.book_check
                      : (isExam && isCer)
                          ? LucideIcons.download
                          : LucideIcons.play,
                  color: AppColors.background,
                  size: 16,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
