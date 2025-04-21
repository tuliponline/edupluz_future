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

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:url_launcher/url_launcher.dart';

class BuySlider extends ConsumerStatefulWidget {
  final CourseModel course;
  final Function(bool success) onPaymentComplete;
  const BuySlider({
    super.key,
    required this.course,
    required this.onPaymentComplete,
  });

  @override
  ConsumerState<BuySlider> createState() => _BuySliderState();
}

class _BuySliderState extends ConsumerState<BuySlider> {
  late CourseModel course;
  @override
  void initState() {
    // TODO: implement initState
    course = widget.course;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GetUser200Response? user = ref.watch(userProvider);
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
                // _launchUrl();
                _createOrder(context, user!);
                return;
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Spacer(),
                    Text(
                      "> > >",
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.background,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "สไลด์เพื่อซื้อคอร์สนี้",
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.background,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "฿ ${course.data.price}",
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.background,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _createOrder(BuildContext context, GetUser200Response user) async {
    try {
      EasyLoading.show();
      ProductsModel productsModel =
          await GetProductService().getProductByCourseId(course.data.id);
      CreateOrder200Response order = await OrdersService().createOrder(
        productId: productsModel.data.items[0].id,
        productName: productsModel.data.items[0].name,
        price: productsModel.data.items[0].price,
      );

      EasyLoading.dismiss();

      final paymentHtml = '''
 <html>
  <head>
    <title>EPAYLINK Testing</title>
    <style>
      input[type="submit"] { display: none; }
    </style>
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <form method="post" action="${order.data.merchantUrl}">
    <input type="hidden" name="returnurl" value="${dotenv.env['PAY_SOLUTION_RETURN_URL']}">
      <input type="hidden" name="refno" value="${order.data.referenceNo}" />
      <input type="hidden" name="merchantid" value="${order.data.merchantId}" />
      <input type="hidden" name="customeremail" value="${user.data.email}" />
      <input type="hidden" name="channel" value="full" />
      <input type="hidden" name="cc" value="00" />
      <input type="hidden" name="productdetail" value="${order.data.productName}" />
      <input type="hidden" name="total" value="${order.data.price}" />
      <input type="submit" name="Submit" value="Confirm Order" />
    </form>
  </body>
</html>
    ''';
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentScreen(
            paymentHtml: paymentHtml,
            onPaymentComplete: (success) async {
              if (success) {
                Logger().d("payment success");
                widget.onPaymentComplete(true);
              } else {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text('การชำระเงินล้มเหลว กรุณาลองใหม่อีกครั้ง')),
                  );
                  widget.onPaymentComplete(false);
                }
              }
            },
          ),
        ),
      );
    } catch (e) {
      EasyLoading.dismiss();
      Logger().e(e);
      // error dialog
      await showDialog(
          context: context,
          builder: (context) {
            return InfoDialog(
              testCenter: true,
              callback: (value) {
                Navigator.pop(context);
              },
              title: "ผิดพลาด",
              detail: "ไม่สามารถสร้างคำสั่งซื้อได้ โปรดลองใหม่อีกครั้ง",
            );
          });
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> _launchUrl() async {
    String url = "https://edupluz.com/th/course/${course.data.slug}";
    Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }
}
