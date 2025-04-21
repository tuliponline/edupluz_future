import 'dart:convert';

import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class InfoDialog extends StatelessWidget {
  final Function(bool) callback;
  final String title;
  final String detail;
  final String btOk;
  final IconData icon;
  final bool showIcon;
  final bool testCenter;
  final Color color = AppColors.textPrimary;
  final Color contentColor = AppColors.textPrimary;

  const InfoDialog(
      {super.key,
      required this.callback,
      required this.title,
      required this.detail,
      this.showIcon = true,
      this.testCenter = false,
      this.btOk = "ตกลง",
      this.icon = Icons.warning});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showIcon) Icon(icon, size: 100, color: contentColor),
            if (title != "") const SizedBox(height: 13.0),
            if (title != "")
              Text(title,
                  style: AppTextStyles.h3.copyWith(color: contentColor)),
            const SizedBox(height: 13.0),
            Center(
                child: Text(detail,
                    textAlign: (testCenter) ? TextAlign.center : TextAlign.left,
                    style: AppTextStyles.bodyMedium
                        .copyWith(color: contentColor))),
            const SizedBox(height: 23.0),
            SizedBox(
              width: 200,
              height: 48,
              child: ElevatedButton(
                child: Text(btOk),
                onPressed: () {
                  callback(true); // Call the callback with true value
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
