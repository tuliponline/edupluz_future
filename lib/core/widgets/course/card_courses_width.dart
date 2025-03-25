import 'package:cached_network_image/cached_network_image.dart';
import 'package:edupluz_future/core/models/courses/courses_model.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/core/utili/format_duration.dart';
import 'package:edupluz_future/features/preview/presentation/preview_screen.dart';
import 'package:flutter/material.dart';

class CardCoursesWidth extends StatelessWidget {
  final Item course;
  const CardCoursesWidth({
    Key? key,
    required this.course,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    int lessonsCount = 0;
    course.chapters.forEach((element) {
      element.lessons.forEach((element) {
        lessonsCount++;
      });
    });

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PreviewPage(courseId: course.id)));
      },
      child: Container(
        // height: 200,
        padding: const EdgeInsets.all(8),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: AppColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 96,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: CachedNetworkImage(
                    imageUrl: course.thumbnail.horizontal,
                    placeholder: (context, url) =>
                        Container(height: 130, width: 230, color: Colors.black),
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
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.title,
                        style: AppTextStyles.bodyMedium.copyWith(
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                            '${formatDuration(course.rating.toInt())} ${lessonsCount == 0 ? "" : "| $lessonsCount บทเรียน"}',
                            style: AppTextStyles.bodySmall.copyWith(
                                overflow: TextOverflow.ellipsis,
                                color: AppColors.textPrimary)),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          '#${course.categories.isNotEmpty ? course.categories[0].name : ""}',
                          style: AppTextStyles.bodySmall.copyWith(
                              overflow: TextOverflow.ellipsis,
                              color: AppColors.textPrimary),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    "${course.instructor.firstName} ${course.instructor.lastName}",
                    style: AppTextStyles.bodySmall.copyWith(
                        overflow: TextOverflow.ellipsis,
                        color: AppColors.textPrimary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
