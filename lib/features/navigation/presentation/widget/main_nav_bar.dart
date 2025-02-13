import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainNavBar extends StatelessWidget {
  int selectedIndex;

  void Function(int)? onTabChange;

  MainNavBar(
      {super.key, required this.selectedIndex, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Colors.black.withOpacity(.1),
          )
        ],
      ),
      child: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
          child: GNav(
            tabBorderRadius: 12,
            gap: 4,
            rippleColor: AppColors.background,
            hoverColor: AppColors.background,
            backgroundColor: AppColors.background,
            activeColor: AppColors.buttonText,
            iconSize: 16,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: AppColors.primary,
            color: AppColors.primary,
            tabs: const [
              GButton(
                icon: LucideIcons.house,
                text: 'หน้าแรก',
              ),
              GButton(
                icon: LucideIcons.radio,
                text: 'เรียนสด',
              ),
              GButton(
                icon: LucideIcons.book_marked,
                text: 'คอร์ส',
              ),
              // GButton(
              //   icon: LucideIcons.handshake,
              //   text: 'องค์กร',
              // ),
              GButton(
                icon: LucideIcons.search,
                text: 'ค้นหา',
              ),
              GButton(
                icon: LucideIcons.square_user_round,
                text: 'โปรไฟล์',
              ),
            ],
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              onTabChange!(index);
            },
          ),
        ),
      ),
    );
  }
}
