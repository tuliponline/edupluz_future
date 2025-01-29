import 'package:edupluz_future/constant/app_size.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/features/presentation/widget/selector_age_item.dart';
import 'package:flutter/material.dart';

class QuestionAge extends StatefulWidget {
  Function onSelect;
  QuestionAge({super.key, required this.onSelect});

  @override
  State<QuestionAge> createState() => _QuestionAgeState();
}

class _QuestionAgeState extends State<QuestionAge> {
  int selectIndex = 0;
  AgeRange ageRange = AgeRange.age13to17;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/question/bg_age.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'ช่วงอายุของคุณ​ ?',
                              style: AppTextStyles.h2,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        height: 260,
                        child: buildAfeAvatarImage(ageRange),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        ageRange == AgeRange.orther
                            ? "โปรดเลือกช่วงอายุ"
                            : buildAgeText(ageRange),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 24),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SelectorAge(
                              ageRange: AgeRange.age13to17,
                              isSelected: selectIndex == 0,
                              // selectIndex == 0,
                              onTap: () {
                                widget.onSelect(buildAgeText(ageRange));
                                setState(() {
                                  ageRange = AgeRange.age13to17;
                                  selectIndex = 0;
                                });
                              },
                            ),
                            SelectorAge(
                              ageRange: AgeRange.age18to24,
                              isSelected: selectIndex == 1,
                              onTap: () {
                                widget.onSelect(buildAgeText(ageRange));
                                setState(() {
                                  ageRange = AgeRange.age18to24;
                                  selectIndex = 1;
                                });
                              },
                            ),
                            SelectorAge(
                              ageRange: AgeRange.age25to34,
                              isSelected: selectIndex == 2,
                              onTap: () {
                                setState(() {
                                  widget.onSelect(buildAgeText(ageRange));
                                  ageRange = AgeRange.age25to34;
                                  selectIndex = 2;
                                });
                              },
                            ),
                            SelectorAge(
                              ageRange: AgeRange.age35to44,
                              isSelected: selectIndex == 3,
                              onTap: () {
                                setState(() {
                                  widget.onSelect(buildAgeText(ageRange));
                                  ageRange = AgeRange.age35to44;
                                  selectIndex = 3;
                                });
                              },
                            ),
                            SelectorAge(
                              ageRange: AgeRange.age45to54,
                              isSelected: selectIndex == 4,
                              onTap: () {
                                setState(() {
                                  widget.onSelect(buildAgeText(ageRange));
                                  ageRange = AgeRange.age45to54;
                                  selectIndex = 4;
                                });
                              },
                            ),
                            SelectorAge(
                              ageRange: AgeRange.age55pluz,
                              isSelected: selectIndex == 5,
                              onTap: () {
                                setState(() {
                                  widget.onSelect(buildAgeText(ageRange));
                                  ageRange = AgeRange.age55pluz;
                                  selectIndex = 5;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: (AppSize.screenHeight(context) / 6),
            )
          ],
        ),
      ),
    );
  }
}
