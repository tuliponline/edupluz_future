import 'package:edupluz_future/core/services/courses/fetch_courses_mastery.dart';
import 'package:edupluz_future/core/services/courses/fetch_courses_news.dart';
import 'package:edupluz_future/core/services/courses/fetch_courses_random.dart';
import 'package:edupluz_future/core/services/courses/fetch_courses_top_views.dart';
import 'package:edupluz_future/core/services/search/search_filter_menu_data.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/core/widgets/app_bar/appbar_widget.dart';
import 'package:edupluz_future/core/widgets/course/card_courses_width.dart';
import 'package:edupluz_future/core/widgets/course/card_courses_width_loading.dart';
import 'package:edupluz_future/core/widgets/search/search_box.dart';
import 'package:edupluz_future/features/course_by_category/presentation/course_by_category_screen.dart';
import 'package:edupluz_future/features/search/presentation/search_result_page.dart';
import 'package:edupluz_future/features/search/presentation/widget/search_filter_menu.dart';
import 'package:edupluz_future/features/search/presentation/widget/search_filter_menu_loading.dart';
import 'package:edupluz_future/core/models/courses/courses_model.dart'
    as courses_type;
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:logger/logger.dart';

class SearchScreen extends StatefulWidget {
  final bool isEdupluz;
  const SearchScreen({super.key, this.isEdupluz = true});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearchFocus = false;

  bool _isLoadingMore = false;
  final ScrollController _scrollController = ScrollController();

  courses_type.CoursesModel? coursesModel;
  List<courses_type.Item> courses = [];
  int page = 1;
  bool firstTime = true;

  List<SearchFilterMenuModel> searchFilterMenu = searchFilterMenuData;
  int selectFilter = 0;

  _updateSelectFilter(int index) {
    if (index != selectFilter) {
      setState(() {
        selectFilter = index;
        coursesModel = null;
        courses = [];
        page = 1;
      });

      _getCourses();
    }
  }

  _getCourses() async {
    Logger().d("Fetching Courses");
    if (selectFilter == 0) {
      coursesModel =
          await fetchCoursesTopViews(page: page, isEdupluz: widget.isEdupluz);
    } else if (selectFilter == 1) {
      coursesModel =
          await fetchCoursesNews(page: page, isEdupluz: widget.isEdupluz);
    } else if (selectFilter == 2) {
      coursesModel =
          await fetchCoursesRandom(page: page, isEdupluz: widget.isEdupluz);
    }

    if (coursesModel != null) {
      courses.addAll(coursesModel!.data.items);
    }
    firstTime = false;
    setState(() {});
  }

  void _scrollListener() async {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !_isLoadingMore) {
      Logger().d("Load More courses");

      _loadMoreData();
    }
  }

  void _loadMoreData() async {
    _isLoadingMore = true;
    Logger().d("courses.length ${courses.length}");
    Logger().d(
        "coursesModel?.data.meta.totalItems ${coursesModel?.data.meta.totalItems}");
    if (courses.length < coursesModel!.data.meta.totalItems) {
      page = page + 1;
      await _getCourses();
    }
    _isLoadingMore = false;
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    _getCourses();
    _searchFocusNode.addListener(() {
      _isSearchFocus = _searchFocusNode.hasFocus;
      setState(() {}); // Rebuild the widget to update the icon
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBarWidget(
              title: 'ค้นหา',
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SearchResultPage()));
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: SearchBox(
                              autoFocus: false,
                              focusNode: _searchFocusNode,
                              textEditingController: _searchController,
                              onSearch: (keword) {
                                _searchFocusNode.canRequestFocus = false;
                                page = 1;
                                courses.clear();
                                coursesModel = null;
                                setState(() {});
                              },
                              readOnly: true,
                              hasFocus: _isSearchFocus,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Container(
                            width: 48,
                            height: 48,
                            padding: const EdgeInsets.all(12),
                            decoration: ShapeDecoration(
                              color: AppColors.primary.withValues(alpha: 0.2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            child: const Icon(
                              LucideIcons.settings_2,
                              color: AppColors.primary,
                              size: 24,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Text(
                          'Feature Courses',
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  (firstTime)
                      ? SearchFilterMenuLoading()
                      : SearchFilterMenu(
                          searchFilterMenuData: searchFilterMenu,
                          selectFilter: selectFilter,
                          selectFilterMenu: _updateSelectFilter,
                        ),
                  const SizedBox(height: 24),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CourseByCategoryScreen(
                            categoryName: searchFilterMenu[selectFilter].title,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: IntrinsicWidth(
                        child: Row(
                          children: [
                            Text(searchFilterMenu[selectFilter].title,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w600,
                                )),
                            const SizedBox(width: 8),
                            const Icon(
                              LucideIcons.chevron_right,
                              size: 24,
                              color: AppColors.textPrimary,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: (coursesModel == null)
                          ? _loading()
                          : ListView.builder(
                              controller: _scrollController,
                              itemCount: coursesModel == null
                                  ? 0
                                  : courses.length +
                                      (courses.length <
                                              coursesModel!.data.meta.totalItems
                                          ? 1
                                          : 0),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    (courses.length <
                                                coursesModel!
                                                    .data.meta.totalItems &&
                                            index == courses.length)
                                        ? const CircularProgressIndicator()
                                        : CardCoursesWidth(
                                            course: courses[index],
                                          ),
                                    const SizedBox(height: 8),
                                  ],
                                );
                              },
                            ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView _loading() {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Column(
          children: [
            CardCoursesWidthLoading(),
            const SizedBox(height: 8),
          ],
        );
      },
    );
  }
}
