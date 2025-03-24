import 'package:edupluz_future/core/models/category/get_categories_200_response.dart';
import 'package:edupluz_future/core/models/user/get_user_200_response.dart';
import 'package:edupluz_future/core/providers/user/user_provider.dart';
import 'package:edupluz_future/core/services/auth/authsService_service.dart';
import 'package:edupluz_future/core/services/category/fetch_category.dart';
import 'package:edupluz_future/core/services/storages/login_model/login_model.dart';
import 'package:edupluz_future/core/services/user/get_user_service.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/core/widgets/course/card_courses_random.dart';
import 'package:edupluz_future/core/widgets/course/list_continue_watch.dart';
import 'package:edupluz_future/core/widgets/course/list_courses_by_cat_landscape.dart';
import 'package:edupluz_future/core/widgets/course/list_courses_by_cat_landscape_loading.dart';
import 'package:edupluz_future/core/widgets/course/list_courses_card.dart';
import 'package:edupluz_future/core/widgets/course/list_courses_mastery.dart';
import 'package:edupluz_future/core/widgets/search/search_box.dart';
import 'package:edupluz_future/features/discover/presentation/widget/card_promotion.dart';
import 'package:edupluz_future/features/search/presentation/search_result_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DiscoverScreen extends ConsumerStatefulWidget {
  final Function goSearch;
  const DiscoverScreen({super.key, required this.goSearch});

  @override
  ConsumerState<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends ConsumerState<DiscoverScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearchFocus = false;
  bool _isLoadingMore = false;
  final ScrollController _scrollController = ScrollController();

  GetCategories200Response? catagories;
  int showCategory = 4;

  List<int> showRandomCourses = [];

  GetUser200Response? user;

  bool isLoading = true;

  _fetchUser() async {
    isLoading = true;
    await getUserService(ref);
    isLoading = false;
    setState(() {});
  }

  _fetchCategory() async {
    showRandomCourses = [];
    catagories = await fetchCategories(ref: ref);
    if (showCategory > catagories!.data.items.length) {
      showCategory = catagories!.data.items.length;
    }
    for (int i = 1; i <= catagories!.data.items.length; i++) {
      int counter = (i - 1) % 3; // Calculate the remainder after dividing by 3

      if (counter == 0) {
        showRandomCourses.add(i - 1);
      }
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
    _fetchUser();
    _fetchCategory();
    _scrollController.addListener(_scrollListener);
    _searchFocusNode.addListener(() {
      _isSearchFocus = _searchFocusNode.hasFocus;

      setState(() {}); // Rebuild the widget to update the icon
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GetUser200Response? meData = ref.watch(userProvider);
    return SafeArea(
      child: Container(
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("assets/images/discover/bg.png"),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        (meData == null)
                            ? Skeletonizer(
                                enabled: isLoading,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("ยินดีต้อนรับ",
                                        style: AppTextStyles.bodyMedium
                                            .copyWith(
                                                fontWeight: FontWeight.w500)),
                                    Text('EduPluz Mobile App',
                                        style: AppTextStyles.h4
                                            .copyWith(height: 2)),
                                  ],
                                ),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('สวัสดี',
                                      style: AppTextStyles.bodyMedium.copyWith(
                                          fontWeight: FontWeight.w500)),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Text(
                                        overflow: TextOverflow.ellipsis,
                                        meData.data.firstName == ""
                                            ? "สมาชิก Edupluz"
                                            : '${meData.data.firstName} ${meData.data.lastName}',
                                        style: AppTextStyles.h4.copyWith()),
                                  ),
                                ],
                              ),
                        SizedBox(
                          width: 48,
                          height: 48,
                          child: Icon(
                            LucideIcons.user_round,
                            color: AppColors.textPrimary,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    GestureDetector(
                      onTap: () {
                        Logger().d("Search");
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
                              readOnly: true,
                              textEditingController: _searchController,
                              focusNode: _searchFocusNode,
                              hasFocus: _isSearchFocus,
                              onSearch: (string) {},
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
                    // const SizedBox(
                    //   height: 16,
                    // ),
                    // const CardPromotion(),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
              // const ListContinueWatch(),
              ListCoursesCard(),
              // const SizedBox(
              //   height: 24,
              // ),
              // if (hasCorparate) ListCoursesCroperate(),
              // const SizedBox(
              //   height: 24,
              // ),
              // ListCoursesMastery(),

              const SizedBox(
                height: 24,
              ),
              (catagories == null)
                  ? ListCoursesByCatLandscapeLoading(
                      showDetail: false,
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      primary: false,
                      shrinkWrap: true,
                      itemCount: showCategory +
                          (showCategory < catagories!.data.items.length
                              ? 1
                              : 0),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            (showCategory < catagories!.data.items.length &&
                                    index == showCategory)
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : ListCoursesByCatLandscape(
                                    category: catagories!.data.items[index],
                                    showDetail: false,
                                  ),
                            if (showRandomCourses.contains(index))
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24),
                                child: Column(
                                  children: [
                                    SizedBox(height: 24),
                                    CardCoursesRandom(),
                                  ],
                                ),
                              ),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        );
                      })
            ],
          ),
        ),
      ),
    );
  }
}
