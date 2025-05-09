import 'package:edupluz_future/core/models/category/get_categories_200_response.dart';
import 'package:edupluz_future/core/services/category/fetch_category.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/features/course_by_category/presentation/course_by_category_screen.dart';
import 'package:edupluz_future/features/search/presentation/widget/cat_menu_item.dart';
import 'package:faker/faker.dart' as faker_lib;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchNotFound extends ConsumerStatefulWidget {
  const SearchNotFound({super.key});

  @override
  ConsumerState<SearchNotFound> createState() => _SearchNotFoundState();
}

class _SearchNotFoundState extends ConsumerState<SearchNotFound> {
  GetCategories200Response? catagories;

  _fetchCategory() async {
    catagories = await fetchCategories(ref: ref);
    // if (showCategory > catagories!.data.items.length) {
    //   showCategory = catagories!.data.items.length;
    // }

    setState(() {});
  }

  _tapMenu(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CourseByCategoryScreen(
            categoryName: catagories!.data.items[index].name,
            categoryId: catagories!.data.items[index].id,
            isEdupluz: false,
          );
        },
      ),
    );
  }

  @override
  void initState() {
    _fetchCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: AppColors.background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            shadows: const [
              BoxShadow(
                color: AppColors.cardShadow,
                blurRadius: 8,
                offset: Offset(4, 4),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: Image.asset('assets/icons/information.png'),
              ),
              const SizedBox(height: 16),
              Text('ไม่พบคอร์สที่คุณกำลังค้นหา',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                  )),
              const SizedBox(height: 16),
              Text('คุณต้องการค้นหาคอร์สนี้ใช่หรือไม่?',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                  )),
              const SizedBox(height: 14),
              (catagories == null)
                  ? _loading()
                  : Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8,
                      children: catagories!.data.items.map((e) {
                        int index = catagories!.data.items.indexOf(e);
                        return Column(
                          children: [
                            InkWell(
                              onTap: () => _tapMenu(index),
                              child:
                                  cetMenuItem(name: e.name, inSelected: false),
                            ),
                            const SizedBox(height: 8),
                          ],
                        );
                      }).toList(),
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget _loading() {
    var faker = faker_lib.Faker();

    List<Widget> list = [];

    // generate skeleton
    for (var i = 0; i < 11; i++) {
      list.add(
        Column(
          children: [
            cetMenuItem(name: faker.person.name(), inSelected: false),
            const SizedBox(height: 8),
          ],
        ),
      );
    }

    return Skeletonizer(
      child: Wrap(alignment: WrapAlignment.center, spacing: 8, children: list),
    );
  }
}
