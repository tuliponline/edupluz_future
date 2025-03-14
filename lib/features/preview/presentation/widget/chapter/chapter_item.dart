import 'package:edupluz_future/core/constant/app_size.dart';
import 'package:edupluz_future/core/models/courses/course_model.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/core/utili/format_duration.dart';
import 'package:edupluz_future/features/classroom/presentation/classroom_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class ChapterItem extends StatelessWidget {
  final Chapter chapter;
  final Lesson lesson;
  final CourseModel course;
  const ChapterItem(
      {super.key,
      required this.lesson,
      required this.chapter,
      required this.course});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (course.data.joined) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClassroomPage(
                  courseId: course.data.id,
                  chapterId: chapter.id,
                  lessonId: lesson.id),
            ),
          );
        } else if (lesson.isFree) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClassroomPage(
                  courseId: course.data.id,
                  chapterId: chapter.id,
                  lessonId: lesson.id,
                  isFree: lesson.isFree),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
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
                        lesson.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyLarge,
                      ),
                      const SizedBox(width: 8),
                      if (lesson.isFree)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 9.5, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            "ฟรี",
                            style: AppTextStyles.bodySmall
                                .copyWith(color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  formatDurationLesson(lesson.sequence),
                  style: AppTextStyles.bodySmall,
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
                lesson.isFree || course.data.joined
                    ? LucideIcons.play
                    : LucideIcons.lock,
                color: Colors.white,
                size: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
