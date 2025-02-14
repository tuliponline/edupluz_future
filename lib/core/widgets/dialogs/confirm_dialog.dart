// ignore_for_file: use_build_context_synchronously

import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool> confirmDialog(BuildContext context,
    {title = "title",
    content = "content",
    conFirmText = "",
    conFirmColor = Colors.red,
    cacelText = "",
    warning = true}) async {
  String btConfirm = "ยืนยัน";
  String btCancel = "ยกเลิก";
  if (conFirmText != "") btConfirm = conFirmText;
  if (cacelText != "") btCancel = cacelText;

  var confirm = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(
        title,
        style: AppTextStyles.h3.copyWith(color: AppColors.textPrimary),
      ),
      content: Text(
        content,
        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
      ),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDestructiveAction: false,
          onPressed: () async {
            Navigator.pop(context, false);
          },
          child: Text(
            btCancel,
            style:
                AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
          ),
        ),
        CupertinoDialogAction(
          isDestructiveAction: warning,
          onPressed: () async {
            Navigator.pop(context, true);
          },
          child: Text(
            btConfirm,
            style: AppTextStyles.bodyMedium.copyWith(color: conFirmColor),
          ),
        ),
      ],
    ),
  );
  return confirm ?? false;
}
