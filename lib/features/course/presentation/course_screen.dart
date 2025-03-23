import 'package:edupluz_future/core/models/category/get_categories_200_response.dart';
import 'package:edupluz_future/core/services/category/fetch_category.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/core/widgets/app_bar/appbar_widget.dart';
import 'package:edupluz_future/core/widgets/course/card_courses_random.dart';
import 'package:edupluz_future/core/widgets/course/my_courses/list_my_courses_landscape.dart';
import 'package:edupluz_future/core/widgets/toast/snack_bar.dart';
import 'package:edupluz_future/features/course/presentation/widget/categories_menu_list_loading.dart';
import 'package:edupluz_future/features/course/presentation/widget/catrgory_menu.dart';
import 'package:edupluz_future/features/course_by_category/presentation/course_by_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class CourseScreen extends ConsumerStatefulWidget {
  const CourseScreen({
    super.key,
  });
  @override
  ConsumerState<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends ConsumerState<CourseScreen> {
  bool _isLoadingMore = false;
  final ScrollController _scrollController = ScrollController();
  int? categorySelectes;
  GetCategories200Response? catagories;
  int showCategory = 4;
  _fetchCattgories() async {
    EasyLoading.show();
    catagories = await fetchCategories(ref: ref);
    EasyLoading.dismiss();
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
    await Future.delayed(const Duration(seconds: 1));
    if (showCategory < catagories!.data.items.length) {
      showCategory = showCategory + 3;
      if (showCategory > catagories!.data.items.length) {
        showCategory = catagories!.data.items.length;
      }
    }
    setState(() {});
    _isLoadingMore = false;
  }

  void onCategoryChange(int index) {
    setState(() {
      categorySelectes = index;
    });
  }

  @override
  void initState() {
    _fetchCattgories();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: AppBarWidget(
            title: 'คอร์ส',
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'มาเรียนรู้สิ่งใหม่กันเถอะ!!',
                    style: AppTextStyles.h4,
                  ),
                ),
                const SizedBox(height: 16),
                (catagories == null)
                    ? categoriesMenuListLoading(context)
                    : categoriesMenuList(context),
                const SizedBox(
                  height: 16,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: CardCoursesRandom(),
                ),
                const SizedBox(
                  height: 24,
                ),
                const ListMyCoursesLandscape(),
              ],
            ),
          ),
        )
      ],
    ));
  }

  SizedBox categoriesMenuList(
    BuildContext context,
  ) {
    return SizedBox(
      height: 38,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: showCategory +
            (showCategory < catagories!.data.items.length ? 1 : 0),
        itemBuilder: (context, index) {
          return Row(
            children: [
              (index == 0)
                  ? const SizedBox(width: 24)
                  : const SizedBox(width: 0),
              (showCategory < catagories!.data.items.length &&
                      index == showCategory)
                  ? const SizedBox(
                      width: 30, height: 30, child: CircularProgressIndicator())
                  : CategoryMenu(
                      index: index,
                      category: catagories!.data.items[index],
                      categorySelectes: categorySelectes,
                      onTap: (value) {
                        if (catagories!.data.items[index].count > 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return CourseByCategoryScreen(
                                  categoryName:
                                      catagories!.data.items[index].name,
                                  categoryId: catagories!.data.items[index].id,
                                );
                              },
                            ),
                          );
                        } else {
                          toast(context,
                              text: "ไม่มีคอร์สในหมวดหมู่นี้",
                              style: AppTextStyles.bodyMedium
                                  .copyWith(color: AppColors.primary));
                        }
                      },
                    ),
              (index == catagories!.data.items.length - 1)
                  ? const SizedBox(width: 24)
                  : const SizedBox(width: 7),
            ],
          );
        },
      ),
    );
  }
}
