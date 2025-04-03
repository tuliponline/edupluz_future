import 'dart:typed_data';

import 'package:edupluz_future/core/models/courses/check_exam_200_response.dart';
import 'package:edupluz_future/core/models/courses/exam_model.dart';
import 'package:edupluz_future/core/models/courses/get_exam_key_200_response.dart';
import 'package:edupluz_future/core/services/api/private_api_service.dart';
import 'package:edupluz_future/core/services/cer_service.dart';
import 'package:edupluz_future/core/services/exam/exam_services.dart';
import 'package:edupluz_future/core/theme/app_text_styles.dart';
import 'package:edupluz_future/features/classroom/provider/fake_exam.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'dart:math';

class ExamWidget extends ConsumerStatefulWidget {
  final String courseId;
  final String chapterId;
  final String lessonId;
  final ExamModel? exam;
  const ExamWidget({
    super.key,
    required this.courseId,
    required this.chapterId,
    required this.lessonId,
    this.exam,
  });
  @override
  ConsumerState<ExamWidget> createState() => _ExamWidgetState();
}

class _ExamWidgetState extends ConsumerState<ExamWidget> {
  int index = 0;
  ExamModel? examData;
  Map<int, String> selectedChoices = {};
  String key = "";

  _getExamKey() async {
    GetExamKey200Response response = await ExamServices().getExamKey(
      ref: ref,
      courseId: widget.courseId,
      chapterId: widget.chapterId,
      lessonId: widget.lessonId,
    );
    key = response.data.key;
  }

  void onChanged(String? value) {
    setState(() {
      selectedChoices[index] = value ?? '';
    });
  }

  void nextQuestion() {
    if (index < examData!.content.exam.questions.length - 1) {
      setState(() {
        index++;
      });
    }
  }

  void previousQuestion() {
    if (index > 0) {
      setState(() {
        index--;
      });
    }
  }

  void finishExam() async {
    List<AnswersModel> answers = [];
    for (var i = 0; i < examData!.content.exam.questions.length; i++) {
      answers.add(AnswersModel(
        questionId: examData!.content.exam.questions[i].id,
        choiceId: selectedChoices[i] ?? "",
      ));
    }

    EasyLoading.show();
    try {
      CheckExam200Response response = await ExamServices().checkExam(
        ref: ref,
        key: key,
        answers: answers,
      );

      if (response.code == "0") {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  response.data.isPassed
                      ? 'คุณทำแบบทดสอบเสร็จสิ้น'
                      : 'คุณไม่ผ่านแบบทดสอบ',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'คะแนนของคุณ ${response.data.correctChoices}/${response.data.totalQuestions}',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: Colors.black,
                  ),
                ),
                Text(
                  response.data.isPassed
                      ? 'ขอบคุณที่ทำแบบทดสอบเสร็จสิ้น!'
                      : 'คุณไม่ผ่านแบบทดสอบ กรุณาทำแบบทดสอบใหม่อีกครั้ง',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            actions: [
              if (response.data.isPassed)
                TextButton(
                    onPressed: () async {
                      try {
                        EasyLoading.show();
                        Uint8List cerData =
                            await PrivateApiService().downloadCer(key);
                        await CerService().saveCertificate(cerData);
                      } catch (e) {
                        Logger().e(e);
                        EasyLoading.showError(
                            "เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง");
                      } finally {
                        EasyLoading.dismiss();
                      }
                    },
                    child: Text("ดาวน์โหลดใบรับรอง")),
              TextButton(
                onPressed: () async {
                  if (response.data.isPassed) {
                    EasyLoading.show();
                    try {
                      await ExamServices().submitExam(
                        ref: ref,
                        key: key,
                        answers: answers,
                      );
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } catch (e) {
                      Logger().e(e);
                      EasyLoading.showError(
                          "เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง");
                    } finally {
                      EasyLoading.dismiss();
                    }
                  } else {
                    setState(() {
                      examData!.content.exam.questions.shuffle(Random());
                      index = 0;
                      selectedChoices.clear();
                    });
                    Navigator.pop(context);
                  }
                },
                child: Text('ตกลง'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
    } finally {
      EasyLoading.dismiss();
    }
  }

  _initData() {
    examData = widget.exam ?? fakeExam;
    // Shuffle with random seed
    examData!.content.exam.questions.shuffle(Random());
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getExamKey();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: examData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(examData!.name,
                          style:
                              AppTextStyles.h3.copyWith(color: Colors.black)),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'คำถาม ${index + 1}/${examData!.content.exam.questions.length}',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(examData!.content.exam.questions[index].title,
                      style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  ...examData!.content.exam.questions[index].choices
                      .map((e) => RadioListTile(
                            title: Text("${e.choice.name}. ${e.title}",
                                style: AppTextStyles.bodyMedium
                                    .copyWith(color: Colors.black)),
                            value: e.id,
                            groupValue: selectedChoices[index],
                            onChanged: onChanged,
                          )),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (index > 0)
                        ElevatedButton(
                          onPressed: previousQuestion,
                          child: Text('ย้อนกลับ'),
                        )
                      else
                        SizedBox.shrink(),
                      if (index < examData!.content.exam.questions.length - 1)
                        ElevatedButton(
                          onPressed: selectedChoices[index] != null
                              ? nextQuestion
                              : null,
                          child: Text('ถัดไป'),
                        )
                      else
                        ElevatedButton(
                          onPressed: selectedChoices[index] != null
                              ? finishExam
                              : null,
                          child: Text('เสร็จสิ้น'),
                        ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
