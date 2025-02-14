import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CardProfilePlan extends StatelessWidget {
  String title = "Yearly package";
  String subtitle = "until 10/10/2024";
  CardProfilePlan(
      {super.key,
      this.title = "Yearly package",
      this.subtitle = "until 10/10/2024"});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: ShapeDecoration(
        color: AppColors.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: const [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 30,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: AppTextStyles.bodySmall),
          const SizedBox(width: 5),
          Text(
            subtitle,
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }
}
