// To parse this JSON data, do
//
//     final coursesModel = coursesModelFromJson(jsonString);

import 'dart:convert';

CoursesModel coursesModelFromJson(String str) =>
    CoursesModel.fromJson(json.decode(str));

String coursesModelToJson(CoursesModel data) => json.encode(data.toJson());

class CoursesModel {
  String code;
  String msg;
  Data data;

  CoursesModel({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory CoursesModel.fromJson(Map<String, dynamic> json) => CoursesModel(
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
  String workspaceId;
  String instructorId;
  List<Category> categories;
  String title;
  String subTitle;
  String slug;
  String description;
  Thumbnail thumbnail;
  String cover;
  Journey journey;
  List<Chapter> chapters;
  double rating;
  String status;
  double price;
  bool isMastery;
  bool isFree;
  String teaser;
  DateTime releaseAt;
  DateTime createdAt;
  DateTime updatedAt;

  Item({
    required this.id,
    required this.workspaceId,
    required this.instructorId,
    required this.categories,
    required this.title,
    required this.subTitle,
    required this.slug,
    required this.description,
    required this.thumbnail,
    required this.cover,
    required this.journey,
    required this.chapters,
    required this.rating,
    required this.status,
    required this.price,
    required this.isMastery,
    required this.isFree,
    required this.teaser,
    required this.releaseAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        workspaceId: json["workspace_id"],
        instructorId: json["instructor_id"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        title: json["title"],
        subTitle: json["sub_title"],
        slug: json["slug"],
        description: json["description"],
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
        cover: json["cover"],
        journey: Journey.fromJson(json["journey"]),
        chapters: List<Chapter>.from(
            json["chapters"].map((x) => Chapter.fromJson(x))),
        rating: json["rating"]?.toDouble(),
        status: json["status"],
        price: json["price"]?.toDouble(),
        isMastery: json["is_mastery"],
        isFree: json["is_free"],
        teaser: json["teaser"],
        releaseAt: DateTime.parse(json["release_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "workspace_id": workspaceId,
        "instructor_id": instructorId,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "title": title,
        "sub_title": subTitle,
        "slug": slug,
        "description": description,
        "thumbnail": thumbnail.toJson(),
        "cover": cover,
        "journey": journey.toJson(),
        "chapters": List<dynamic>.from(chapters.map((x) => x.toJson())),
        "rating": rating,
        "status": status,
        "price": price,
        "is_mastery": isMastery,
        "is_free": isFree,
        "teaser": teaser,
        "release_at": releaseAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Category {
  String id;
  String name;
  String description;
  List<Category>? subCategories;

  Category({
    required this.id,
    required this.name,
    required this.description,
    this.subCategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        subCategories: json["sub_categories"] == null
            ? []
            : List<Category>.from(
                json["sub_categories"]!.map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "sub_categories": subCategories == null
            ? []
            : List<dynamic>.from(subCategories!.map((x) => x.toJson())),
      };
}

class Chapter {
  String id;
  String name;
  int sequence;
  List<Lesson> lessons;

  Chapter({
    required this.id,
    required this.name,
    required this.sequence,
    required this.lessons,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        id: json["id"],
        name: json["name"],
        sequence: json["sequence"],
        lessons:
            List<Lesson>.from(json["lessons"].map((x) => Lesson.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sequence": sequence,
        "lessons": List<dynamic>.from(lessons.map((x) => x.toJson())),
      };
}

class Lesson {
  String id;
  Type type;
  String name;
  bool isFree;
  int sequence;
  Content content;

  Lesson({
    required this.id,
    required this.type,
    required this.name,
    required this.isFree,
    required this.sequence,
    required this.content,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        id: json["id"],
        type: typeValues.map[json["type"]]!,
        name: json["name"],
        isFree: json["is_free"],
        sequence: json["sequence"],
        content: Content.fromJson(json["content"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": typeValues.reverse[type],
        "name": name,
        "is_free": isFree,
        "sequence": sequence,
        "content": content.toJson(),
      };
}

class Content {
  FileClass? file;
  Exam? exam;
  Video? video;

  Content({
    this.file,
    this.exam,
    this.video,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        file: json["file"] == null ? null : FileClass.fromJson(json["file"]),
        exam: json["exam"] == null ? null : Exam.fromJson(json["exam"]),
        video: json["video"] == null ? null : Video.fromJson(json["video"]),
      );

  Map<String, dynamic> toJson() => {
        "file": file?.toJson(),
        "exam": exam?.toJson(),
        "video": video?.toJson(),
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
  List<Choice> choices;
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
        choices:
            List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
        sequence: json["sequence"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "choices": List<dynamic>.from(choices.map((x) => x.toJson())),
        "sequence": sequence,
      };
}

class Choice {
  String id;
  String choice;
  String title;
  bool isCorrect;

  Choice({
    required this.id,
    required this.choice,
    required this.title,
    required this.isCorrect,
  });

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        id: json["id"],
        choice: json["choice"],
        title: json["title"],
        isCorrect: json["is_correct"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "choice": choice,
        "title": title,
        "is_correct": isCorrect,
      };
}

class FileClass {
  String title;
  String url;

  FileClass({
    required this.title,
    required this.url,
  });

  factory FileClass.fromJson(Map<String, dynamic> json) => FileClass(
        title: json["title"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "url": url,
      };
}

class Video {
  String id;

  Video({
    required this.id,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

enum Type { EXAM, FILE, VIDEO }

final typeValues =
    EnumValues({"EXAM": Type.EXAM, "FILE": Type.FILE, "VIDEO": Type.VIDEO});

class Journey {
  List<String>? suitableFor;
  List<String>? outcomes;

  Journey({
    required this.suitableFor,
    required this.outcomes,
  });

  factory Journey.fromJson(Map<String, dynamic> json) => Journey(
        suitableFor: json["suitable_for"] == null
            ? []
            : List<String>.from(json["suitable_for"]!.map((x) => x)),
        outcomes: json["outcomes"] == null
            ? []
            : List<String>.from(json["outcomes"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "suitable_for": suitableFor == null
            ? []
            : List<dynamic>.from(suitableFor!.map((x) => x)),
        "outcomes":
            outcomes == null ? [] : List<dynamic>.from(outcomes!.map((x) => x)),
      };
}

class Thumbnail {
  String horizontal;
  String vertical;

  Thumbnail({
    required this.horizontal,
    required this.vertical,
  });

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        horizontal: json["horizontal"],
        vertical: json["vertical"],
      );

  Map<String, dynamic> toJson() => {
        "horizontal": horizontal,
        "vertical": vertical,
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
