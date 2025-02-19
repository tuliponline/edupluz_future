import 'package:edupluz_future/core/models/courses/courses_model.dart';
import 'package:edupluz_future/core/services/courses/fetch_courses_%20favorites.dart';
import 'package:edupluz_future/core/services/courses/fetch_courses_%20joinings.dart';
import 'package:edupluz_future/core/services/courses/fetch_courses_corperate.dart';
import 'package:edupluz_future/features/course_by_category/presentation/widget/course_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FavoriteCourses extends ConsumerStatefulWidget {
  final bool isFavorite;
  final bool isBusiness;
  const FavoriteCourses(
      {super.key, this.isFavorite = false, this.isBusiness = false});

  @override
  ConsumerState<FavoriteCourses> createState() => _FavoriteCoursesState();
}

class _FavoriteCoursesState extends ConsumerState<FavoriteCourses> {
  CoursesModel? coursesModel;
  List<Item> items = [];
  final ScrollController _scrollController = ScrollController();
  int page = 1;
  bool _isLoadingMore = false;

  _fetchCourses() async {
    if (widget.isFavorite) {
      coursesModel ??= await fetchCoursesFavorites(
        page: page,
        limit: 10,
        ref: ref,
      );
    } else if (widget.isBusiness) {
      coursesModel ??= await fetchCoursesCorperate(
        page: page,
        limit: 10,
      );
    } else {
      coursesModel ??= await fetchCoursesJoinings(
        page: page,
        limit: 10,
        ref: ref,
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
    if (page < coursesModel!.data.meta.totalPages) {
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
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return coursesModel == null
        ? _loading()
        : Padding(
            padding: const EdgeInsets.all(24),
            child: ListView.builder(
                shrinkWrap: true,
                controller: _scrollController,
                itemCount: items.length +
                    (items.length < coursesModel!.data.meta.totalItems ? 1 : 0),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      (index == items.length &&
                              items.length < coursesModel!.data.meta.totalItems)
                          ? const Center(child: CircularProgressIndicator())
                          : CourseCard(
                              courseId: items[index].id,
                              courseName: items[index].name,
                              imageUrl: items[index].thumbnail.horizontal,
                              duration: items[index].duration,
                              chapters: items[index].chapters,
                              categories: items[index].categories,
                              instructorName:
                                  "${items[index].instructor.firstName} ${items[index].instructor.lastName}",
                            ),
                    ],
                  );
                }),
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
