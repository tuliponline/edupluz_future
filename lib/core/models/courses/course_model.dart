// To parse this JSON data, do
//
//     final courseModel = courseModelFromJson(jsonString);

import 'dart:convert';

CourseModel courseModelFromJson(String str) =>
    CourseModel.fromJson(json.decode(str));

String courseModelToJson(CourseModel data) => json.encode(data.toJson());

class CourseModel {
  String code;
  String msg;
  Data data;

  CourseModel({
    required this.code,
    required this.msg,
    required this.data,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
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
  String id;
  String workspaceId;
  Instructor instructor;
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
  bool joined;
  bool favorited;
  String expiredAt;
  bool isExpired;

  Data({
    required this.id,
    required this.workspaceId,
    required this.instructor,
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
    required this.joined,
    required this.favorited,
    required this.expiredAt,
    required this.isExpired,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] ?? "",
        workspaceId: json["workspace_id"] ?? "",
        instructor: Instructor.fromJson(json["instructor"]),
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x))),
        title: json["title"] ?? "",
        subTitle: json["sub_title"] ?? "",
        slug: json["slug"] ?? "",
        description: json["description"] ?? "",
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
        cover: json["cover"] ?? "",
        journey: Journey.fromJson(json["journey"]),
        chapters: json["chapters"] == null
            ? []
            : List<Chapter>.from(
                json["chapters"].map((x) => Chapter.fromJson(x))),
        rating: json["rating"]?.toDouble() ?? 0,
        status: json["status"] ?? "",
        price: json["price"]?.toDouble() ?? 0,
        isMastery: json["is_mastery"] ?? false,
        isFree: json["is_free"] ?? false,
        teaser: json["teaser"] ?? "",
        releaseAt: DateTime.parse(json["release_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        joined: json["joined"] ?? false,
        favorited: json["favorited"] ?? false,
        expiredAt: json["expired_at"] ?? "",
        isExpired: json["is_expired"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "workspace_id": workspaceId,
        "instructor": instructor.toJson(),
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
        "joined": joined,
        "favorited": favorited,
        "expired_at": expiredAt,
        "is_expired": isExpired,
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
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        description: json["description"] ?? "",
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
        id: json["id"] ?? "",
        name: json["name"] ?? "",
        sequence: json["sequence"] ?? 0,
        lessons: json["lessons"] == null
            ? []
            : List<Lesson>.from(json["lessons"].map((x) => Lesson.fromJson(x))),
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
  String type;
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
        id: json["id"] ?? "",
        type: json["type"] ?? "",
        name: json["name"] ?? "",
        isFree: json["is_free"] ?? false,
        sequence: json["sequence"] ?? 0,
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
        id: json["id"] ?? "",
        title: json["title"] ?? "",
        choices: json["choices"] == null
            ? []
            : List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
        sequence: json["sequence"] ?? 0,
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
  dynamic isCorrect;

  Choice({
    required this.id,
    required this.choice,
    required this.title,
    required this.isCorrect,
  });

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        id: json["id"] ?? "",
        choice: json["choice"] ?? "",
        title: json["title"] ?? "",
        isCorrect: json["is_correct"] ?? false,
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
        title: json["title"] ?? "",
        url: json["url"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "url": url,
      };
}

class Video {
  String id;
  String assetId;
  String name;
  int fileSize;
  int duration;
  int durationMs;
  String packType;
  String codec;
  String audioCodec;
  String status;
  String url;

  Video({
    required this.id,
    required this.assetId,
    required this.name,
    required this.fileSize,
    required this.duration,
    required this.durationMs,
    required this.packType,
    required this.codec,
    required this.audioCodec,
    required this.status,
    required this.url,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"] ?? "",
        assetId: json["asset_id"] ?? "",
        name: json["name"] ?? "",
        fileSize: json["file_size"] ?? 0,
        duration: json["duration"] ?? 0,
        durationMs: json["duration_ms"] ?? 0,
        packType: json["pack_type"] ?? "",
        codec: json["codec"] ?? "",
        audioCodec: json["audio_codec"] ?? "",
        status: json["status"] ?? "",
        url: json["url"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "asset_id": assetId,
        "name": name,
        "file_size": fileSize,
        "duration": duration,
        "duration_ms": durationMs,
        "pack_type": packType,
        "codec": codec,
        "audio_codec": audioCodec,
        "status": status,
        "url": url,
      };
}

class Instructor {
  String id;
  String workspaceId;
  String title;
  String firstName;
  String lastName;
  String email;
  String avatar;
  String description;

  Instructor({
    required this.id,
    required this.workspaceId,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatar,
    required this.description,
  });

  factory Instructor.fromJson(Map<String, dynamic> json) => Instructor(
        id: json["id"] ?? "",
        workspaceId: json["workspace_id"] ?? "",
        title: json["title"] ?? "",
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? "",
        email: json["email"] ?? "",
        avatar: json["avatar"] ?? "",
        description: json["description"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "workspace_id": workspaceId,
        "title": title,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "avatar": avatar,
        "description": description,
      };
}

class Journey {
  List<String> suitableFor;
  List<String> outcomes;

  Journey({
    required this.suitableFor,
    required this.outcomes,
  });

  factory Journey.fromJson(Map<String, dynamic> json) => Journey(
        suitableFor: json["suitable_for"] == null
            ? []
            : List<String>.from(json["suitable_for"].map((x) => x)),
        outcomes: json["outcomes"] == null
            ? []
            : List<String>.from(json["outcomes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "suitable_for": List<dynamic>.from(suitableFor.map((x) => x)),
        "outcomes": List<dynamic>.from(outcomes.map((x) => x)),
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
        horizontal: json["horizontal"] ?? "",
        vertical: json["vertical"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "horizontal": horizontal,
        "vertical": vertical,
      };
}
