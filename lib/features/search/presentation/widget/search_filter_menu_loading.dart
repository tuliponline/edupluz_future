import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchFilterMenuLoading extends StatelessWidget {
  SearchFilterMenuLoading({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: SizedBox(
        height: 110,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, index) {
            return Row(
              children: [
                SizedBox(
                  width: index == 0 ? 24 : 8,
                ),
                _menuItem(
                  title: "Loading data",
                  image: "assets/icons/search/foryou.png",
                  index: index,
                  isSelcet: false,
                ),
                SizedBox(
                  width: index == 3 ? 24 : 0,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Container _menuItem(
      {required String title,
      required String image,
      required bool isSelcet,
      required int index}) {
    return Container(
      width: 110,
      height: 110,
      decoration: ShapeDecoration(
        color: isSelcet ? AppColors.primary : AppColors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            SizedBox(
              width: 110,
              height: 110,
              child: Text(title,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                  )),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: SizedBox(
                width: 50,
                height: 50,
                child: Image.asset(
                  image,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
