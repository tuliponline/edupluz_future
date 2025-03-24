import 'package:edupluz_future/core/models/courses/courses_model.dart';
import 'package:edupluz_future/core/services/courses/fetch_continue_watch.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/core/widgets/course/card_courses_portrait.dart';
import 'package:edupluz_future/features/course_by_category/presentation/course_by_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ListContinueWatch extends ConsumerStatefulWidget {
  const ListContinueWatch({super.key});

  @override
  ConsumerState<ListContinueWatch> createState() => _ListContinueWatchState();
}

class _ListContinueWatchState extends ConsumerState<ListContinueWatch> {
  CoursesModel? coursesModel;
  List<Item> items = [];
  int page = 1;
  bool isLoadingMore = false;
  final ScrollController _scrollController = ScrollController();

  _fetchCourses() async {
    coursesModel = await fetchContinueWatch(ref: ref, page: page, limit: 10);
    items.addAll(coursesModel!.data.items);
    if (mounted) setState(() {});
  }

  void _scrollListener() async {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !isLoadingMore) {
      _loadMoreData();
    }
  }

  void _loadMoreData() async {
    isLoadingMore = true;
    if (items.length < coursesModel!.data.meta.totalItems) {
      page += 1;
      _fetchCourses();
    }
    isLoadingMore = false;
  }

  @override
  void initState() {
    _fetchCourses();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return coursesModel == null
        ? _loading()
        : items.isEmpty
            ? Container()
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const CourseByCategoryScreen(
                            categoryName: "เรียนต่อ",
                          );
                        }));
                      },
                      child: Row(
                        children: [
                          Text(
                            "เรียนต่อ",
                            style: AppTextStyles.h2,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Icon(
                            LucideIcons.chevron_right,
                            color: AppColors.buttonText,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                      height: 198,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: ListView.builder(
                            shrinkWrap: true,
                            controller: _scrollController,
                            itemCount: items.length +
                                (items.length <
                                        coursesModel!.data.meta.totalItems
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
                                    : CardCoursesPortrait(
                                        instructor:
                                            "${items[index].instructor.firstName} ${items[index].instructor.lastName}",
                                        courseId: items[index].id,
                                        imageUrl:
                                            items[index].thumbnail.vertical,
                                        progress: items[index].rating,
                                        isShowProgress: true,
                                        chapterId: items[index].id,
                                        lessonId: items[index].id,
                                      ),
                              );
                            }),
                      )),
                  const SizedBox(height: 24),
                ],
              );
  }

  Widget _loading() {
    return Skeletonizer(
      child: Padding(
        padding: const EdgeInsets.only(left: 24),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "เรียนต่อ",
                  style: AppTextStyles.h2,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Icon(
                  LucideIcons.chevron_right,
                  color: AppColors.buttonText,
                )
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 198,
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  4,
                  (index) => const Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: CardCoursesPortrait(
                      courseId: "",
                      imageUrl: null,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
