import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardProfileCount extends StatelessWidget {
  IconData icon;
  String title;
  String count;
  bool isCommingSoon;
  CardProfileCount(
      {super.key,
      required this.icon,
      required this.title,
      required this.count,
      this.isCommingSoon = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 97,
      height: 134,
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
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: const ShapeDecoration(
                  color: AppColors.buttonSecondary,
                  shape: OvalBorder(),
                ),
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: Icon(
                    icon,
                    color: AppColors.background,
                  ),
                ),
              ),
              SizedBox(
                width: 81,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodySmall,
                ),
              ),
              SizedBox(
                width: 81,
                child: Text(count,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodySmall),
              ),
            ],
          ),
          if (isCommingSoon)
            const Positioned.fill(
              child: BlurryContainer.expand(
                child: Center(
                  child: Text(
                    'Coming Soon',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
