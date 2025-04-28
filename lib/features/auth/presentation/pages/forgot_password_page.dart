import 'package:edupluz_future/core/constant/test_account.dart';
import 'package:edupluz_future/core/models/auth/forgot_password_otp_verify_response.dart';
import 'package:edupluz_future/core/models/auth/otp_verify_request.dart';
import 'package:edupluz_future/core/models/auth/register_response_model.dart';
import 'package:edupluz_future/core/services/auth/forgot_password.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/core/utili/regex_text.dart';
import 'package:edupluz_future/core/widgets/app_buttons.dart';
import 'package:edupluz_future/core/widgets/app_snack_bar.dart';
import 'package:edupluz_future/core/widgets/app_text_field.dart';
import 'package:edupluz_future/features/auth/presentation/pages/confirm_otp_page.dart';
import 'package:edupluz_future/features/auth/presentation/pages/reset_password_page.dart';
import 'package:edupluz_future/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logger/logger.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    if (TestAccount.isTestAccount) {
      emailController.text = TestAccount.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back),
                ),
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
                    EasyLoading.show();
                    try {
                      if (formKey.currentState!.validate()) {
                        RegisterResponseModel response =
                            await ForgotPasswordService().forgotPassword(
                          emailController.text,
                        );
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => ConfirmOTPPage(
                        //       contactInfo: emailController.text,
                        //       refCode: response.data.refCode,
                        //       isEmail: true,
                        //       isForgotPassword: true,
                        //     ),
                        //   ),
                        // );
                        OtpVerifyRequest request = OtpVerifyRequest(
                          refCode: response.data.refCode,
                          otpCode: "507392",
                        );
                        ForgotPasswordOtpVerifyResponse verifyResponse =
                            await ForgotPasswordService()
                                .forgotPasswordOtpVerify(request);

                        Logger().d(verifyResponse.data.token);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResetPasswordPage(
                              token: verifyResponse.data.token,
                            ),
                          ),
                        );
                      } else {
                        AppSnackBar.alert(
                          context: context,
                          label: l10n.pleaseEnterValidEmail,
                        );
                      }
                    } catch (e) {
                      Logger().e(e);
                      AppSnackBar.alert(
                        context: context,
                        label: l10n.pleaseEnterValidEmail,
                      );
                    } finally {
                      EasyLoading.dismiss();
                    }
                  },
                  text: l10n.resetPassword,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
