import 'package:edupluz_future/core/enums/courses_enum.dart';
import 'package:edupluz_future/core/models/courses/courses_model.dart';
import 'package:edupluz_future/core/services/courses/fetch_courses_%20favorites.dart';
import 'package:edupluz_future/core/services/courses/fetch_courses_%20joinings.dart';
import 'package:edupluz_future/core/services/courses/fetch_courses_corperate.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/core/widgets/course/my_courses/my_courses_filter_menu.dart';
import 'package:edupluz_future/features/course/presentation/widget/card_courses_landscape.dart';
import 'package:edupluz_future/features/course/presentation/widget/my_courses_list/my_courses_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ListMyCoursesLandscape extends ConsumerStatefulWidget {
  final bool showDetail;
  final bool isBusiness;
  const ListMyCoursesLandscape(
      {super.key, this.showDetail = false, this.isBusiness = false});

  @override
  ConsumerState<ListMyCoursesLandscape> createState() =>
      _ListCoursesByCatLandscapeState();
}

class _ListCoursesByCatLandscapeState
    extends ConsumerState<ListMyCoursesLandscape> {
  bool _isLoadingMore = false;
  final ScrollController _scrollController = ScrollController();
  CoursesModel? coursesModel;
  List<Item> items = [];
  int page = 1;
  int indexSelectesd = 0;

  _fetchCourses() async {
    if (widget.isBusiness) indexSelectesd = 2;
    if (indexSelectesd == 0) {
      coursesModel = await fetchCoursesJoinings(
        page: page,
        limit: 10,
        ref: ref,
      );
    }

    if (indexSelectesd == 1) {
      coursesModel = await fetchCoursesFavorites(
          page: page, limit: 10, ref: ref, sort: SortTypr.desc);
    }
    if (indexSelectesd == 2) {
      coursesModel = await fetchCoursesCorperate(
        page: page,
        limit: 10,
      );
    }

    items.addAll(coursesModel!.data.items);

    if (mounted) setState(() {});
  }

  void _scrollListener() async {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !_isLoadingMore) {
      Logger().d("Load More");

      _loadMoreData();
    }
  }

  void _loadMoreData() async {
    Logger().d("do Load More");

    if (coursesModel != null) {
      Logger().d("totalPages ${coursesModel!.data.meta.totalPages}");
      Logger().d("totalPagesNow ${coursesModel!.data.meta.page}");
      if (page < coursesModel!.data.meta.totalPages) {
        _isLoadingMore = true;
        page += 1;

        await _fetchCourses();

        _isLoadingMore = false;
      }
    }
    if (mounted) setState(() {});
  }

  _updateMycoursesFilter(int index) async {
    if (index != indexSelectesd) {
      coursesModel = null;
      items.clear();
      indexSelectesd = index;
      page = 1;
      await _fetchCourses();

      if (mounted) setState(() {});
      if (_scrollController.positions.isNotEmpty) {
        _scrollController.jumpTo(0);
      }
    }
  }

  @override
  void initState() {
    _fetchCourses();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const MyCoursesListScreen();
            }));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Text(
                  "คอร์สของฉัน",
                  style: AppTextStyles.h2,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Icon(
                  LucideIcons.chevron_right,
                  color: AppColors.background,
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        myCoursesFilterListMenu(),
        const SizedBox(height: 16),
        SizedBox(
            height: widget.showDetail ? 185 : 130,
            child: coursesModel == null
                ? _loading()
                : items.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: items.length +
                              (items.length < coursesModel!.data.meta.totalItems
                                  ? 1
                                  : 0),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: (index == items.length &&
                                      items.length <
                                          coursesModel!.data.meta.totalItems &&
                                      items.isNotEmpty)
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : CardCourseLandscape(
                                      courseId: items[index].id,
                                      isShowDetail: widget.showDetail,
                                      title: items[index].name,
                                      subtitle: items[index].description,
                                      imageUrl:
                                          items[index].thumbnail.horizontal,
                                    ),
                            );
                          },
                        ),
                      )
                    : Container()),
        const SizedBox(height: 24),
      ],
    );
  }

  Padding myCoursesFilterListMenu() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        height: 38,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            ...List.generate(
              3,
              (index) => Row(
                children: [
                  MyCoursesFilterMenu(
                    indexSelectes: indexSelectesd,
                    onTap: (value) {
                      _updateMycoursesFilter(value);
                    },
                    titel: index == 0
                        ? 'คอร์สที่ซื้อแล้ว'
                        : index == 1
                            ? "คอร์สที่บันทึกไว้"
                            : "คอร์สสำหรับองค์กร",
                    count: 99,
                    index: index,
                  ),
                  if (index == 0) const SizedBox(width: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loading() {
    return Skeletonizer(
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              CardCourseLandscape(
                courseId: "",
                isShowDetail: widget.showDetail,
                title: "ภาษาจีนเพื่อการท่องเที่ยว ",
                subtitle: '#Skills & Career Development',
                imageUrl: null,
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              CardCourseLandscape(
                courseId: "",
                isShowDetail: widget.showDetail,
                title: "ภาษาจีนเพื่อการท่องเที่ยว ",
                subtitle: '#Skills & Career Development',
                imageUrl: null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
