import 'package:cached_network_image/cached_network_image.dart';
import 'package:edupluz_future/core/models/courses/course_model.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/features/preview/presentation/widget/instructor_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class CourseInfo extends StatelessWidget {
  final CourseModel course;
  const CourseInfo({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showGeneralDialog(
          context: context,
          transitionBuilder: (context, a1, a2, widget) {
            return Transform.scale(
              scale: a1.value,
              child: Opacity(
                opacity: a1.value,
                child: InstructorDetail(instructor: course.data.instructor),
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 200),
          barrierDismissible: true,
          barrierLabel: '',
          pageBuilder: (context, animation1, animation2) {
            return Container();
          },
        );
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.background,
                      radius: 20,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: CachedNetworkImage(
                          imageUrl: course.data.instructor.avatar,
                          placeholder: (context, url) => Container(
                              height: 40, width: 40, color: Colors.black),
                          errorWidget: (context, url, error) =>
                              const Center(child: Icon(Icons.error)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 10,
                            children: [
                              Text(
                                "${course.data.instructor.firstName} ${course.data.instructor.lastName}",
                                style: AppTextStyles.bodySmall,
                              ),
                              const Icon(
                                LucideIcons.external_link,
                                color: AppColors.textSecondary,
                                size: 14,
                              ),
                            ],
                          ),
                          Text(
                            course.data.instructor.description,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  course.data.description,
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
