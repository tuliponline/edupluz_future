import 'dart:ui';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/core/widgets/app_buttons.dart';
import 'package:edupluz_future/core/widgets/app_snack_bar.dart';
import 'package:edupluz_future/core/widgets/app_text_field.dart';
import 'package:edupluz_future/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _doSignUp() async {
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
            child: Lottie.asset(
              'assets/splash/splash.json',
              fit: BoxFit.cover,
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
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'สมัครสมาชิก Edupluz',
                            style: AppTextStyles.h2,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                'เป็นสมาชิกแล้ว? ',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  context.goNamed(Routes.signin.name);
                                },
                                child: Text(
                                  'เข้าสู่ระบบ',
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
                            label: 'ชื่อ',
                            hint: 'ชื่อ',
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            controller: _nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรุณากรอกชื่อ';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          AppTextField(
                            label: 'นามสกุล',
                            hint: 'นามสกุล',
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            controller: _lastNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรุณากรอกนามสกุล';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          AppTextField(
                            label: 'อีเมล',
                            hint: 'อีเมล',
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรุณากรอกอีเมล';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          AppTextField(
                            label: 'เบอร์โทรศัพท์',
                            hint: 'เบอร์โทรศัพท์',
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            controller: _phoneController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรุณากรอกเบอร์โทรศัพท์';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          AppTextField(
                            label: 'รหัสผ่าน',
                            hint: 'รหัสผ่าน',
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            controller: _passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรุณากรอกรหัสผ่าน';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          AppButton.primaryButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _doSignUp();
                              }
                            },
                            text: 'สมัครสมาชิก',
                          ),
                        ],
                      ),
                    ),
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
