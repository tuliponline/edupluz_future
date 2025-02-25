import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/core/utili/regex_text.dart';
import 'package:edupluz_future/core/widgets/app_buttons.dart';
import 'package:edupluz_future/core/widgets/app_snack_bar.dart';
import 'package:edupluz_future/core/widgets/app_text_field.dart';
import 'package:edupluz_future/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResetPasswordPage extends StatefulWidget {
  final String token;

  const ResetPasswordPage({
    super.key,
    required this.token,
  });

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  l10n.resetPassword,
                  style: AppTextStyles.h2,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.createNewPassword,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textDisabled,
                  ),
                ),
                const SizedBox(height: 32),
                AppTextField(
                  hint: l10n.newPassword,
                  controller: newPasswordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.pleaseEnterPassword;
                    }
                    if (value.length < 8) {
                      return l10n.passwordTooShort;
                    }
                    if (!strongPassword(value)) {
                      return l10n.passwordTooWeak;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AppTextField(
                  hint: l10n.confirmPassword,
                  controller: confirmPasswordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.pleaseConfirmPassword;
                    }
                    if (value != newPasswordController.text) {
                      return l10n.passwordsDoNotMatch;
                    }
                    return null;
                  },
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: AppButton.primaryButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // TODO: Implement password reset logic
                        AppSnackBar.success(
                          context: context,
                          label: l10n.passwordResetSuccess,
                          iconColor: AppColors.success,
                          backgroundColor: AppColors.snackbarBackground,
                          labelColor: AppColors.success,
                        );
                        context.goNamed(Routes.signin.name);
                      }
                    },
                    text: l10n.confirm,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
