import 'package:edupluz_future/core/models/courses/courses_model.dart';
import 'package:edupluz_future/core/providers/courses/courses_joinings_provider.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/features/course/presentation/widget/catrgory_menu_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyCoursesFilterMenu extends ConsumerWidget {
  int indexSelectes;
  int index;
  String titel;
  int count;
  Function(int) onTap;
  MyCoursesFilterMenu({
    Key? key,
    required this.indexSelectes,
    required this.onTap,
    required this.titel,
    required this.count,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 38,
      child: _menuItem(ref),
    );
  }

  Widget _menuItem(WidgetRef ref) {
    CoursesModel? coursesModel = ref.watch(coursesJoingingProvider);

    return InkWell(
      onTap: () {
        onTap(index);
      },
      child: coursesModel == null
          ? CategoryMenuLoading()
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: (indexSelectes == index)
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
                    titel,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodySmall,
                  ),
                  // const SizedBox(width: 4),
                  // Container(
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  //   decoration: ShapeDecoration(
                  //     color: Colors.white,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(24),
                  //     ),
                  //   ),
                  //   child: Text(
                  //       '${coursesModel == null ? "0" : (coursesModel.data.meta.totalItems > 99) ? "99+" : coursesModel.data.meta.totalItems}',
                  //       textAlign: TextAlign.center,
                  //       style: MyTextTheme.mini(
                  //           color: MyColorTheme.primary,
                  //           fontWeight: FontWeight.w500)),
                  // )
                ],
              ),
            ),
    );
  }
}
