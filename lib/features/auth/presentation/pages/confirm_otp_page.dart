import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/core/widgets/app_buttons.dart';
import 'package:edupluz_future/features/auth/presentation/pages/reset_password_page.dart';
import 'package:flutter/material.dart';

import 'dart:async';

import 'package:logger/logger.dart';

class ConfirmOTPPage extends StatefulWidget {
  final String contactInfo;
  final String refCode;
  final bool isEmail;
  final bool isForgotPassword;

  const ConfirmOTPPage({
    super.key,
    required this.contactInfo,
    required this.refCode,
    required this.isEmail,
    this.isForgotPassword = false,
  });

  @override
  State<ConfirmOTPPage> createState() => _ConfirmOTPPageState();
}

class _ConfirmOTPPageState extends State<ConfirmOTPPage> {
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  Timer? _timer;
  int _countdown = 60;
  bool _canResend = false;
  final Logger _logger = Logger();
  @override
  void initState() {
    super.initState();
    startTimer();
    _focusNodes[0].requestFocus();
  }

  void startTimer() {
    setState(() {
      _countdown = 60;
      _canResend = false;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown == 0) {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      } else {
        setState(() {
          _countdown--;
        });
      }
    });
  }

  String get _getOtpValue {
    return _otpControllers.map((controller) => controller.text).join();
  }

  void _verifyOTP() async {
    String otp = _getOtpValue;
    _logger.d(otp);
    if (widget.isForgotPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResetPasswordPage(
            email: widget.contactInfo,
          ),
        ),
      );
    }
    // OtpVerifyRequest request = OtpVerifyRequest(
    //   refCode: widget.refCode,
    //   otpCode: otp,
    // );
    // try {
    //   EasyLoading.show();

    //   if (widget.isForgotPassword) {
    //     ForgotPasswordOtpVerifyResponse response =
    //         await ForgotPasswordService().forgotPasswordOtpVerify(request);
    //     _logger.d(response);
    //     if (mounted) {
    //       await EasyLoading.showSuccess('OTP verification successful');
    //       // Add delay before navigation

    //       if (mounted) {
    //         // Navigate to reset password page for forgot password flow
    //         Navigator.pushReplacement(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) => ResetPasswordPage(
    //               token: response.data.token,
    //             ),
    //           ),
    //         );
    //       }
    //     }
    //   } else {
    //     RegisterOtpVerifyResponse response =
    //         await RegisterService().registerOtpVerify(request);
    //     _logger.d(response);
    //     if (mounted) {
    //       // Add delay before navigation

    //       if (mounted) {
    //         context.goNamed(Routes.signin.name);
    //         EasyLoading.showSuccess('OTP verification successful');
    //       }
    //     }
    //   }
    // } catch (e) {
    //   _logger.e(e);
    //   EasyLoading.showError('Invalid OTP code');
    // } finally {
    //   EasyLoading.dismiss();
    // }
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: AppColors.background,
        title: Text(
          'ยืนยัน OTP',
          style: AppTextStyles.h3,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'กรุณากรอกรหัส OTP ที่ส่งไปยัง${widget.isEmail ? 'อีเมล' : 'เบอร์โทรศัพท์'}\n${widget.contactInfo}',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 32),

              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  6,
                  (index) => SizedBox(
                    width: 45,
                    height: 56,
                    child: TextField(
                      controller: _otpControllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: '',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AppColors.textSecondary.withOpacity(0.3),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 5) {
                          _focusNodes[index + 1].requestFocus();
                        }
                        if (value.isEmpty && index > 0) {
                          _focusNodes[index - 1].requestFocus();
                        }
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Resend OTP Section
              Center(
                child: Column(
                  children: [
                    Text(
                      'ไม่ได้รับรหัส OTP?',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: _canResend
                          ? () async {
                              // Implement resend OTP logic here
                              // EasyLoading.show();

                              // await RegisterService().resendEmail(
                              //   refCode: widget.refCode,
                              //   action: widget.isForgotPassword
                              //       ? RegisterAction.forgot_password
                              //       : RegisterAction.register,
                              // );
                              // startTimer();
                              // EasyLoading.dismiss();
                            }
                          : null,
                      child: Text(
                        _canResend
                            ? 'ส่งรหัสอีกครั้ง'
                            : 'ส่งรหัสอีกครั้งใน $_countdown วินาที',
                        style: TextStyle(
                          color: _canResend
                              ? AppColors.primary
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Verify Button
              SizedBox(
                width: double.infinity,
                child: AppButton.primaryButton(
                  text: 'ยืนยัน',
                  onPressed: _verifyOTP,
                  enabled: _getOtpValue.length == 6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
