import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';

class AppSnackBar {
  static success({
    required BuildContext context,
    required String label,
    Color? iconColor,
    Color? backgroundColor,
    Color? labelColor,
  }) {
    return IconSnackBar.show(
      context,
      label: label,
      snackBarType: SnackBarType.success,
      iconColor: iconColor ?? AppColors.textPrimary,
      backgroundColor: backgroundColor ?? AppColors.snackbarBackground,
      labelTextStyle: AppTextStyles.bodyMedium.copyWith(
        color: labelColor ?? AppColors.textPrimary,
      ),
    );
  }

  static error({
    required BuildContext context,
    required String label,
    Color? iconColor,
    Color? backgroundColor,
    Color? labelColor,
  }) {
    return IconSnackBar.show(
      context,
      label: label,
      snackBarType: SnackBarType.fail,
      iconColor: iconColor ?? AppColors.textPrimary,
      backgroundColor: backgroundColor ?? AppColors.snackbarBackground,
      labelTextStyle: AppTextStyles.bodyMedium.copyWith(
        color: labelColor ?? AppColors.error,
      ),
    );
  }

  static alert({
    required BuildContext context,
    required String label,
    Color? iconColor,
    Color? backgroundColor,
    Color? labelColor,
  }) {
    return IconSnackBar.show(
      context,
      label: label,
      snackBarType: SnackBarType.alert,
      iconColor: iconColor ?? AppColors.textPrimary,
      backgroundColor: backgroundColor ?? AppColors.snackbarBackground,
      labelTextStyle: AppTextStyles.bodyMedium.copyWith(
        color: labelColor ?? AppColors.textPrimary,
      ),
    );
  }
}
