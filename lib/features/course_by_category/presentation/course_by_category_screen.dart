import 'package:edupluz_future/core/models/courses/courses_model.dart';
import 'package:edupluz_future/core/services/courses/fetch_continue_watch.dart';
import 'package:edupluz_future/core/services/courses/fetch_courses_by_cat.dart';
import 'package:edupluz_future/core/services/courses/fetch_courses_mastery.dart';
import 'package:edupluz_future/core/services/courses/fetch_courses_news.dart';
import 'package:edupluz_future/core/services/courses/fetch_courses_random.dart';
import 'package:edupluz_future/core/services/courses/fetch_courses_top_views.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/features/course_by_category/presentation/widget/course_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CourseByCategoryScreen extends ConsumerStatefulWidget {
  final String categoryName;
  final String? categoryId;
  final bool isEdupluz;
  const CourseByCategoryScreen(
      {super.key,
      required this.categoryName,
      this.categoryId,
      this.isEdupluz = true});

  @override
  ConsumerState<CourseByCategoryScreen> createState() =>
      _CourseByCategoryScreenState();
}

class _CourseByCategoryScreenState
    extends ConsumerState<CourseByCategoryScreen> {
  CoursesModel? coursesModel;
  List<Item> items = [];
  final ScrollController _scrollController = ScrollController();
  int page = 1;
  bool _isLoadingMore = false;

  _fetchCourses() async {
    if (widget.categoryName == "Mastery") {
      coursesModel = await fetchCoursesMastery(
        page: page,
        limit: 10,
      );
    } else if (widget.categoryName == "เรียนต่อ") {
      coursesModel = await fetchContinueWatch(ref: ref, page: page);
    } else if (widget.categoryName == "ยอดนิยม") {
      coursesModel =
          await fetchCoursesTopViews(page: page, isEdupluz: widget.isEdupluz);
    } else if (widget.categoryName == "มาใหม่") {
      coursesModel =
          await fetchCoursesNews(page: page, isEdupluz: widget.isEdupluz);
    } else if (widget.categoryName == "สำหรับคุณ") {
      coursesModel =
          await fetchCoursesRandom(page: page, isEdupluz: widget.isEdupluz);
    } else {
      coursesModel = await fetchCoursesBycat(
        catId: widget.categoryId ?? "",
        page: page,
        limit: 10,
        isEdupluz: widget.isEdupluz,
      );
    }
    items.addAll(coursesModel!.data.items);
    if (mounted) setState(() {});
  }

  void _scrollListener() async {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !_isLoadingMore) {
      Logger().d("Load cat More");

      _loadMoreData();
    }
  }

  void _loadMoreData() async {
    _isLoadingMore = true;
    if (items.length < coursesModel!.data.meta.totalItems) {
      page += 1;
      await _fetchCourses();
    }
    _isLoadingMore = false;
  }

  @override
  void initState() {
    _fetchCourses();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          widget.categoryName,
          style: AppTextStyles.bodyLarge,
        ),
      ),
      body: coursesModel == null
          ? _loading()
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: (coursesModel != null && items.isEmpty)
                  ? Center(
                      child: Text(
                        "ไม่พบคอร์สในหมวดหมู่นี้",
                        style: AppTextStyles.bodyLarge,
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: items.length +
                          (items.length < coursesModel!.data.meta.totalItems
                              ? 1
                              : 0),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            if (index == 0) const SizedBox(height: 16),
                            (index == items.length &&
                                    items.length <
                                        coursesModel!.data.meta.totalItems)
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : CourseCard(
                                    courseId: items[index].id,
                                    courseName: items[index].title,
                                    imageUrl: items[index].thumbnail.horizontal,
                                    duration: items[index].rating.toInt(),
                                    chapters: items[index].chapters,
                                    categories: items[index]
                                        .categories
                                        .map((e) => e.name)
                                        .toList(),
                                    instructorName:
                                        "${items[index].instructor.firstName} ${items[index].instructor.lastName}",
                                  ),
                          ],
                        );
                      }),
            ),
    );
  }

  Widget _loading() {
    return Skeletonizer(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: List.generate(
              10,
              (index) => const CourseCard(
                    courseId: "",
                    courseName: "",
                    imageUrl: null,
                    duration: 0,
                    categories: [],
                    instructorName: "",
                    chapters: [],
                  )),
        ),
      ),
    );
  }
}
