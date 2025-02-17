import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class OrderByItem extends StatelessWidget {
  final String title;
  final String value;
  final String orderBy;
  const OrderByItem(
      {super.key,
      required this.title,
      required this.value,
      required this.orderBy});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: orderBy == value
            ? AppColors.primary
            : AppColors.primary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        title,
        style: AppTextStyles.bodySmall.copyWith(
          fontWeight: FontWeight.w500,
          color:
              orderBy == value ? AppColors.background : AppColors.textPrimary,
        ),
      ),
    );
  }
}
