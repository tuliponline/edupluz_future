// To parse this JSON data, do
//
//     final examModel = examModelFromJson(jsonString);

import 'dart:convert';

ExamModel examModelFromJson(String str) => ExamModel.fromJson(json.decode(str));

String examModelToJson(ExamModel data) => json.encode(data.toJson());

class ExamModel {
  String id;
  String type;
  String name;
  bool isFree;
  int sequence;
  Content content;

  ExamModel({
    required this.id,
    required this.type,
    required this.name,
    required this.isFree,
    required this.sequence,
    required this.content,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) => ExamModel(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        isFree: json["is_free"],
        sequence: json["sequence"],
        content: Content.fromJson(json["content"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "is_free": isFree,
        "sequence": sequence,
        "content": content.toJson(),
      };
}

class Content {
  Exam exam;

  Content({
    required this.exam,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        exam: Exam.fromJson(json["exam"]),
      );

  Map<String, dynamic> toJson() => {
        "exam": exam.toJson(),
      };
}

class Exam {
  List<Question> questions;

  Exam({
    required this.questions,
  });

  factory Exam.fromJson(Map<String, dynamic> json) => Exam(
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}

class Question {
  String id;
  String title;
  List<ChoiceElement> choices;
  int sequence;

  Question({
    required this.id,
    required this.title,
    required this.choices,
    required this.sequence,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        title: json["title"],
        choices: List<ChoiceElement>.from(
            json["choices"].map((x) => ChoiceElement.fromJson(x))),
        sequence: json["sequence"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "choices": List<dynamic>.from(choices.map((x) => x.toJson())),
        "sequence": sequence,
      };
}

class ChoiceElement {
  String id;
  ChoiceEnum choice;
  String title;
  dynamic isCorrect;

  ChoiceElement({
    required this.id,
    required this.choice,
    required this.title,
    required this.isCorrect,
  });

  factory ChoiceElement.fromJson(Map<String, dynamic> json) => ChoiceElement(
        id: json["id"],
        choice: choiceEnumValues.map[json["choice"]]!,
        title: json["title"],
        isCorrect: json["is_correct"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "choice": choiceEnumValues.reverse[choice],
        "title": title,
        "is_correct": isCorrect,
      };
}

enum ChoiceEnum { A, B, C, D }

final choiceEnumValues = EnumValues({
  "A": ChoiceEnum.A,
  "B": ChoiceEnum.B,
  "C": ChoiceEnum.C,
  "D": ChoiceEnum.D
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
