import 'package:cached_network_image/cached_network_image.dart';
import 'package:edupluz_future/core/models/courses/courses_model.dart';
import 'package:edupluz_future/core/services/courses/fetch_course_random.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/features/preview/presentation/preview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CardCoursesRandom extends ConsumerStatefulWidget {
  const CardCoursesRandom({super.key});

  @override
  ConsumerState<CardCoursesRandom> createState() => _CardCoursesRandomState();
}

class _CardCoursesRandomState extends ConsumerState<CardCoursesRandom> {
  Item? course;
  _ranDomCourses() async {
    course = await fetchCourseRandom();
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    _ranDomCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return course == null ? _cardCourseRandomLoading() : cardCourseDetail();
  }

  Container cardCourseDetail() {
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
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: CachedNetworkImage(
                  imageUrl: course!.thumbnail.horizontal,
                  placeholder: (context, url) => Skeletonizer(
                      child: Container(
                          height: 297, width: 158, color: Colors.black)),
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.error)),
                  fit: BoxFit.cover,
                ),
              ),
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
                  child: GestureDetector(
                    onTap: () {
                      if (course != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PreviewPage(courseId: course!.id)));
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'เริ่มเรียน',
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
                            LucideIcons.play,
                            size: 16,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardCourseRandomLoading() {
    return Skeletonizer(
      child: Container(
        width: double.infinity,
        decoration: ShapeDecoration(
          color: AppColors.cardBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                        height: 297, width: 158, color: Colors.black)),
              ),
              const SizedBox(height: 16),
              Container(
                height: 50,
                decoration: ShapeDecoration(
                  color: AppColors.cardBackground,
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
                        Text('เริ่มเรียน', style: AppTextStyles.bodySmall),
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
                            LucideIcons.play,
                            size: 16,
                            color: AppColors.background,
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
