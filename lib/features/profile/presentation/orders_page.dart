import 'package:edupluz_future/core/enums/courses_enum.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/core/widgets/app_bar/appbar_widget.dart';
import 'package:edupluz_future/features/profile/data/fetch_orders.dart';
import 'package:edupluz_future/features/profile/domain/orders_model.dart';
import 'package:edupluz_future/features/profile/presentation/widget/card_order_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  OrdersModel? ordersData;

  _getOrders() async {
    ordersData = await fetchOrders();
    setState(() {});
  }

  @override
  @override
  void initState() {
    _getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          AppBarWidget(
              prefix: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    LucideIcons.arrow_left,
                    color: AppColors.textPrimary,
                  )),
              title: 'ประวัติการสั่งซื้อ'),
          (ordersData == null)
              ? const Expanded(
                  child: Center(child: CircularProgressIndicator()))
              : (ordersData!.data.items.isEmpty)
                  ? Expanded(
                      child: Center(
                      child: Text(
                        "ยังไม่มีการสั่งซื้อ",
                        style: AppTextStyles.bodyMedium,
                      ),
                    ))
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: ordersData!.data.items.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                CardOrderWidget(
                                  orders: ordersData!.data.items[index],
                                ),
                                const SizedBox(height: 8),
                              ],
                            );
                          })),
        ],
      )),
    );
  }
}
