import 'package:edupluz_future/core/models/category/catagories_model.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';

import 'package:flutter/material.dart';

class CategoryMenu extends StatelessWidget {
  int? categorySelectes;
  int index;
  Item category;
  int count;
  Function(int) onTap;
  CategoryMenu(
      {Key? key,
      required this.categorySelectes,
      required this.onTap,
      required this.count,
      required this.index,
      required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: _menuItem(),
    );
  }

  Widget _menuItem() {
    return InkWell(
      onTap: () {
        onTap(index);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: (categorySelectes != null && categorySelectes == index)
              ? AppColors.primary
              : AppColors.cardShadow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              category.name,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall,
            ),
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Text('${(count > 99) ? "99+" : count}',
                  textAlign: TextAlign.center, style: AppTextStyles.bodySmall),
            )
          ],
        ),
      ),
    );
  }
}
