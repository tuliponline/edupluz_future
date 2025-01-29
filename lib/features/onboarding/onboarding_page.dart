import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:edupluz_future/constant/app_size.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/core/widgets/app_buttons.dart';
import 'package:edupluz_future/features/onboarding/onboarding_screen1.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'onboarding_screen2.dart';
import 'onboarding_screen3.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = PageController(viewportFraction: 1, keepPage: true);
  int currentPage = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      onBoardingScreen1(context),
      onBoardingScreen2(context),
      onBoardingScreen3(context),
    ];
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: controller,
            onPageChanged: (int page) {
              setState(() {
                currentPage = page % pages.length;
              });
            },
            itemBuilder: (_, index) {
              return pages[index % pages.length];
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: (AppSize.screenHeight(context) / 3.5) + 50,
              child: Column(
                children: [
                  SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                      dotHeight: 10,
                      dotColor: AppColors.buttonSecondary,
                      activeDotColor: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: AppSize.screenHeight(context) / 3.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 56,
                          width: 180,
                          child: AppButton.primaryButton(
                            text: "เข้าเรียนกันเลย!",
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    if (currentPage == 0)
                      const SizedBox(
                        height: 24,
                      ),
                    if (currentPage == 0)
                      Text(
                        "สำรวจคอร์สทั้งหมด",
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
