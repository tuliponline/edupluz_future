import 'package:cached_network_image/cached_network_image.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/features/preview/presentation/preview_screen.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CardCourseLandscape extends StatelessWidget {
  final String courseId;
  String title;
  String subtitle;
  String? imageUrl;
  bool isShowDetail;

  CardCourseLandscape({
    Key? key,
    required this.courseId,
    required this.title,
    required this.subtitle,
    this.imageUrl,
    this.isShowDetail = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (courseId != '') {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PreviewPage(courseId: courseId)));
          }
        },
        child: SizedBox(
          width: 230,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: imageUrl == null
                      ? Container(
                          height: 130, width: 230, color: AppColors.background)
                      : CachedNetworkImage(
                          imageUrl: imageUrl!,
                          placeholder: (context, url) => Skeletonizer(
                              child: Container(
                                  height: 130,
                                  width: 230,
                                  color: AppColors.background)),
                          errorWidget: (context, url, error) =>
                              const Center(child: Icon(Icons.error)),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              if (isShowDetail)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                title,
                                style: AppTextStyles.h2,
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                subtitle,
                                style: AppTextStyles.bodySmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ));
  }
}
