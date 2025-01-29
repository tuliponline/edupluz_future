import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/core/utili/regex_text.dart';
import 'package:edupluz_future/core/widgets/app_buttons.dart';
import 'package:edupluz_future/core/widgets/app_snack_bar.dart';
import 'package:edupluz_future/core/widgets/app_text_field.dart';
import 'package:edupluz_future/features/auth/presentation/pages/confirm_otp_page.dart';
import 'package:edupluz_future/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:edupluz_future/features/auth/presentation/pages/reset_password_page.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final emailController = TextEditingController();
    final formKey = GlobalKey<FormState>();
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: const Icon(Icons.arrow_back),
                ),
                const SizedBox(height: 24),
                Text(
                  l10n.forgotPassword,
                  style: AppTextStyles.h2,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      l10n.rememberPassword,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.goNamed(Routes.signin.name);
                      },
                      child: Text(
                        l10n.signIn,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textLink,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                AppTextField(
                  hint: l10n.email,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.pleaseEnterEmail;
                    }
                    if (!emailRegex(value)) {
                      return l10n.invalidEmail;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                Text(l10n.enterEmailReset,
                    style: AppTextStyles.bodyMedium
                        .copyWith(color: AppColors.textDisabled)),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: AppButton.primaryButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ConfirmOTPPage(
                              contactInfo: emailController.text,
                              refCode: '',
                              isEmail: true,
                              isForgotPassword: true,
                            ),
                          ),
                        );
                      } else {
                        AppSnackBar.alert(
                          context: context,
                          label: l10n.pleaseEnterValidEmail,
                        );
                      }
                    },
                    text: l10n.resetPassword,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
