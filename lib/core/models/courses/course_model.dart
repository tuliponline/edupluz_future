// To parse this JSON data, do
//
//     final courseModel = courseModelFromJson(jsonString);

import 'dart:convert';

CourseModel courseModelFromJson(String str) =>
    CourseModel.fromJson(json.decode(str));

String courseModelToJson(CourseModel data) => json.encode(data.toJson());

class CourseModel {
  String id;
  Instructor instructor;
  List<String> categories;
  String name;
  String slug;
  String teaser;
  int views;
  int duration;
  Thumbnail thumbnail;
  String description;
  dynamic promotions;
  String cover;
  bool joined;
  bool favorited;
  bool mastery;
  String status;
  int rating;
  int price;
  int discount;
  int netPrice;
  Journey journey;
  int progress;
  bool business;
  List<Chapter> chapters;
  Continue courseModelContinue;

  CourseModel({
    required this.id,
    required this.instructor,
    required this.categories,
    required this.name,
    required this.slug,
    required this.teaser,
    required this.views,
    required this.duration,
    required this.thumbnail,
    required this.description,
    required this.promotions,
    required this.cover,
    required this.joined,
    required this.favorited,
    required this.mastery,
    required this.status,
    required this.rating,
    required this.price,
    required this.discount,
    required this.netPrice,
    required this.journey,
    required this.progress,
    required this.business,
    required this.chapters,
    required this.courseModelContinue,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        id: json["id"],
        instructor: Instructor.fromJson(json["instructor"]),
        categories: List<String>.from(json["categories"].map((x) => x)),
        name: json["name"],
        slug: json["slug"],
        teaser: json["teaser"],
        views: json["views"],
        duration: json["duration"],
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
        description: json["description"],
        promotions: json["promotions"],
        cover: json["cover"],
        joined: json["joined"],
        favorited: json["favorited"],
        mastery: json["mastery"],
        status: json["status"],
        rating: json["rating"],
        price: json["price"],
        discount: json["discount"],
        netPrice: json["net_price"],
        journey: Journey.fromJson(json["journey"]),
        progress: json["progress"],
        business: json["business"] ?? false,
        chapters: List<Chapter>.from(
            json["chapters"].map((x) => Chapter.fromJson(x))),
        courseModelContinue: Continue.fromJson(json["continue"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "instructor": instructor.toJson(),
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "name": name,
        "slug": slug,
        "teaser": teaser,
        "views": views,
        "duration": duration,
        "thumbnail": thumbnail.toJson(),
        "description": description,
        "promotions": promotions,
        "cover": cover,
        "joined": joined,
        "favorited": favorited,
        "mastery": mastery,
        "status": status,
        "rating": rating,
        "price": price,
        "discount": discount,
        "net_price": netPrice,
        "journey": journey.toJson(),
        "progress": progress,
        "business": business,
        "chapters": List<dynamic>.from(chapters.map((x) => x.toJson())),
        "continue": courseModelContinue.toJson(),
      };
}

class Chapter {
  String id;
  String name;
  int sequence;
  List<Lesson> lessons;
  int duration;

  Chapter({
    required this.id,
    required this.name,
    required this.sequence,
    required this.lessons,
    required this.duration,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        id: json["id"],
        name: json["name"],
        sequence: json["sequence"],
        lessons:
            List<Lesson>.from(json["lessons"].map((x) => Lesson.fromJson(x))),
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sequence": sequence,
        "lessons": List<dynamic>.from(lessons.map((x) => x.toJson())),
        "duration": duration,
      };
}

class Lesson {
  String id;
  String type;
  String name;
  bool free;
  int sequence;
  int duration;
  bool watched;

  Lesson({
    required this.id,
    required this.type,
    required this.name,
    required this.free,
    required this.sequence,
    required this.duration,
    required this.watched,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        free: json["free"],
        sequence: json["sequence"],
        duration: json["duration"],
        watched: json["watched"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "free": free,
        "sequence": sequence,
        "duration": duration,
        "watched": watched,
      };
}

class Continue {
  String name;
  int sequence;
  String chapterId;
  String lessonId;
  int progress;
  int duration;

  Continue({
    required this.name,
    required this.sequence,
    required this.chapterId,
    required this.lessonId,
    required this.progress,
    required this.duration,
  });

  factory Continue.fromJson(Map<String, dynamic> json) => Continue(
        name: json["name"],
        sequence: json["sequence"],
        chapterId: json["chapter_id"],
        lessonId: json["lesson_id"],
        progress: json["progress"],
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "sequence": sequence,
        "chapter_id": chapterId,
        "lesson_id": lessonId,
        "progress": progress,
        "duration": duration,
      };
}

class Instructor {
  String title;
  String firstName;
  String lastName;
  String avatar;
  String description;

  Instructor({
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.description,
  });

  factory Instructor.fromJson(Map<String, dynamic> json) => Instructor(
        title: json["title"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "first_name": firstName,
        "last_name": lastName,
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
        suitableFor: List<String>.from(json["suitable_for"].map((x) => x)),
        outcomes: List<String>.from(json["outcomes"].map((x) => x)),
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
        horizontal: json["horizontal"],
        vertical: json["vertical"],
      );

  Map<String, dynamic> toJson() => {
        "horizontal": horizontal,
        "vertical": vertical,
      };
}
