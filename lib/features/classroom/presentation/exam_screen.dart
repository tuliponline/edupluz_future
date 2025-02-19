import 'package:edupluz_future/core/models/courses/course_model.dart';
import 'package:edupluz_future/core/services/cer_service.dart';
import 'package:edupluz_future/core/theme/app_colors.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:logger/logger.dart';

class ExamScreen extends StatefulWidget {
  final CourseModel course;
  final String examUrl;
  final String examKey;
  const ExamScreen(
      {super.key,
      required this.course,
      required this.examUrl,
      required this.examKey});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: Text(
            "แบบทดสอบ",
            style: AppTextStyles.h4,
          ),
        ),
        body: Stack(
          children: [
            InAppWebView(
              onProgressChanged: (controller, progress) {
                Logger().d("wenview progress: $progress");
                setState(() {
                  isLoading = progress < 100;
                });
              },
              initialUrlRequest: URLRequest(url: WebUri(widget.examUrl)),
              onConsoleMessage: (controller, consoleMessage) {
                Logger().d(consoleMessage);
                if ((consoleMessage.toString()).contains("close exam")) {
                  Navigator.pop(context);
                }
              },
              onDownloadStartRequest: (controller, downloadStartRequest) async {
                EasyLoading.show();
                Uint8List cerData =
                    await CerService().downloadCer(widget.examKey);
                await CerService().saveCertificate(cerData);
                EasyLoading.dismiss();
                // Logger().d(cerData);
              },
            ),
            Visibility(
              visible: isLoading,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ));
  }
}
