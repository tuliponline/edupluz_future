// To parse this JSON data, do
//
//     final getExams200Response = getExams200ResponseFromJson(jsonString);

import 'dart:convert';

GetExams200Response getExams200ResponseFromJson(String str) =>
    GetExams200Response.fromJson(json.decode(str));

String getExams200ResponseToJson(GetExams200Response data) =>
    json.encode(data.toJson());

class GetExams200Response {
  String code;
  String msg;
  Data data;

  GetExams200Response({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory GetExams200Response.fromJson(Map<String, dynamic> json) =>
      GetExams200Response(
        code: json["code"],
        msg: json["msg"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "msg": msg,
        "data": data.toJson(),
      };
}

class Data {
  List<Item> items;
  Meta meta;

  Data({
    required this.items,
    required this.meta,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class Item {
  String id;
  String userId;
  String courseId;
  String chapterId;
  String lessonId;
  int score;
  List<Answer> answers;
  DateTime createdAt;
  DateTime updatedAt;

  Item({
    required this.id,
    required this.userId,
    required this.courseId,
    required this.chapterId,
    required this.lessonId,
    required this.score,
    required this.answers,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        userId: json["user_id"],
        courseId: json["course_id"],
        chapterId: json["chapter_id"],
        lessonId: json["lesson_id"],
        score: json["score"],
        answers:
            List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "course_id": courseId,
        "chapter_id": chapterId,
        "lesson_id": lessonId,
        "score": score,
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Answer {
  String questionId;
  String choiceId;
  bool isCorrect;

  Answer({
    required this.questionId,
    required this.choiceId,
    required this.isCorrect,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        questionId: json["question_id"],
        choiceId: json["choice_id"],
        isCorrect: json["is_correct"],
      );

  Map<String, dynamic> toJson() => {
        "question_id": questionId,
        "choice_id": choiceId,
        "is_correct": isCorrect,
      };
}

class Meta {
  int page;
  int limit;
  int itemCount;
  int totalPages;
  int totalItems;

  Meta({
    required this.page,
    required this.limit,
    required this.itemCount,
    required this.totalPages,
    required this.totalItems,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        page: json["page"],
        limit: json["limit"],
        itemCount: json["item_count"],
        totalPages: json["total_pages"],
        totalItems: json["total_items"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "limit": limit,
        "item_count": itemCount,
        "total_pages": totalPages,
        "total_items": totalItems,
      };
}
