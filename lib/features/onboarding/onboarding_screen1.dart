import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:edupluz_future/constant/app_size.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/core/widgets/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Stack onBoardingScreen1(BuildContext context) {
  return Stack(
    children: [
      Lottie.asset(
        'assets/splash/splash.json',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
      BlurryContainer(
        child: Container(),
        blur: 4,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        elevation: 0,
        padding: const EdgeInsets.all(8),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        width: double.infinity,
        color: Colors.white.withOpacity(0.8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 120,
                      child: Image.asset("assets/logo/edupluz_logo.png")),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "การเรียนรู้\nไร้ขีดจำกัด\nที่ Edupluz",
                      style: AppTextStyles.h2,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: AppSize.screenHeight(context) / 3.5,
            )
          ],
        ),
      ),
    ],
  );
}
