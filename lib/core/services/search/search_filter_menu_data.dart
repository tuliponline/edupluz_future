import 'dart:convert';

List<SearchFilterMenuModel> searchFilterMenuData = [
  SearchFilterMenuModel(
    id: 1,
    title: "ยอดนิยม",
    image: "assets/icons/search/tophit.png",
  ),
  SearchFilterMenuModel(
    id: 2,
    title: "มาใหม่",
    image: "assets/icons/search/newes.png",
  ),
  SearchFilterMenuModel(
    id: 3,
    title: "สำหรับคุณ",
    image: "assets/icons/search/foryou.png",
  ),
  SearchFilterMenuModel(
    id: 4,
    title: "Mastery",
    image: "assets/icons/search/mastery.png",
  ),
];

SearchFilterMenuModel searchFilterMenuModelFromJson(String str) =>
    SearchFilterMenuModel.fromJson(json.decode(str));

String searchFilterMenuModelToJson(SearchFilterMenuModel data) =>
    json.encode(data.toJson());

class SearchFilterMenuModel {
  int id;
  String title;
  String image;

  SearchFilterMenuModel({
    required this.id,
    required this.title,
    required this.image,
  });

  factory SearchFilterMenuModel.fromJson(Map<String, dynamic> json) =>
      SearchFilterMenuModel(
        id: json["id"],
        title: json["title"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
      };
}
