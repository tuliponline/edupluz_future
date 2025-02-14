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
        items: json["items"] != null
            ? List<Item>.from(json["items"].map((x) => Item.fromJson(x)))
            : [],
        meta: json["meta"] != null
            ? Meta.fromJson(json["meta"])
            : Meta(
                page: 0, limit: 0, itemCount: 0, totalPages: 0, totalItems: 0),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class Item {
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
  Continue itemContinue;
  DateTime releaseAt;
  String headline;

  Item({
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
    required this.itemContinue,
    required this.releaseAt,
    required this.headline,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"] ?? "",
        instructor: Instructor.fromJson(json["instructor"]),
        categories: List<String>.from(json["categories"].map((x) => x)),
        name: json["name"] ?? "",
        slug: json["slug"] ?? "",
        teaser: json["teaser"] ?? "",
        views: json["views"] ?? 0,
        duration: json["duration"] ?? 0,
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
        description: json["description"] ?? "",
        promotions: json["promotions"] ?? "",
        cover: json["cover"] ?? "",
        joined: json["joined"] ?? false,
        favorited: json["favorited"] ?? false,
        mastery: json["mastery"] ?? false,
        status: json["status"],
        rating: json["rating"] ?? 0,
        price: json["price"] ?? 0,
        discount: json["discount"] ?? 0,
        netPrice: json["net_price"] ?? 0,
        journey: Journey.fromJson(json["journey"]),
        progress: json["progress"] ?? 0,
        business: json["business"] ?? false,
        chapters: List<Chapter>.from(
            json["chapters"].map((x) => Chapter.fromJson(x))),
        itemContinue: Continue.fromJson(json["continue"] ?? ""),
        releaseAt: DateTime.parse(json["release_at"] ?? ""),
        headline: json["headline"],
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
        "continue": itemContinue.toJson(),
        "release_at": releaseAt.toIso8601String(),
        "headline": headline,
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
  Type type;
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
        type: typeValues.map[json["type"]]!,
        name: json["name"],
        free: json["free"],
        sequence: json["sequence"],
        duration: json["duration"],
        watched: json["watched"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": typeValues.reverse[type],
        "name": name,
        "free": free,
        "sequence": sequence,
        "duration": duration,
        "watched": watched,
      };
}

enum Type { EMPTY, VIDEO }

final typeValues = EnumValues({"": Type.EMPTY, "VIDEO": Type.VIDEO});

enum Name { EMPTY, NAME, PURPLE }

final nameValues =
    EnumValues({"บทนำ": Name.EMPTY, "เนื้อหา": Name.NAME, "สรุป": Name.PURPLE});

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

enum Title { EMPTY }

final titleValues = EnumValues({"คุณ": Title.EMPTY});

class Continue {
  String name;
  int sequence;
  String chapterId;
  String lessonId;
  dynamic progress;
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
