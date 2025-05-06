import 'package:edupluz_future/core/enums/discover_filter.dart';
import 'package:edupluz_future/core/models/courses/courses_model.dart';
import 'package:edupluz_future/core/services/courses/fetch_courses.dart';
import 'package:edupluz_future/core/widgets/course/card_courses_portrait.dart';
import 'package:edupluz_future/features/course/presentation/widget/card_courses_landscape.dart';
import 'package:edupluz_future/features/discover/presentation/widget/filter_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ListCoursesCard extends ConsumerStatefulWidget {
  bool showDetail;
  bool landscape;
  ListCoursesCard({
    this.showDetail = false,
    this.landscape = false,
    super.key,
  });

  @override
  ConsumerState<ListCoursesCard> createState() => _ListCoursesLandscapeState();
}

class _ListCoursesLandscapeState extends ConsumerState<ListCoursesCard> {
  bool _isLoadingMore = false;
  final ScrollController _scrollController = ScrollController();
  CoursesModel? coursesModel;
  List<Item> items = [];
  int page = 1;

  DiscoverFilter _selectedFilter = DiscoverFilter.all;

  _updateDiscoverFilter(DiscoverFilter filter) async {
    setState(() {
      coursesModel = null;
      items.clear();
      _selectedFilter = filter;
    });
    await _fetchCourses(page);
  }

  _fetchCourses(int page) async {
    Logger().d("Fetching Courses");
    late CoursesModel courses;
    if (_selectedFilter == DiscoverFilter.all) {
      courses = await fetchCourses(
        page: page,
        orderBy: "created_at:asc",
        limit: 10,
      );
    } else if (_selectedFilter == DiscoverFilter.popular) {
      courses = await fetchCourses(
        page: page,
        orderBy: "views:desc",
        limit: 10,
      );
    } else if (_selectedFilter == DiscoverFilter.newest) {
      courses = await fetchCourses(
        page: page,
        orderBy: "created_at:desc",
        limit: 10,
      );
    } else if (_selectedFilter == DiscoverFilter.free) {
      courses = await fetchCourses(
        page: page,
        filter: "is_free:true",
        orderBy: "price:asc",
        limit: 10,
      );
    }
    coursesModel = courses;
    items.addAll(courses.data.items);

    if (mounted) {
      setState(() {});
    }
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
    _isLoadingMore = true;

    Logger().d("items.length ${items.length}");

    if (items.length < coursesModel!.data.meta.totalItems) {
      page += 1;
      _fetchCourses(page);
    }

    _isLoadingMore = false;
  }

  @override
  void initState() {
    _fetchCourses(page);
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
      children: [
        FilterMenu(
          height: 38,
          discoverFilter: _selectedFilter,
          onTap: _updateDiscoverFilter,
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
            height: widget.landscape
                ? widget.showDetail
                    ? 185
                    : 130
                : 198,
            child: (coursesModel == null)
                ? _loading()
                : Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length +
                          (items.length < coursesModel!.data.meta.totalItems
                              ? 1
                              : 0),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: (items.length <
                                      coursesModel!.data.meta.totalItems &&
                                  index == items.length)
                              ? widget.landscape
                                  ? SizedBox(
                                      width: 230,
                                      height: 130,
                                      child: const Center(
                                          child: CircularProgressIndicator()),
                                    )
                                  : SizedBox(
                                      width: 132,
                                      height: 198,
                                      child: const Center(
                                          child: CircularProgressIndicator()),
                                    )
                              : widget.landscape
                                  ? CardCourseLandscape(
                                      instructor:
                                          "${items[index].instructor.firstName} ${items[index].instructor.lastName}",
                                      courseId: items[index].id,
                                      isShowDetail: widget.showDetail,
                                      title: items[index].title,
                                      subtitle: items[index].description,
                                      imageUrl:
                                          items[index].thumbnail.horizontal,
                                    )
                                  : CardCoursesPortrait(
                                      instructor:
                                          "${items[index].instructor.firstName} ${items[index].instructor.lastName}",
                                      courseId: items[index].id,
                                      title: items[index].title,
                                      imageUrl: items[index].thumbnail.vertical,
                                    ),
                        );
                      },
                    ),
                  )),
      ],
    );
  }

  Widget _loading() {
    return Skeletonizer(
      child: Padding(
        padding: const EdgeInsets.only(left: 24),
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: List.generate(
            widget.landscape ? 2 : 4,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 16),
              child: widget.landscape
                  ? CardCourseLandscape(
                      instructor: "ภาษาจีนเพื่อการท่องเที่ยว ",
                      courseId: "",
                      isShowDetail: widget.showDetail,
                      title: "ภาษาจีนเพื่อการท่องเที่ยว ",
                      subtitle: '#Skills & Career Development',
                      imageUrl: null,
                    )
                  : const CardCoursesPortrait(
                      courseId: "",
                      imageUrl: null,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
