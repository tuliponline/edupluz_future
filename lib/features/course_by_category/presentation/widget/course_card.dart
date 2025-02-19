import 'package:cached_network_image/cached_network_image.dart';
import 'package:edupluz_future/core/constant/app_size.dart';
import 'package:edupluz_future/core/models/courses/courses_model.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/core/utili/format_duration.dart';
import 'package:edupluz_future/features/preview/presentation/preview_screen.dart';

import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CourseCard extends StatelessWidget {
  final String courseId;
  final String courseName;
  final String? imageUrl;
  final int duration;
  final List<Chapter> chapters;
  final List<String> categories;
  final String instructorName;

  const CourseCard({
    super.key,
    required this.courseId,
    required this.courseName,
    required this.imageUrl,
    required this.duration,
    required this.chapters,
    required this.categories,
    required this.instructorName,
  });

  _findTotalLesson() {
    int total = 0;
    for (var chapter in chapters) {
      total += chapter.lessons.length;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PreviewPage(courseId: courseId)));
      },
      child: Container(
        width: AppSize.screenWidth(context),
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: SizedBox(
                height: 80,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: imageUrl == null
                      ? Container(
                          height: 130, width: 230, color: AppColors.cardShadow)
                      : CachedNetworkImage(
                          imageUrl: imageUrl ?? "",
                          placeholder: (context, url) => Skeletonizer(
                              child: Container(
                                  height: 80,
                                  width: 150,
                                  color: AppColors.cardShadow)),
                          errorWidget: (context, url, error) =>
                              const Center(child: Icon(Icons.error)),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    courseName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: AppTextStyles.bodyLarge,
                  ),
                  Text(
                    "${formatDuration(duration)} | ${_findTotalLesson()} บทเรียน",
                    style: AppTextStyles.bodySmall,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: categories.map((category) {
                      return Text(
                        "#$category",
                        style: AppTextStyles.bodySmall,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 8),
                  Text("ผู้สอน: $instructorName",
                      style: AppTextStyles.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
