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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class PlanPage extends ConsumerStatefulWidget {
  final Function(bool success) onPaymentComplete;
  const PlanPage({super.key, required this.onPaymentComplete});

  @override
  ConsumerState<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends ConsumerState<PlanPage> {
  ProductsModel? products;

  _getProducts() async {
    try {
      EasyLoading.show();
      products = await GetProductService().getProductBuffet();
    } catch (e) {
      Logger().e(e);
      EasyLoading.showError("เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง");
    } finally {
      EasyLoading.dismiss();
      setState(() {});
    }
  }

  @override
  void initState() {
    _getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แพ็คเกจ'),
        centerTitle: true,
      ),
      body: products == null
          ? Container()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'เลือกแพ็กเกจที่เหมาะกับคุณ',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.h3
                          .copyWith(color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'เริ่มต้นเรียนคอร์สออนไลน์ได้ง่าย ๆ เลือกแพ็กเกจที่ตอบโจทย์การเรียนของคุณ',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildPlanCards(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildPlanCards() {
    return Column(
      children: products?.data.items.map((e) {
            double savePrice = 0;
            int index = products?.data.items.indexOf(e) ?? 0;
            if (index != 0) {}
            return Container(
              child: _buildPlanCard(
                item: e,
                title: e.name,
                price: '฿${e.price}',
                period: 'ต่อเดือน',
                features: [
                  'เข้าถึงคอร์สทั้งหมด',
                  'มีใบประกาศนียบัตร',
                  'อัพเดทคอร์สใหม่ก่อนใคร',
                  if (index == 1) 'ประหยัด ^฿300',
                  if (index == 2) 'ประหยัด ^฿2,700',
                ],
                isPopular: index == (products?.data.items.length ?? 0) - 1,
              ),
            );
          }).toList() ??
          [],
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String price,
    required String period,
    required List<String> features,
    required bool isPopular,
    required Item item,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isPopular
            ? const BorderSide(color: Colors.blue, width: 2)
            : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isPopular)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'แนะนำ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: AppTextStyles.h3.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  period,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...features.map((feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          feature,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _createOrder(context, item);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('เลือกแพ็คเกจ'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _createOrder(BuildContext context, Item item) async {
    final user = ref.watch(userProvider);
    try {
      EasyLoading.show();

      CreateOrder200Response order = await OrdersService().createOrder(
        productId: item.id,
        productName: item.name,
        price: item.price,
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
      <input type="hidden" name="customeremail" value="${user!.data.email}" />
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
            order: order,
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
}
