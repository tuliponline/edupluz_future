import 'package:cached_network_image/cached_network_image.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/features/classroom/presentation/classroom_screen.dart';
import 'package:edupluz_future/features/preview/presentation/preview_screen.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CardCoursesPortrait extends StatelessWidget {
  final String? title;
  final String? instructor;
  final String? imageUrl;
  final String courseId;
  final String chapterId;
  final String lessonId;
  final dynamic progress;
  final bool isShowProgress;
  const CardCoursesPortrait({
    super.key,
    this.imageUrl,
    this.title,
    this.instructor,
    required this.courseId,
    this.chapterId = "",
    this.lessonId = "",
    this.progress = 0.0,
    this.isShowProgress = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (courseId != '') {
          if (isShowProgress) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ClassroomPage(
                          courseId: courseId,
                          chapterId: chapterId,
                          lessonId: lessonId,
                        )));
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PreviewPage(
                          courseId: courseId,
                        )));
          }
        }
      },
      child: SizedBox(
        width: 132,
        height: 198,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: (imageUrl == null)
                ? Container(
                    width: 132,
                    height: 198,
                    color: AppColors.background,
                  )
                : Stack(
                    children: [
                      Column(
                        children: [
                          CachedNetworkImage(
                            imageUrl: imageUrl!,
                            placeholder: (context, url) => Skeletonizer(
                              child: Container(
                                width: 132,
                                height: 132,
                                color: AppColors.background,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const SizedBox(
                                    width: 132,
                                    height: 132,
                                    child: Icon(Icons.error)),
                            fit: BoxFit.cover,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                              color: Colors.black,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    title ?? "",
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: AppColors.background,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  SizedBox(
                                    width: 132 / 5,
                                    child: Divider(
                                      color: AppColors.background,
                                      height: 10,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    maxLines: 1,
                                    instructor ?? "",
                                    style: AppTextStyles.labelSmall.copyWith(
                                      overflow: TextOverflow.ellipsis,
                                      color: AppColors.background,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (isShowProgress)
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: IntrinsicWidth(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Row(
                                  children: [
                                    Text('เรียนต่อ', style: AppTextStyles.h4),
                                    const SizedBox(width: 4),
                                    const Icon(
                                      Icons.play_arrow,
                                      color: AppColors.buttonText,
                                      size: 18,
                                      fill: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (isShowProgress)
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: LinearProgressIndicator(
                            minHeight: 2,
                            borderRadius: BorderRadius.circular(2),
                            value: progress / 100,
                            color: AppColors.primary,
                            backgroundColor: AppColors.buttonDisabled,
                          ),
                        ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
