import 'package:edupluz_future/core/constant/app_size.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Container questionStart(BuildContext context) {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/images/question/question_bg_1.png"),
        fit: BoxFit.cover,
      ),
    ),
    child: SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: const ShapeDecoration(
              color: AppColors.background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
            ),
            padding:
                const EdgeInsets.only(top: 32, bottom: 24, left: 32, right: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ก่อนเข้าห้องเรียน !",
                  style: AppTextStyles.h2,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "ช่วยตอบคำถามสั้น ๆ เพื่อให้พวกเรา\nได้เสนอสิ่งที่ตรงกับความต้องการของคุณ",
                  style: AppTextStyles.bodyLarge,
                ),
              ],
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
