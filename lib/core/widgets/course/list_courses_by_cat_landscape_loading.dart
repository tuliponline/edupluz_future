import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/features/course/presentation/widget/card_courses_landscape.dart';

import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ListCoursesByCatLandscapeLoading extends StatelessWidget {
  bool showDetail;
  bool isEdupluz;
  ListCoursesByCatLandscapeLoading({
    super.key,
    this.showDetail = true,
    this.isEdupluz = true,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enableSwitchAnimation: true,
      containersColor: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Skeleton.leaf(
                  child: Text(
                    "หลักสูตรที่เกี่ยวข้อง",
                    style: AppTextStyles.h2,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    LucideIcons.chevron_right,
                    color: AppColors.buttonText,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: showDetail ? 185 : 130,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    CardCourseLandscape(
                      instructor: "ภาษาจีนเพื่อการท่องเที่ยว ",
                      isShowDetail: showDetail,
                      courseId: "",
                      title: "ภาษาจีนเพื่อการท่องเที่ยว ",
                      subtitle: '#Skills & Career Development',
                      imageUrl: null,
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    CardCourseLandscape(
                      instructor: "ภาษาจีนเพื่อการท่องเที่ยว ",
                      isShowDetail: showDetail,
                      courseId: "",
                      title: "ภาษาจีนเพื่อการท่องเที่ยว ",
                      subtitle: '#Skills & Career Development',
                      imageUrl: null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
