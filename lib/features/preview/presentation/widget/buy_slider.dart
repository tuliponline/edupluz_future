import 'package:edupluz_future/core/models/courses/course_model.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:url_launcher/url_launcher.dart';

class BuySlider extends StatelessWidget {
  final CourseModel course;
  const BuySlider({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final GlobalKey<SlideActionState> key = GlobalKey();
        return Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SlideAction(
              key: key,
              height: 56,
              innerColor: AppColors.background,
              outerColor: AppColors.primary,
              sliderButtonIcon: const Icon(
                LucideIcons.shopping_cart,
                size: 18,
                color: AppColors.primary,
              ),
              sliderRotate: false,
              sliderButtonIconSize: 14,
              sliderButtonIconPadding: 10,
              onSubmit: () {
                key.currentState!.reset();
                _launchUrl();
                return;
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Spacer(),
                    Text(
                      "> > >",
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.background,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "สไลด์เพื่อซื้อคอร์สนี้",
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.background,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "฿ ${course.data.price}",
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.background,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _launchUrl() async {
    String url = "https://edupluz.com/preview/${course.data.slug}";
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }
}
