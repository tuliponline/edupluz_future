import 'package:edupluz_future/core/models/courses/course_model.dart';
import 'package:edupluz_future/core/models/courses/create_order_200_response.dart';
import 'package:edupluz_future/core/models/products/products_model.dart';
import 'package:edupluz_future/core/models/user/get_user_200_response.dart';
import 'package:edupluz_future/core/providers/user/user_provider.dart';
import 'package:edupluz_future/core/services/order/orders_service.dart';
import 'package:edupluz_future/core/services/products/get_product_service.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/core/widgets/dialogs/info_dialog.dart';
import 'package:edupluz_future/features/payment/presentation/pages/payment_page.dart';
import 'package:edupluz_future/features/plan/presentation/pages/plan_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:url_launcher/url_launcher.dart';

class BuySliderPackage extends ConsumerStatefulWidget {
  final Function(bool success) onPaymentComplete;
  const BuySliderPackage({
    super.key,
    required this.onPaymentComplete,
  });

  @override
  ConsumerState<BuySliderPackage> createState() => _BuySliderPackageState();
}

class _BuySliderPackageState extends ConsumerState<BuySliderPackage> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final GlobalKey<SlideActionState> key = GlobalKey();
        return Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SlideAction(
              key: key,
              height: 56,
              innerColor: AppColors.background,
              outerColor: AppColors.primary,
              sliderButtonIcon: const Icon(
                LucideIcons.shopping_cart,
                size: 18,
                color: AppColors.primary,
              ),
              sliderRotate: false,
              sliderButtonIconSize: 14,
              sliderButtonIconPadding: 10,
              onSubmit: () {
                key.currentState!.reset();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlanPage(
                      onPaymentComplete: widget.onPaymentComplete,
                    ),
                  ),
                );

                return;
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "> > >",
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.background,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "สไลด์เพื่อเลือกซื้อแพ็คเกจ",
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.background,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
