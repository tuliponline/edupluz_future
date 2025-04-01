import 'package:edupluz_future/core/constant/api_path.dart';
import 'package:edupluz_future/core/models/courses/check_exam_200_response.dart';
import 'package:edupluz_future/core/providers/language_provider.dart';
import 'package:edupluz_future/core/services/api/private_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class ExamServices {
  Future<CheckExam200Response> checkExam({
    required WidgetRef ref,
    required String courseId,
    required String chapterId,
    required String lessonId,
    required List<AnswersModel> answers,
  }) async {
    Logger().d("courseId $courseId");
    Logger().d("chapterId $chapterId");
    Logger().d("lessonId $lessonId");
    answers.forEach((element) {
      Logger().d("questionId ${element.questionId}");
      Logger().d("choiceId ${element.choiceId}");
    });
    try {
      final response = await PrivateApiService().post(
          language: ref.read(languageProvider),
          path: "${ApiPath.exam}/check",
          body: {
            "course_id": courseId,
            "chapter_id": chapterId,
            "lesson_id": lessonId,
            "answers": answers
                .map((answer) => {
                      "question_id": answer.questionId,
                      "choice_id": answer.choiceId,
                    })
                .toList(),
          });
      Logger().d(response);
      return checkExam200ResponseFromJson(response);
    } catch (e) {
      Logger().e(e);
      throw Exception(e);
    }
  }

  Future<void> submitExam({
    required WidgetRef ref,
    required String courseId,
    required String chapterId,
    required String lessonId,
    required List<AnswersModel> answers,
  }) async {
    try {
      final response = await PrivateApiService().post(
          language: ref.read(languageProvider),
          path: ApiPath.exam,
          body: {
            "course_id": courseId,
            "chapter_id": chapterId,
            "lesson_id": lessonId,
            "answers": answers
                .map((answer) => {
                      "question_id": answer.questionId,
                      "choice_id": answer.choiceId,
                    })
                .toList(),
          });
      Logger().d(response);
    } catch (e) {
      Logger().e(e);
      throw Exception(e);
    }
  }
}

class AnswersModel {
  final String questionId;
  final String choiceId;
  AnswersModel({required this.questionId, required this.choiceId});
}
