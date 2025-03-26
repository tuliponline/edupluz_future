import 'package:cached_network_image/cached_network_image.dart';
import 'package:edupluz_future/core/providers/firebase/card_landscape_detail_provider.dart';
import 'package:edupluz_future/core/services/firebase/remote_config_service.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/core/widgets/images/logo_image_wide.dart';
import 'package:edupluz_future/features/preview/presentation/preview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CardCourseLandscape extends ConsumerWidget {
  final String courseId;
  String title;
  String subtitle;
  String instructor;
  String? imageUrl;
  bool isShowDetail;

  CardCourseLandscape({
    Key? key,
    required this.courseId,
    required this.title,
    required this.subtitle,
    required this.instructor,
    this.imageUrl,
    this.isShowDetail = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isShowText = ref.watch(cardLandscapeDetailProvider);
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
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: imageUrl == null
                          ? Container(
                              height: 130,
                              width: 230,
                              color: AppColors.background)
                          : CachedNetworkImage(
                              imageUrl: imageUrl!,
                              placeholder: (context, url) => Skeletonizer(
                                  child: Container(
                                      height: 130,
                                      width: 230,
                                      color: AppColors.background)),
                              errorWidget: (context, url, error) =>
                                  logoImageWide(),
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  if (isShowText)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: SizedBox(
                        width: 230,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                maxLines: 1,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  overflow: TextOverflow.ellipsis,
                                  color: AppColors.background,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              SizedBox(
                                width: 230 / 5,
                                child: Divider(
                                  color: AppColors.background,
                                  height: 10,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                instructor,
                                maxLines: 1,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.background,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
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
