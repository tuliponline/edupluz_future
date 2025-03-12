import 'package:edupluz_future/core/models/category/get_categories_200_response.dart';
import 'package:edupluz_future/core/services/courses/fetch_courses_by_cat.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/features/course/presentation/widget/card_courses_landscape.dart';
import 'package:edupluz_future/features/course_by_category/presentation/course_by_category_screen.dart';
import 'package:edupluz_future/core/models/courses/courses_model.dart'
    as coursesType;
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ListCoursesByCatLandscape extends ConsumerStatefulWidget {
  Item category;
  bool showDetail;
  ListCoursesByCatLandscape({
    super.key,
    required this.category,
    this.showDetail = false,
  });

  @override
  ConsumerState<ListCoursesByCatLandscape> createState() =>
      _ListCoursesByCatLandscapeState();
}

class _ListCoursesByCatLandscapeState
    extends ConsumerState<ListCoursesByCatLandscape> {
  bool _isLoadingMore = false;
  final ScrollController _scrollController = ScrollController();
  coursesType.CoursesModel? coursesModel;
  List<coursesType.Item> items = [];
  int page = 1;

  _fetchCourses() async {
    coursesModel = await fetchCoursesBycat(
      catId: widget.category.id.toString(),
      page: page,
      limit: 10,
    );
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
      _fetchCourses();
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
    Logger().d("items Change ${items.length}");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CourseByCategoryScreen(
                  categoryName: widget.category.name,
                  categoryId: widget.category.id,
                );
              }));
            },
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Text(
                    widget.category.name,
                    style: AppTextStyles.h4.copyWith(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CourseByCategoryScreen(
                        categoryName: widget.category.name,
                        categoryId: widget.category.id,
                      );
                    }));
                  },
                  child: const Icon(
                    LucideIcons.chevron_right,
                    color: AppColors.textPrimary,
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
            height: widget.showDetail ? 158 : 130,
            child: coursesModel == null
                ? _loading()
                : Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: ListView.builder(
                        shrinkWrap: true,
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
                                        coursesModel!.data.meta.totalItems)
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : CardCourseLandscape(
                                    courseId: items[index].id,
                                    title: items[index].name,
                                    subtitle: items[index].description,
                                    imageUrl: items[index].thumbnail.horizontal,
                                    isShowDetail: widget.showDetail,
                                  ),
                          );
                        }),
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
            2,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 16),
              child: CardCourseLandscape(
                courseId: "",
                isShowDetail: widget.showDetail,
                title: "ภาษาจีนเพื่อการท่องเที่ยว ",
                subtitle: '#Skills & Career Development',
                imageUrl: null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
