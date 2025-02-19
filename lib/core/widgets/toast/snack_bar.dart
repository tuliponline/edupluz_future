import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

toast(BuildContext context,
    {required String text,
    TextStyle? style,
    Color backgroundColor = AppColors.background}) {
  final scaffold = ScaffoldMessenger.of(context);

  if (scaffold.mounted) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }

  scaffold.showSnackBar(
    SnackBar(
      showCloseIcon: true,
      closeIconColor: AppColors.textSecondary,
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 3),
      content: Text(
        text,
        style: style,
      ),
    ),
  );
}
