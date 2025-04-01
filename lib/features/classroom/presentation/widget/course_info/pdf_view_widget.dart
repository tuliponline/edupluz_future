import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:logger/logger.dart';

class PdfView extends StatefulWidget {
  final String pdfCourseFile;
  const PdfView({super.key, required this.pdfCourseFile});

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  int page = 0;
  int totalPages = 0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          PDFView(
            filePath: widget.pdfCourseFile,
            enableSwipe: true,
            onPageChanged: (page, total) {
              Logger().d('page change: $page/$total');
              setState(() {
                this.page = page ?? 0;
                totalPages = total ?? 0;
              });
            },
            // swipeHorizontal: true,
            // autoSpacing: false,
            // pageFling: false,
            // pageSnap: false,
            // defaultPage: 1,
            // fitEachPage: true,
            // onRender: (pages) {
            //   setState(() {});
            // },
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: ShapeDecoration(
                color: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              child: Text(
                "${page + 1} / $totalPages",
                style: AppTextStyles.bodySmall
                    .copyWith(color: AppColors.background),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
