import 'package:edupluz_future/core/services/search/search_filter_menu_data.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class SearchFilterMenu extends StatelessWidget {
  List<SearchFilterMenuModel> searchFilterMenuData;
  int selectFilter;
  Function selectFilterMenu;
  SearchFilterMenu(
      {super.key,
      required this.searchFilterMenuData,
      required this.selectFilter,
      required this.selectFilterMenu});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: searchFilterMenuData.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              SizedBox(
                width: index == 0 ? 24 : 8,
              ),
              _menuItem(
                title: searchFilterMenuData[index].title,
                image: searchFilterMenuData[index].image,
                index: index,
                isSelcet: index == selectFilter,
              ),
              SizedBox(
                width: index == searchFilterMenuData.length - 1 ? 24 : 0,
              ),
            ],
          );
        },
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
        color: isSelcet
            ? AppColors.primary.withValues(alpha: 0.2)
            : AppColors.divider.withValues(alpha: 0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: InkWell(
        onTap: () => selectFilterMenu(index),
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
                      color:
                          isSelcet ? AppColors.primary : AppColors.textPrimary,
                    )),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.asset(
                    color: isSelcet ? AppColors.primary : AppColors.textPrimary,
                    image,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
