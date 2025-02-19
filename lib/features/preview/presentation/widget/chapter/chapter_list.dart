import 'package:edupluz_future/core/models/courses/course_model.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/features/preview/presentation/widget/chapter/chapter_item.dart';
import 'package:flutter/material.dart';

class ChapterList extends StatelessWidget {
  final List<Chapter> chapter;
  final CourseModel course;
  const ChapterList({super.key, required this.chapter, required this.course});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Course Preview", style: AppTextStyles.h4),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: chapter.length,
          itemBuilder: (context, i) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: chapter[i].lessons.length,
              itemBuilder: (context, j) {
                return Stack(
                  children: [
                    ChapterItem(
                      chapter: chapter[i],
                      lesson: chapter[i].lessons[j],
                      course: course,
                    ),
                    if (!course.joined && !chapter[i].lessons[j].free)
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 6),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
