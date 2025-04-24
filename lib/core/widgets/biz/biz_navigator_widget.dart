import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/features/biz_courses/presentation/pages/biz_courses_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class BizNavigatorWidget extends StatelessWidget {
  const BizNavigatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return cardCourseDetail(context);
  }

  Container cardCourseDetail(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BizCoursesPage()));
          },
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.asset(
                        "assets/images/biz/biz-bg.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Container(
                height: 50,
                decoration: ShapeDecoration(
                  color: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(57),
                  ),
                ),
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: 24, right: 9, top: 9, bottom: 9),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ดูคอร์สจากพาร์ทเนอร์',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.background,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          width: 32,
                          height: 32,
                          padding: const EdgeInsets.all(8),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: AppColors.background,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: const Icon(
                            LucideIcons.arrow_right,
                            size: 16,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
