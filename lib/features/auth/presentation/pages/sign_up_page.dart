import 'dart:ui';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:edupluz_future/core/constant/test_account.dart';
import 'package:edupluz_future/core/models/auth/otp_verify_request.dart';
import 'package:edupluz_future/core/models/auth/register_otp_verify_response.dart';
import 'package:edupluz_future/core/models/auth/register_response_model.dart';
import 'package:edupluz_future/core/services/auth/register_service.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/core/utili/regex_text.dart';
import 'package:edupluz_future/core/widgets/app_buttons.dart';
import 'package:edupluz_future/core/widgets/app_snack_bar.dart';
import 'package:edupluz_future/core/widgets/app_text_field.dart';
import 'package:edupluz_future/features/auth/presentation/pages/confirm_otp_page.dart';
import 'package:edupluz_future/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
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
    try {
      EasyLoading.show();
      RegisterResponseModel? registerResponse = await registerService(
        email: _emailController.text,
        password: _passwordController.text,
        firstName: _nameController.text,
        lastName: _lastNameController.text,
        phone: _phoneController.text,
      );
      if (registerResponse != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConfirmOTPPage(
              contactInfo: _emailController.text,
              refCode: registerResponse.data.refCode,
              isEmail: true,
              isForgotPassword: false,
            ),
          ),
        );
        // OtpVerifyRequest request = OtpVerifyRequest(
        //   refCode: registerResponse.data.refCode,
        //   otpCode: "507392",
        // );
        // RegisterOtpVerifyResponse response = await registerOtpVerify(request);
        // Logger().d(response);
        // if (mounted) {
        //   // Add delay before navigation

        //   if (mounted) {
        //     EasyLoading.showSuccess('สมัครสมาชิกสำเร็จ โปรดเข้าสู่ระบบ');
        //     context.goNamed(Routes.signin.name);
        //   }
        // }
      } else {
        EasyLoading.dismiss();
        AppSnackBar.alert(
          context: context,
          label: 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง',
          iconColor: AppColors.error,
          backgroundColor: AppColors.snackbarBackground,
          labelColor: AppColors.error,
        );
      }
    } catch (e) {
      AppSnackBar.alert(
        context: context,
        label: 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง',
        iconColor: AppColors.error,
        backgroundColor: AppColors.snackbarBackground,
        labelColor: AppColors.error,
      );
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  void initState() {
    if (TestAccount.isTestAccount) {
      _nameController.text = TestAccount.name;
      _lastNameController.text = TestAccount.lastName;
      _emailController.text = TestAccount.email;
      _phoneController.text = TestAccount.phone;
      _passwordController.text = TestAccount.password;
    }
    super.initState();
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
                      child: GestureDetector(
                        onTap: () {
                          // context.goNamed(Routes.navigation.name);
                        },
                        child: Text(
                          '',
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
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
                              if (!emailRegex(value)) {
                                return 'รูปแบบอีเมลไม่ถูกต้อง';
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
                              if (!strongPassword(value)) {
                                return 'รหัสผ่านต้องมีอย่างน้อย 8 ตัวอักษร มีตัวพิมพ์เล็ก พิมพ์ใหญ่ มีตัวเลข และมีตัวพิมพ์เล็ก พิมพ์ใหญ่ มีตัวเลข';
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
