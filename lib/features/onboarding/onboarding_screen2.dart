import 'package:edupluz_future/constant/app_size.dart';
import 'package:edupluz_future/core/services/storages/storage_services.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Container onBoardingScreen2(BuildContext context) {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/onboarding/bg2.png"),
        fit: BoxFit.cover,
      ),
    ),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-0.00, -0.10),
          end: Alignment(0, 1),
          colors: [Color(0x001D1B1B), Colors.white],
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 28),
                child: InkWell(
                  onTap: () async {
                    await StorageServices.setOpenAppFirstTime(false);
                    context.goNamed(Routes.signin.name);
                  },
                  child: GestureDetector(
                    onTap: () {
                      context.goNamed(Routes.signin.name);
                    },
                    child: Text(
                      "ข้าม",
                      style: AppTextStyles.bodyLarge,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
                height: AppSize.screenHeight(context) / 3.5 + 170,
                child: Column(
                  children: [
                    Text(
                      "เข้าเรียนง่าย ใช้ได้ทุกอุปกรณ์",
                      style: AppTextStyles.h3,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      "สมัครสมาชิก edupluz ง่ายนิดเดียว\nพร้อมรับชมได้ทันที",
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: AppSize.screenHeight(context) / 3.5,
            ),
          )
        ],
      ),
    ),
  );
}
