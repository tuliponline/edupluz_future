import 'package:edupluz_future/features/course/presentation/widget/catrgory_menu_loading.dart';
import 'package:flutter/material.dart';

SizedBox categoriesMenuListLoading(BuildContext context) {
  return SizedBox(
    height: 38,
    width: MediaQuery.of(context).size.width,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (context, index) {
        return Row(
          children: [
            (index == 0) ? const SizedBox(width: 24) : const SizedBox(width: 0),
            CategoryMenuLoading(),
            (index == 3) ? const SizedBox(width: 24) : const SizedBox(width: 7),
          ],
        );
      },
    ),
  );
}
