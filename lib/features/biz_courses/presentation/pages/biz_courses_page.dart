import 'package:edupluz_future/core/models/category/get_categories_200_response.dart';
import 'package:edupluz_future/core/services/category/fetch_category.dart';
import 'package:edupluz_future/core/widgets/course/list_courses_by_cat_landscape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class BizCoursesPage extends ConsumerStatefulWidget {
  const BizCoursesPage({super.key});

  @override
  ConsumerState<BizCoursesPage> createState() => _BizCoursesPageState();
}

class _BizCoursesPageState extends ConsumerState<BizCoursesPage> {
  GetCategories200Response? catagories;
  int showCategory = 5;
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  _fetchCategory() async {
    catagories = await fetchCategories(ref: ref);
    if (showCategory > catagories!.data.items.length) {
      showCategory = catagories!.data.items.length;
    }

    setState(() {});
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
    await Future.delayed(const Duration(seconds: 1));
    if (showCategory < catagories!.data.items.length) {
      showCategory = showCategory + 4;
      if (showCategory > catagories!.data.items.length) {
        showCategory = catagories!.data.items.length;
      }
    }
    setState(() {});
    _isLoadingMore = false;
  }

  @override
  void initState() {
    super.initState();
    _fetchCategory();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("คอร์สจากพาร์ทเนอร์"),
      ),
      body: catagories != null
          ? ListView.builder(
              controller: _scrollController,
              itemCount: showCategory,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    (showCategory < catagories!.data.items.length &&
                            index == showCategory - 1)
                        ? const Center(child: CircularProgressIndicator())
                        : ListCoursesByCatLandscape(
                            category: catagories!.data.items[index],
                            showDetail: false,
                          ),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                );
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
