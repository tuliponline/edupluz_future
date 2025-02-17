import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

Container cetMenuItem({required String name, required bool inSelected}) {
  return Container(
    height: 32,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
    clipBehavior: Clip.antiAlias,
    decoration: ShapeDecoration(
      color: (inSelected) ? AppColors.primary : AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(999),
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          name,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodySmall,
        ),
      ],
    ),
  );
}
