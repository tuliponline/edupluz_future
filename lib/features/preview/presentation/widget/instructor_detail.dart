import 'package:cached_network_image/cached_network_image.dart';
import 'package:edupluz_future/core/constant/app_size.dart';
import 'package:edupluz_future/core/models/courses/course_model.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class InstructorDetail extends StatelessWidget {
  final Instructor instructor;
  const InstructorDetail({super.key, required this.instructor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Container(
                height: AppSize.screenHeight(context) * 0.5,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.background,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          imageUrl: instructor.avatar,
                          errorWidget: (context, url, error) =>
                              const Center(child: Icon(Icons.error)),
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "${instructor.title} ${instructor.firstName} ${instructor.lastName}",
                        style: AppTextStyles.h2,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        instructor.description,
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.background,
                  ),
                  child: const Icon(
                    LucideIcons.x,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
