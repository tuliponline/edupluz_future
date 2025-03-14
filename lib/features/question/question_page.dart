import 'package:edupluz_future/core/constant/app_size.dart';
import 'package:edupluz_future/core/services/storages/storage_services.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'question_age.dart';
import 'question_looking_for.dart';
import 'question_start.dart';
import 'question_target.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final controller = PageController(viewportFraction: 1, keepPage: true);
  int currentPage = 0;

  String? ageSelec;
  List<String> target = [];
  List<String> lookingFor = [];

  updateAge(String age) {
    ageSelec = age;
    Logger().d("ageSelec $ageSelec");
  }

  updateTarget(List<String> targetSecect) {
    target = targetSecect;
    Logger().d("targetSecect $targetSecect");
  }

  updateLookingFor(List<String> lookingForSecect) {
    lookingFor = lookingForSecect;
    Logger().d("lookingForSecect $lookingForSecect");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      questionStart(context),
      QuestionAge(
        onSelect: updateAge,
      ),
      QuestionTarget(
        onSave: updateTarget,
      ),
      QuestionLookingFor(onSave: updateLookingFor),
    ];
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller,
            onPageChanged: (int page) {
              setState(() {
                currentPage = page;
              });
            },
            itemBuilder: (_, index) {
              return pages[index % pages.length];
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: ShapeDecoration(
                color: AppColors.background,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(currentPage == 0 ? 0 : 24),
                    topRight: Radius.circular(currentPage == 0 ? 0 : 24),
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              height: (AppSize.screenHeight(context) / 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: controller,
                    count: 4,
                    effect: const ExpandingDotsEffect(
                      dotHeight: 10,
                      dotColor: AppColors.buttonSecondary,
                      activeDotColor: AppColors.primary,
                    ),
                  ),
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary),
                      onPressed: () async {
                        if (currentPage == 0) {
                          controller.animateToPage(1,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        } else if (currentPage == 1) {
                          controller.animateToPage(2,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        } else if (currentPage == 2) {
                          controller.animateToPage(3,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        } else {
                          EasyLoading.show();
                          await StorageServices.setHasQusetions();

                          EasyLoading.dismiss();

                          context.pushReplacementNamed(Routes.signin.name);
                        }
                      },
                      child: Row(
                        children: [
                          Text(
                            (currentPage == 0)
                                ? "เริ่มตอบคำถาม"
                                : (currentPage == 1 || currentPage == 2)
                                    ? "ต่อไป"
                                    : "เริ่มเรียนกันเลย!",
                            style: AppTextStyles.bodyLarge
                                .copyWith(color: AppColors.buttonText),
                          ),
                          const SizedBox(width: 12),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.buttonText,
                            size: 14,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          if (false)
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 16),
                  child: IconButton(
                    onPressed: () {
                      if (currentPage == 1) {
                        controller.animateToPage(0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      } else if (currentPage == 2) {
                        controller.animateToPage(1,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      } else if (currentPage == 3) {
                        controller.animateToPage(2,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  )),
            ),
        ],
      ),
    );
  }
}
