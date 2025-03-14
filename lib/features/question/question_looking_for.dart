import 'package:edupluz_future/core/constant/app_size.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/features/question/widget/secect_looking_for_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class QuestionLookingFor extends StatefulWidget {
  Function onSave;
  QuestionLookingFor({super.key, required this.onSave});

  @override
  State<QuestionLookingFor> createState() => _QuestionLookingForState();
}

class _QuestionLookingForState extends State<QuestionLookingFor> {
  List<String> targets = [];

  List<Map<String, String>> menus = [
    {
      "name": "Mastery",
      "logo": "assets/images/question/looking_for/mastery.png"
    },
    {
      "name": "ศิลปะ & ความบันเทิง",
      "logo": "assets/images/question/looking_for/entertainment.png"
    },
    {
      "name": "ธุรกิจ & กลยุทธ์",
      "logo": "assets/images/question/looking_for/business.png"
    },
    {
      "name": "การเงิน & การลงทุน",
      "logo": "assets/images/question/looking_for/investment.png"
    },
    {
      "name": "AI & เทคโนโลยี",
      "logo": "assets/images/question/looking_for/ai.png"
    },
    {
      "name": "แนวคิด & \nความสัมพันธ์",
      "logo": "assets/images/question/looking_for/mindsets.png"
    },
    {
      "name": "ภาษา",
      "logo": "assets/images/question/looking_for/languages.png"
    },
    {
      "name": "การสื่อสาร & บุคลิกภาพ",
      "logo": "assets/images/question/looking_for/comunicate.png"
    },
    {
      "name": "ไลฟ์สไตล์",
      "logo": "assets/images/question/looking_for/lifestyle.png"
    },
    {
      "name": "สุขภาพ & \nคุณภาพชีวิต",
      "logo": "assets/images/question/looking_for/health.png"
    },
    {
      "name": "เด็ก & ครอบครัว",
      "logo": "assets/images/question/looking_for/kid.png"
    },
    {
      "name": "ทักษะ & \nการพัฒนาอาชีพ",
      "logo": "assets/images/question/looking_for/career.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/question/question_bg_4.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Text(
                          'หัวข้อที่คุณสนใจ ?',
                          style: AppTextStyles.h2,
                        ),
                      ),
                      Expanded(
                        child: AlignedGridView.count(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            crossAxisCount: 3,
                            itemCount: menus.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(
                                    () {
                                      if (targets
                                          .contains(menus[index]['name']!)) {
                                        targets.remove(menus[index]['name']!);
                                      } else {
                                        targets.add(menus[index]['name']!);
                                      }
                                      widget.onSave(targets);
                                    },
                                  );
                                },
                                child: SelectLookingForMenu(
                                  title: menus[index]['name']!,
                                  logo: menus[index]['logo']!,
                                  isSelected:
                                      targets.contains(menus[index]['name']!),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: (AppSize.screenHeight(context) / 6),
              )
            ],
          ),
        ),
      ),
    );
  }
}
