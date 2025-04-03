import 'package:edupluz_future/core/constant/api_path.dart';
import 'package:edupluz_future/core/models/courses/check_exam_200_response.dart';
import 'package:edupluz_future/core/models/courses/get_exam_key_200_response.dart';
import 'package:edupluz_future/core/models/courses/get_exams_200_response.dart';
import 'package:edupluz_future/core/providers/language_provider.dart';
import 'package:edupluz_future/core/services/api/private_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class ExamServices {
  Future<GetExamKey200Response> getExamKey({
    required WidgetRef ref,
    required String courseId,
    required String chapterId,
    required String lessonId,
  }) async {
    final response = await PrivateApiService().post(
        language: ref.read(languageProvider),
        path: "${ApiPath.exam}/key",
        body: {
          "course_id": courseId,
          "chapter_id": chapterId,
          "lesson_id": lessonId,
        });
    return getExamKey200ResponseFromJson(response);
  }

  Future<CheckExam200Response> checkExam({
    required WidgetRef ref,
    required String key,
    required List<AnswersModel> answers,
  }) async {
    Logger().d("key $key");
    answers.forEach((element) {
      Logger().d("questionId ${element.questionId}");
      Logger().d("choiceId ${element.choiceId}");
    });
    try {
      final response = await PrivateApiService().post(
          language: ref.read(languageProvider),
          path: "${ApiPath.exam}/check?key=$key",
          body: {
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
    required String key,
    required List<AnswersModel> answers,
  }) async {
    try {
      final response = await PrivateApiService().post(
          language: ref.read(languageProvider),
          path: "${ApiPath.exam}?key=$key",
          body: {
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

  Future<GetExams200Response> getExam({
    required String lessonId,
  }) async {
    try {
      final response = await PrivateApiService()
          .get(path: "${ApiPath.exam}?filters=lesson_id:$lessonId");
      Logger().d(response);
      return getExams200ResponseFromJson(response);
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
