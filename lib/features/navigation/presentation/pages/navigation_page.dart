import 'dart:io';

import 'package:edupluz_future/core/widgets/dialogs/confirm_dialog.dart';
import 'package:edupluz_future/features/course/presentation/course_screen.dart';
import 'package:edupluz_future/features/course/presentation/widget/my_courses_list/my_courses_list_screen.dart';
import 'package:edupluz_future/features/discover/presentation/discover_screen.dart';
import 'package:edupluz_future/features/navigation/presentation/widget/main_nav_bar.dart';
import 'package:edupluz_future/features/profile/presentation/profile_screen.dart';
import 'package:edupluz_future/features/search/presentation/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:shake_to_report/model/report_form_model.dart';
import 'package:shake_to_report/shake_to_report.dart';

import '../../../../configs/alice_init.dart';

class NavigationPage extends ConsumerStatefulWidget {
  const NavigationPage({super.key});
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends ConsumerState<NavigationPage>
    with TickerProviderStateMixin {
  TabController? controller;
  int currentPage = 0;

  updateSelectIndex(int index) {
    Logger().d("updateSelectIndex $index");
    setState(() {
      controller!.index = index;
      currentPage = index;
    });
  }

  // _fetchUserMe() async {
  //   if (ref.read(userMeProvider.notifier).state == null) {
  //     await fetchUserMe(ref);
  //   }
  // }

  @override
  void initState() {
    // _fetchUserMe();
    super.initState();
    controller = TabController(initialIndex: 0, length: 4, vsync: this);
    ShakeToReport.initShakeListener(
      onSubmit: (ReportFormData formData) {
        alice.showInspector();
      },
      shakeThreshold: 40.0, // Optional: Set the shake sensitivity
      takeScreenshot: true, // Optional: Enable screenshot capture
    );
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      DiscoverScreen(
        goSearch: updateSelectIndex,
      ),
      // const Center(
      //   child: Text("live"),
      // ),
      const CourseScreen(),
      SearchScreen(),
      ProfileScreen(),
    ];
    //   DiscoverScreen(
    //     goSearch: updateSelectIndex,
    //   ),
    //   const CourseScreen(),
    //   const MyCoursesListScreen(isBusiness: true, isNav: true,),
    //   const SearchScreen(),
    //   const ProfileScreen(),
    // ];
    return PopScope(
      canPop: false,
      onPopInvoked: (value) async {
        bool confirm = await confirmDialog(
          context,
          title: "ออกจาก EDUPLUZ",
          content: "คุณต้องการออกจากแอปหรือไม่?",
          warning: false,
        );
        if (confirm) {
          // colse app
          exit(0);
        }
      },
      child: Scaffold(
        body: (controller == null)
            ? Container()
            : TabBarView(
                controller: controller,
                physics: const NeverScrollableScrollPhysics(),
                children: pages,
              ),
        bottomNavigationBar: MainNavBar(
            selectedIndex: currentPage, onTabChange: updateSelectIndex),
      ),
    );
  }
}
