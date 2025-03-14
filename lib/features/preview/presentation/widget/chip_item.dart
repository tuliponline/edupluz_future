import 'dart:io';

import 'package:edupluz_future/core/models/courses/course_model.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/core/utili/format_duration.dart';
import 'package:edupluz_future/core/widgets/toast/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class ChipItem extends StatelessWidget {
  final CourseModel course;
  final Function onTapFavorite;
  const ChipItem(
      {super.key, required this.course, required this.onTapFavorite});

  int _findTotalLesson() {
    int total = 0;
    for (var chapter in course.data.chapters) {
      total += chapter.lessons.length;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(999),
          ),
          child: IntrinsicWidth(
            child: Row(
              children: [
                const Icon(
                  LucideIcons.clock,
                  color: AppColors.primary,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  formatDuration(course.data.chapters.length),
                  style: AppTextStyles.bodySmall
                      .copyWith(color: AppColors.primary),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(999),
          ),
          child: IntrinsicWidth(
            child: Row(
              children: [
                const Icon(
                  LucideIcons.book_open,
                  color: AppColors.primary,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  "${_findTotalLesson()} บทเรียน",
                  style: AppTextStyles.bodySmall
                      .copyWith(color: AppColors.primary),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            onTapFavorite();
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.2),
            ),
            child: Icon(
              course.data.favorited ? Icons.bookmark : Icons.bookmark_outline,
              color: course.data.favorited
                  ? AppColors.primary
                  : AppColors.textSecondary,
              size: 16,
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            String url = "https://edupluz.com/preview/${course.data.slug}";
            await Clipboard.setData(ClipboardData(text: url));
            if (Platform.isIOS) {
              // ignore: use_build_context_synchronously
              toast(context, text: "คัดลอกไปยังคลิปบอร์ดแล้ว");
            }
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.2),
            ),
            child: const Icon(
              LucideIcons.share_2,
              color: AppColors.primary,
              size: 16,
            ),
          ),
        ),
      ],
    );
  }
}
