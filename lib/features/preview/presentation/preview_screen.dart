import 'package:edupluz_future/core/models/courses/course_model.dart';
import 'package:edupluz_future/core/services/courses/fetch_course_by_id.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/core/widgets/better_player/better_player_screen.dart';
import 'package:edupluz_future/features/preview/data/fetch_favorite_course.dart';
import 'package:edupluz_future/features/preview/presentation/widget/buy_slider.dart';
import 'package:edupluz_future/features/preview/presentation/widget/chapter/chapter_list.dart';
import 'package:edupluz_future/features/preview/presentation/widget/chip_item.dart';
import 'package:edupluz_future/features/preview/presentation/widget/course_info.dart';
import 'package:flutter/material.dart';

class PreviewPage extends StatefulWidget {
  final String courseId;
  const PreviewPage({super.key, required this.courseId});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  CourseModel? course;

  _fetchCourseFavolite() async {
    await fetchFavoriteCourse(context,
        courseId: widget.courseId, isFavorite: course?.data.favorited ?? false);
    await _fetchCourseById();
  }

  _fetchCourseById() async {
    if (widget.courseId != "") {
      course = await fetchCourseById(id: widget.courseId);
    }
    setState(() {});
  }

  @override
  void initState() {
    _fetchCourseById();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return course == null
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                automaticallyImplyLeading: false,
                backgroundColor: AppColors.background,
                title: Text(
                  "คอร์ส",
                  style: AppTextStyles.h2,
                )),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(course?.data.title ?? "", style: AppTextStyles.h4),
                        const SizedBox(height: 16),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: BetterPlayerScreen(
                              url: course?.data.teaser ?? ""),
                        ),
                        const SizedBox(height: 16),
                        ChipItem(
                            course: course!,
                            onTapFavorite: () async {
                              await _fetchCourseFavolite();
                            }),
                        const SizedBox(height: 16),
                        CourseInfo(course: course!),
                        const SizedBox(height: 16),
                        ChapterList(
                          chapter: course?.data.chapters ?? [],
                          course: course!,
                        ),
                      ],
                    ),
                  ),
                ),
                if (course?.data.joined == false) BuySlider(course: course!)
              ],
            ),
          );
  }
}
