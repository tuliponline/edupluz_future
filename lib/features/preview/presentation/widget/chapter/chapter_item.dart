import 'package:better_player_plus/better_player_plus.dart';
import 'package:edupluz_future/core/app/version_service.dart';
import 'package:edupluz_future/core/constant/app_size.dart';
import 'package:edupluz_future/core/models/courses/course_model.dart';
import 'package:edupluz_future/core/providers/version/version_provider.dart';
import 'package:edupluz_future/core/services/user/check_is_free.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/core/utili/format_duration.dart';
import 'package:edupluz_future/features/classroom/presentation/classroom_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class ChapterItem extends ConsumerWidget {
  final Chapter chapter;
  final Lesson lesson;
  final CourseModel course;
  final Function() playPause;
  const ChapterItem(
      {super.key,
      required this.lesson,
      required this.chapter,
      required this.course,
      required this.playPause});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final versionStatus = ref.watch(versionProvider);
    return GestureDetector(
      onTap: () async {
        playPause();
        if (versionStatus == VersionStatus.higher ||
            (checkIsFree(course: course) || lesson.isFree)) {
          if (lesson.type == "VIDEO") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ClassroomPage(
                    courseId: course.data.id,
                    chapterId: chapter.id,
                    lessonId: lesson.id,
                    isFree: versionStatus == VersionStatus.higher ||
                        checkIsFree(course: course) ||
                        lesson.isFree),
              ),
            );
          } else {
            EasyLoading.show();
            try {
              Uri uri = Uri.parse(lesson.content.file?.url ?? "");
              await launchUrl(uri);
            } catch (e) {
              EasyLoading.dismiss();
              EasyLoading.showError(e.toString());
            } finally {
              EasyLoading.dismiss();
            }
          }
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
                if (lesson.type == "VIDEO") const SizedBox(height: 4),
                if (lesson.type == "VIDEO")
                  Text(
                    formatDurationLesson(lesson.content.video?.durationMs ?? 0),
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
              child: (lesson.type == "VIDEO")
                  ? Icon(
                      versionStatus == VersionStatus.higher ||
                              checkIsFree(course: course) ||
                              lesson.isFree ||
                              course.data.joined
                          ? LucideIcons.play
                          : LucideIcons.lock,
                      color: Colors.white,
                      size: 16,
                    )
                  : (lesson.type == "VIDEO")
                      ? Icon(
                          versionStatus == VersionStatus.higher ||
                                  checkIsFree(course: course) ||
                                  lesson.isFree ||
                                  course.data.joined
                              ? LucideIcons.file
                              : LucideIcons.lock,
                          color: Colors.white,
                          size: 16,
                        )
                      : Icon(
                          versionStatus == VersionStatus.higher ||
                                  checkIsFree(course: course) ||
                                  lesson.isFree ||
                                  course.data.joined
                              ? LucideIcons.book_check
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
