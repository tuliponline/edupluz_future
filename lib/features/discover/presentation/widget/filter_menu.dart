import 'package:edupluz_future/core/enums/discover_filter.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class FilterMenu extends StatelessWidget {
  final DiscoverFilter discoverFilter;
  final int height;
  Function(DiscoverFilter) onTap;
  FilterMenu({
    Key? key,
    required this.discoverFilter,
    required this.onTap,
    this.height = 38,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.toDouble(),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          _menuItem(
            icon: LucideIcons.layout_grid,
            isFofus: discoverFilter == DiscoverFilter.all,
            title: "ทั้งหมด",
            onTap: () {
              if (discoverFilter != DiscoverFilter.all) {
                onTap(DiscoverFilter.all);
              }
            },
          ),
          const SizedBox(width: 8),
          _menuItem(
            icon: LucideIcons.star,
            isFofus: discoverFilter == DiscoverFilter.popular,
            title: "ยอดนิยม",
            onTap: () {
              if (discoverFilter != DiscoverFilter.popular) {
                onTap(DiscoverFilter.popular);
              }
            },
          ),
          const SizedBox(width: 8),
          _menuItem(
            icon: LucideIcons.sparkles,
            isFofus: discoverFilter == DiscoverFilter.newest,
            title: "มาใหม่",
            onTap: () {
              if (discoverFilter != DiscoverFilter.newest) {
                onTap(DiscoverFilter.newest);
              }
            },
          ),
          const SizedBox(width: 8),
          _menuItem(
            icon: LucideIcons.sparkles,
            isFofus: discoverFilter == DiscoverFilter.free,
            title: "คอร์สฟรี",
            onTap: () {
              if (discoverFilter != DiscoverFilter.free) {
                onTap(DiscoverFilter.free);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _menuItem(
      {required IconData icon,
      required String title,
      required Function onTap,
      required bool isFofus}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: isFofus
              ? AppColors.primary
              : AppColors.primary.withValues(alpha: 0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isFofus ? Colors.white : AppColors.primary,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.w500,
                color: isFofus ? Colors.white : AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
