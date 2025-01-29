import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final bool enabled;
  final String? text;
  final VoidCallback? onPressed;
  final bool hasSearchIcon;
  final ButtonVariant variant;
  final ButtonSize size;
  final Image? icon;
  const AppButton({
    Key? key,
    this.enabled = true,
    this.text,
    this.onPressed,
    this.hasSearchIcon = false,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: _getButtonStyle(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            icon!,
            const SizedBox(width: 8),
          ],
          if (hasSearchIcon) ...[
            Icon(
              Icons.search,
              color: _getTextColor(context),
              size: _getIconSize(),
            ),
            const SizedBox(width: 8),
          ],
          if (text != null)
            Text(
              text!,
              style: TextStyle(
                color: _getTextColor(context),
                fontSize: _getFontSize(),
              ),
            ),
        ],
      ),
    );
  }

  ButtonStyle _getButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor:
          enabled ? _getBackgroundColor(context) : AppColors.buttonDisabled,
      padding: _getPadding(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: _getBorderSide(context),
      ),
      elevation: variant == ButtonVariant.outline ? 0 : null,
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    switch (variant) {
      case ButtonVariant.primary:
        return AppColors.buttonPrimary;
      case ButtonVariant.secondary:
        return AppColors.buttonSecondary;
      case ButtonVariant.outline:
        return Colors.transparent;
      case ButtonVariant.dark:
        return Colors.grey[800]!;
      case ButtonVariant.light:
        return AppColors.surfaceBackground;
      case ButtonVariant.ghost:
        return Colors.transparent;
    }
  }

  Color _getTextColor(BuildContext context) {
    switch (variant) {
      case ButtonVariant.primary:
      case ButtonVariant.secondary:
      case ButtonVariant.dark:
        return AppColors.buttonText;
      case ButtonVariant.outline:
        return AppColors.buttonPrimary;
      case ButtonVariant.light:
        return AppColors.textPrimary;
      case ButtonVariant.ghost:
        return AppColors.textSecondary;
    }
  }

  BorderSide _getBorderSide(BuildContext context) {
    switch (variant) {
      case ButtonVariant.outline:
        return BorderSide(
          color: AppColors.buttonPrimary,
          width: 1.5,
        );
      case ButtonVariant.ghost:
        return BorderSide(
          color: AppColors.border,
          width: 1,
        );
      default:
        return BorderSide.none;
    }
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case ButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
      default:
        return const EdgeInsets.symmetric(horizontal: 14, vertical: 10);
    }
  }

  double _getFontSize() {
    switch (size) {
      case ButtonSize.small:
        return 14;
      case ButtonSize.large:
        return 18;
      default:
        return 16;
    }
  }

  double _getIconSize() {
    switch (size) {
      case ButtonSize.small:
        return 16;
      case ButtonSize.large:
        return 24;
      default:
        return 20;
    }
  }

  // Static button creators
  static Widget primaryButton({
    String? text,
    VoidCallback? onPressed,
    bool hasSearchIcon = false,
    ButtonSize size = ButtonSize.medium,
    bool enabled = true,
  }) {
    return AppButton(
      text: text,
      onPressed: onPressed,
      hasSearchIcon: hasSearchIcon,
      variant: ButtonVariant.primary,
      size: size,
      enabled: enabled,
    );
  }

  static Widget secondaryButton({
    String? text,
    VoidCallback? onPressed,
    bool hasSearchIcon = false,
    ButtonSize size = ButtonSize.medium,
    bool enabled = true,
  }) {
    return AppButton(
      text: text,
      onPressed: onPressed,
      hasSearchIcon: hasSearchIcon,
      variant: ButtonVariant.secondary,
      size: size,
      enabled: enabled,
    );
  }

  static Widget outlineButton({
    Image? icon,
    String? text,
    VoidCallback? onPressed,
    bool hasSearchIcon = false,
    ButtonSize size = ButtonSize.medium,
    bool enabled = true,
  }) {
    return AppButton(
      icon: icon,
      text: text,
      onPressed: onPressed,
      hasSearchIcon: hasSearchIcon,
      variant: ButtonVariant.outline,
      size: size,
    );
  }

  static Widget darkButton({
    String? text,
    VoidCallback? onPressed,
    bool hasSearchIcon = false,
    ButtonSize size = ButtonSize.medium,
    bool enabled = true,
  }) {
    return AppButton(
      text: text,
      onPressed: onPressed,
      hasSearchIcon: hasSearchIcon,
      variant: ButtonVariant.dark,
      size: size,
      enabled: enabled,
    );
  }

  static Widget lightButton({
    String? text,
    VoidCallback? onPressed,
    bool hasSearchIcon = false,
    ButtonSize size = ButtonSize.medium,
    bool enabled = true,
  }) {
    return AppButton(
      text: text,
      onPressed: onPressed,
      hasSearchIcon: hasSearchIcon,
      variant: ButtonVariant.light,
      size: size,
      enabled: enabled,
    );
  }

  static Widget ghostButton({
    String? text,
    VoidCallback? onPressed,
    bool hasSearchIcon = false,
    ButtonSize size = ButtonSize.medium,
    bool enabled = true,
  }) {
    return AppButton(
      text: text,
      onPressed: onPressed,
      hasSearchIcon: hasSearchIcon,
      variant: ButtonVariant.ghost,
      size: size,
      enabled: enabled,
    );
  }
}

enum ButtonVariant {
  primary, // Filled primary color button
  secondary, // Filled amber color button
  outline, // Outlined button with primary color border
  dark, // Dark grey background
  light, // Light grey background
  ghost, // Transparent with light border
}

enum ButtonSize {
  small,
  medium,
  large,
}
