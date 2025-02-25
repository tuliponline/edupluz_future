import 'package:edupluz_future/constant/app_size.dart';
import 'package:edupluz_future/features/question/widget/select_target_menu.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class QuestionTarget extends StatefulWidget {
  Function onSave;
  QuestionTarget({super.key, required this.onSave});

  @override
  State<QuestionTarget> createState() => _QuestionTargetState();
}

class _QuestionTargetState extends State<QuestionTarget> {
  List<String> targets = [];

  List<String> menus = [
    "พัฒนาทักษะส่วนตัว",
    "เพื่อการเรียนรู้ที่หลากหลาย",
    "มีเนื้อหาที่น่าสนใจ",
    "เรียนรู้และปรับใช้กับองค์กรของตัวเอง",
    "สนุกในการเรียนรู้สิ่งใหม่ ๆ",
    "โอกาสในการเพิ่มฐานเงินเดือน",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/question/question_bg_3.png"),
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
                  padding: const EdgeInsets.only(top: 60, bottom: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Text(
                              'เป้าหมายในการเรียน ?',
                              style: AppTextStyles.h2,
                            ),
                          ),
                          Text('คุณสามารถเลือกได้มากกว่า 1 คำตอบ',
                              style: AppTextStyles.bodyMedium
                                  .copyWith(fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: menus.map(
                            (e) {
                              return Column(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (!targets.contains(e)) {
                                            targets.add(e);
                                          } else {
                                            targets.remove(e);
                                          }
                                          widget.onSave(targets);
                                        });
                                      },
                                      child: SelectTargetMenu(
                                          text: e,
                                          isSelected: targets.contains(e))),
                                  const SizedBox(height: 8),
                                ],
                              );
                            },
                          ).toList()),
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
