import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/features/course/presentation/widget/my_courses_list/favorite_courses.dart';

import 'package:flutter/material.dart';

class MyCoursesListScreen extends StatefulWidget {
  final bool isBusiness;
  final bool isHomePage;
  const MyCoursesListScreen(
      {super.key, this.isBusiness = false, this.isHomePage = false});

  @override
  State<MyCoursesListScreen> createState() => _MyCoursesListScreenState();
}

class _MyCoursesListScreenState extends State<MyCoursesListScreen> {
  int page = 0;

  _initeData() {
    if (widget.isBusiness) {
      setState(() {
        page = 2;
      });
    }
  }

  @override
  void initState() {
    _initeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: page,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.background,
          title: Text(
            (widget.isHomePage && widget.isBusiness)
                ? "คอร์สสำหรับองค์กร"
                : 'คอร์สของฉัน',
            style: AppTextStyles.h2,
          ),
          bottom: (widget.isHomePage && widget.isBusiness)
              ? null
              : const TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: UnderlineTabIndicator(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24)),
                    borderSide: BorderSide(
                      width: 3,
                      color: AppColors.primary,
                    ),
                  ),
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.textDisabled,
                  tabs: <Widget>[
                    Tab(
                      text: "คอร์สที่ซื้อแล้ว",
                    ),
                    Tab(
                      text: "คอร์สที่บันทึกไว้",
                    ),
                    Tab(
                      text: "คอร์สสำหรับองค์กร",
                    ),
                  ],
                ),
        ),
        body: const TabBarView(
          children: <Widget>[
            FavoriteCourses(),
            FavoriteCourses(isFavorite: true),
            FavoriteCourses(isBusiness: true),
          ],
        ),
      ),
    );
  }
}
