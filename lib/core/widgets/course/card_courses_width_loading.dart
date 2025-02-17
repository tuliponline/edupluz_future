import 'package:cached_network_image/cached_network_image.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CardCoursesWidthLoading extends StatelessWidget {
  CardCoursesWidthLoading({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Column(
        children: [
          Container(
            // height: 96,
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
                        child: Container(
                            height: 130, width: 230, color: Colors.grey)),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 51,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'สร้าง Mindset แบบผู้นำ',
                              style: AppTextStyles.bodyMedium.copyWith(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Text('2 ชม. 22 นาที l 8 บทเรียน',
                                  style: AppTextStyles.bodySmall.copyWith(
                                      overflow: TextOverflow.ellipsis,
                                      color: AppColors.textDisabled)),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                '#ธุรกิจ & กลยุทธ์/การสร้างแบรนด์',
                                style: AppTextStyles.bodySmall.copyWith(
                                    overflow: TextOverflow.ellipsis,
                                    color: AppColors.textDisabled),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'ผู้สอน : ธนบัตร กายเออร์',
                        style: AppTextStyles.bodySmall.copyWith(
                            overflow: TextOverflow.ellipsis,
                            color: AppColors.textDisabled),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
