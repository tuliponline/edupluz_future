import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/features/classroom/data/fetch_course_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadFile extends StatelessWidget {
  final String slug;
  const DownloadFile({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Logger().d("Download File");

        Uri uri = Uri.parse(await fetchCourseFileUrl(slug));

        launchUrl(uri);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              "ดาวน์โหลดเอกสาร",
              style: AppTextStyles.bodyLarge,
            ),
            const SizedBox(width: 8),
            const Icon(
              LucideIcons.download,
              color: AppColors.textPrimary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
