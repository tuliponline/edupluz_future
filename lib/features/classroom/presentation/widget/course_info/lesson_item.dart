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
  final bool isPlaying;
  const LessonItem(
      {super.key,
      required this.course,
      this.lesson,
      required this.isHighlighted,
      this.isCer = false,
      this.isExam = false,
      this.isPlaying = false});

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
                : isPlaying
                    ? AppColors.primary.withOpacity(0.1)
                    : isHighlighted
                        ? AppColors.cardBackground
                        : AppColors.cardBackground,
            borderRadius: BorderRadius.circular(12),
          ),
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
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (lesson?.isFree ?? false)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 9.5, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Text(
                              "ดูแล้ว",
                              style: AppTextStyles.bodySmall
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (lesson!.type == "VIDEO")
                    Text(
                      (isExam)
                          ? "ความคืบหน้าการเรียน ${course.data.chapters.length} %"
                          : (isCer)
                              ? ""
                              : formatDurationLesson(
                                  lesson!.content.video?.durationMs ?? 0),
                      style: AppTextStyles.bodyMedium,
                    ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  (isExam && !isCer)
                      ? LucideIcons.book_check
                      : (lesson!.type == "FILE")
                          ? LucideIcons.download
                          : (lesson!.type == "EXAM")
                              ? LucideIcons.book_check
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
