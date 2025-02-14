import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class SettingMenu extends StatelessWidget {
  IconData icon;
  String title;
  Function onTap;
  SettingMenu(
      {Key? key, required this.icon, required this.title, required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppColors.iconPrimary,
            ),
            const SizedBox(width: 12),
            Text(title, style: AppTextStyles.bodyLarge),
          ],
        ),
      ),
    );
  }
}
