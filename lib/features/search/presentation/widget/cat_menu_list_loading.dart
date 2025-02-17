import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

Widget catMenuListLoading() {
  return Skeletonizer(
    child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Row(
            children: [
              SizedBox(
                width: index == 0 ? 24 : 8,
              ),
              Container(
                height: 32,
                width: 70,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: AppColors.background,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              SizedBox(width: index == 9 ? 24 : 0),
            ],
          );
        }),
  );
}
