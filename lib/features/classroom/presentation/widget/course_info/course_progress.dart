import 'package:edupluz_future/core/models/courses/course_model.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/core/utili/format_duration.dart';
import 'package:flutter/material.dart';

class CourseProgress extends StatelessWidget {
  final CourseModel course;
  const CourseProgress({super.key, required this.course});

  int _findTotalLesson() {
    int total = 0;
    for (var chapter in course.chapters) {
      total += chapter.lessons.length;
    }
    return total;
  }

  int _findCourseWatched() {
    int watched = 0;
    for (var chapter in course.chapters) {
      for (var lesson in chapter.lessons) {
        watched += lesson.watched ? 1 : 0;
      }
    }
    return watched;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Wrap(
        spacing: 16,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 60,
                width: 60,
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                  backgroundColor:
                      AppColors.iconDisabled.withValues(alpha: 0.3),
                  value: course.progress / 100,
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    " ${_findCourseWatched()} / ${_findTotalLesson()}",
                    style: AppTextStyles.bodyMedium,
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ความคืบหน้า",
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "${formatDuration(course.duration)} | ${_findTotalLesson()} บทเรียน",
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
