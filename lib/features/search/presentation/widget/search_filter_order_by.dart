import 'package:edupluz_future/core/constant/app_size.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/features/search/presentation/widget/order_by_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class SearchOrderBy extends StatefulWidget {
  final bool isMatery;
  final String orderBy;
  final Function(String, bool) onChange;
  const SearchOrderBy(
      {super.key,
      required this.onChange,
      required this.isMatery,
      required this.orderBy});

  @override
  State<SearchOrderBy> createState() => _SearchOrderByState();
}

class _SearchOrderByState extends State<SearchOrderBy> {
  bool isMatery = false;
  String orderBy = "";

  List<Map<String, String>> orderList = [
    {
      "name": "All",
      "value": "",
    },
    {
      "name": "เรียงจากใหม่ไปเก่า",
      "value": "created_at:desc",
    },
    {
      "name": "เรียงจากเก่าไปใหม่",
      "value": "created_at:asc",
    },
    {
      "name": "ก-ฮ",
      "value": "name:asc",
    },
    {
      "name": "ฮ-ก",
      "value": "name:desc",
    },
  ];

  @override
  void initState() {
    isMatery = widget.isMatery;
    orderBy = widget.orderBy;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      color: AppColors.background,
      height: AppSize.screenHeight(context) * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isMatery = false;
                    orderBy = "";
                  });
                },
                child: Text(
                  "รีเซ็ต",
                  style: AppTextStyles.bodyMedium
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                "กรอง",
                style: AppTextStyles.bodyMedium
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(LucideIcons.x, color: AppColors.textPrimary),
              ),
            ],
          ),
          const Divider(color: AppColors.background),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Mastery Course",
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Switch(
                value: isMatery,
                activeColor: AppColors.success,
                inactiveThumbColor: AppColors.buttonSecondary,
                onChanged: (value) {
                  setState(() {
                    isMatery = value;
                  });
                },
              ),
            ],
          ),
          const Divider(color: AppColors.background),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text("เรียงตาม",
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                )),
          ),
          Expanded(
            child: Wrap(
              alignment: WrapAlignment.start,
              direction: Axis.horizontal,
              spacing: 8,
              runSpacing: 8,
              children: orderList.map((item) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      orderBy = item['value']!;
                    });
                  },
                  child: OrderByItem(
                      title: item['name']!,
                      value: item['value']!,
                      orderBy: orderBy),
                );
              }).toList(),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              widget.onChange(orderBy, isMatery);
              setState(() {});

              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 9.5),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "ยืนยัน",
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.background,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
