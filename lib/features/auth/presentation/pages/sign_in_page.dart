import 'dart:ui';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:edupluz_future/core/widgets/app_buttons.dart';
import 'package:edupluz_future/core/widgets/app_snack_bar.dart';
import 'package:edupluz_future/core/widgets/app_text_field.dart';
import 'package:edupluz_future/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  _doSignIn() async {
    AppSnackBar.alert(
      context: context,
      label: 'อีเมลหรือรหัสผ่านไม่ถูกต้อง',
      iconColor: AppColors.error,
      backgroundColor: AppColors.snackbarBackground,
      labelColor: AppColors.error,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: BackdropFilter(
              filter: ImageFilter.blur(),
              child: Lottie.asset(
                'assets/splash/splash.json',
                fit: BoxFit.cover,
              ),
            ),
          ),
          BlurryContainer(
            child: Container(),
            blur: 4,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            elevation: 0,
            color: AppColors.background.withOpacity(0.6),
            padding: const EdgeInsets.all(8),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'ข้าม',
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'เข้าสู่ระบบ',
                        style: AppTextStyles.h2,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            'ยังไม่ได้เป็นสมาชิก? ',
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.goNamed(Routes.signup.name);
                            },
                            child: Text(
                              'สมัครสมาชิกเลย!',
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
                        hint: 'อีเมล',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        focusNode: _usernameFocusNode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณากรอกอีเมล';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        hint: 'รหัสผ่าน',
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        focusNode: _passwordFocusNode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณากรอกรหัสผ่าน';
                          }
                          return null;
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            context.pushNamed(Routes.forgotpassword.name);
                          },
                          child: Text(
                            'ลืมรหัสผ่าน?',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      AppButton.primaryButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _doSignIn();
                          }
                        },
                        text: 'เข้าสู่ระบบ',
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Text(
                          'หรือเข้าสู่ระบบด้วย',
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      AppButton.outlineButton(
                        onPressed: () {},
                        text: 'เข้าสู่ระบบด้วย gmail',
                        icon: Image.asset('assets/social/google.png'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
