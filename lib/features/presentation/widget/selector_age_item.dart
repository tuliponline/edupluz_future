import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectorAge extends StatelessWidget {
  AgeRange ageRange;
  bool isSelected;
  Function onTap;

  SelectorAge(
      {super.key,
      required this.ageRange,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(
                height: isSelected ? 72 : 48,
                width: isSelected ? 72 : 48,
                child: buildAfeAvatarImage(ageRange)),
            const SizedBox(height: 10),
            Text(
              buildAgeText(ageRange),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String buildAgeText(AgeRange ageRange) {
  if (ageRange == AgeRange.age13to17) {
    return '13 - 17';
  }
  if (ageRange == AgeRange.age18to24) {
    return '18 - 24';
  }
  if (ageRange == AgeRange.age25to34) {
    return '25 - 34';
  }
  if (ageRange == AgeRange.age35to44) {
    return '35 - 44';
  }
  if (ageRange == AgeRange.age45to54) {
    return '45 - 54';
  }

  return '55+';
}

Widget buildAfeAvatarImage(AgeRange ageRange) {
  if (ageRange == AgeRange.age13to17) {
    return SvgPicture.asset("assets/images/question/age_select/15-17.svg");
  }
  if (ageRange == AgeRange.age18to24) {
    return SvgPicture.asset("assets/images/question/age_select/18-24.svg");
  }
  if (ageRange == AgeRange.age25to34) {
    return SvgPicture.asset("assets/images/question/age_select/25-34.svg");
  }
  if (ageRange == AgeRange.age35to44) {
    return SvgPicture.asset("assets/images/question/age_select/35-44.svg");
  }
  if (ageRange == AgeRange.age45to54) {
    return SvgPicture.asset("assets/images/question/age_select/45-54.svg");
  }

  if (ageRange == AgeRange.age55pluz) {
    return SvgPicture.asset("assets/images/question/age_select/55+.svg");
  }

  return const SizedBox(
      width: 260,
      height: 260,
      child: Icon(
        Icons.question_mark,
        color: Colors.white,
        size: 100,
      ));
}

enum AgeRange {
  age13to17,
  age18to24,
  age25to34,
  age35to44,
  age45to54,
  age55pluz,
  orther
}
