import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class SelectLookingForMenu extends StatelessWidget {
  String title;
  String logo;
  bool isSelected;
  SelectLookingForMenu(
      {required this.title, required this.logo, required this.isSelected});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 98,
      height: 134,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            padding: const EdgeInsets.all(20),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color:
                  isSelected ? AppColors.primary : AppColors.textFieldFillColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    isSelected ? Colors.white : AppColors.primary,
                    BlendMode.srcIn),
                child: Image.asset(logo,
                    height: 50, width: 50, fit: BoxFit.contain)),
          ),
          const SizedBox(height: 8),
          Text(title,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400)),
        ],
      ),
    );
  }
}
