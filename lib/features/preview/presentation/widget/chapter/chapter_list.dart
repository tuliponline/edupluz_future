import 'package:better_player_plus/better_player_plus.dart';
import 'package:edupluz_future/core/app/version_service.dart';
import 'package:edupluz_future/core/models/courses/course_model.dart';
import 'package:edupluz_future/core/providers/version/version_provider.dart';
import 'package:edupluz_future/core/services/user/check_is_free.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/features/preview/presentation/widget/chapter/chapter_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChapterList extends ConsumerWidget {
  final List<Chapter> chapter;
  final CourseModel course;
  final Function() playPause;
  const ChapterList({
    super.key,
    required this.chapter,
    required this.course,
    required this.playPause,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final versionStatus = ref.watch(versionProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Course Preview", style: AppTextStyles.h4),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: chapter.length,
          itemBuilder: (context, i) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: chapter[i].lessons.length,
              itemBuilder: (context, j) {
                return Stack(
                  children: [
                    ChapterItem(
                      playPause: playPause,
                      chapter: chapter[i],
                      lesson: chapter[i].lessons[j],
                      course: course,
                    ),
                    if (versionStatus != VersionStatus.higher &&
                        !checkIsFree(course: course) &&
                        !chapter[i].lessons[j].isFree &&
                        !course.data.joined &&
                        !course.data.isFree)
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 6),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
