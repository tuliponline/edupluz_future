import 'package:edupluz_future/core/models/category/get_categories_200_response.dart';
import 'package:edupluz_future/core/services/category/fetch_category.dart';
import 'package:edupluz_future/core/services/search/search_service.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/widgets/app_bar/appbar_widget.dart';
import 'package:edupluz_future/core/widgets/course/card_courses_width.dart';
import 'package:edupluz_future/core/widgets/course/card_courses_width_loading.dart';
import 'package:edupluz_future/core/widgets/search/search_box.dart';
import 'package:edupluz_future/features/search/presentation/widget/cat_menu_item.dart';
import 'package:edupluz_future/features/search/presentation/widget/cat_menu_list_loading.dart';
import 'package:edupluz_future/features/search/presentation/widget/search_filter_order_by.dart';
import 'package:edupluz_future/features/search/presentation/widget/search_not_found.dart';

import 'package:edupluz_future/core/models/courses/courses_model.dart'
    as courses_type;
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class SearchResultPage extends ConsumerStatefulWidget {
  const SearchResultPage({super.key});

  @override
  ConsumerState<SearchResultPage> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchResultPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearchFocus = false;

  bool _isLoadingMore = false;
  final ScrollController _scrollController = ScrollController();

  int? catSelect;
  GetCategories200Response? catagories;
  courses_type.CoursesModel? coursesModel;
  List<courses_type.Item> courses = [];
  int page = 1;

  bool isMastery = false;
  String orderBy = "";

  _fetchCategory() async {
    catagories = await fetchCategories(ref: ref);
    setState(() {});
  }

  _doSearch({
    required String value,
  }) async {
    coursesModel = await SearchService().searchWithKeyword(
        keyword: value, page: page, orderBy: orderBy, isMastery: isMastery);
    if (coursesModel != null) {
      courses.addAll(coursesModel!.data.items);
    }
    Logger().d("cerentPage ${coursesModel!.data.meta.page}");
    Logger().d("totalPage ${coursesModel!.data.meta.totalPages}");
    Logger().d("totalItem ${coursesModel!.data.meta.totalItems}");
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
    if (courses.length < coursesModel!.data.meta.totalItems) {
      page = page + 1;
      await _doSearch(
        value: _searchController.text,
      );
    }
    _isLoadingMore = false;
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    _fetchCategory();
    _doSearch(value: _searchController.text);
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
              prefix: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(LucideIcons.arrow_left,
                      color: AppColors.textPrimary)),
              title: 'ค้นหา',
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Expanded(
                          child: SearchBox(
                            autoFocus: true,
                            focusNode: _searchFocusNode,
                            textEditingController: _searchController,
                            onSearch: (keword) {
                              _searchFocusNode.canRequestFocus = false;
                              page = 1;
                              courses.clear();
                              coursesModel = null;
                              setState(() {});

                              _doSearch(value: keword);
                            },
                            readOnly: false,
                            hasFocus: _isSearchFocus,
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return SearchOrderBy(
                                    isMatery: isMastery,
                                    orderBy: orderBy,
                                    onChange: (orderBy, isMastery) async {
                                      this.isMastery = isMastery;
                                      this.orderBy = orderBy;
                                      page = 1;
                                      courses.clear();
                                      coursesModel = null;

                                      setState(() {});

                                      _doSearch(value: _searchController.text);
                                    },
                                  );
                                });
                          },
                          child: Container(
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
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: (coursesModel == null)
                          ? _loading()
                          : (courses.isEmpty)
                              ? const SearchNotFound()
                              : ListView.builder(
                                  controller: _scrollController,
                                  itemCount: coursesModel == null
                                      ? 0
                                      : courses.length +
                                          (courses.length <
                                                  coursesModel!
                                                      .data.meta.totalItems
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

  SizedBox catMenuList() {
    return SizedBox(
      height: 32,
      child: catagories == null
          ? catMenuListLoading()
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: catagories!.data.items.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      catSelect = index;
                    });
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: index == 0 ? 24 : 8,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            catSelect = index;
                          });
                        },
                        child: cetMenuItem(
                            name: catagories!.data.items[index].name,
                            inSelected: catSelect == index),
                      ),
                      SizedBox(
                        width:
                            index == catagories!.data.items.length - 1 ? 24 : 0,
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
