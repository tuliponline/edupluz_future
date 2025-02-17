import 'package:edupluz_future/core/models/category/catagories_model.dart';

class FakeCategory {
  static CatagoriesModel getCategories() {
    return CatagoriesModel(
      code: "200",
      msg: "success",
      data: Data(
        items: [
          Item(
            id: "1",
            name: "Category 1",
            count: 10,
            description: "Explore comprehensive courses in Category 1",
          ),
          Item(
            id: "2",
            name: "Category 2",
            count: 10,
            description: "Explore comprehensive courses in Category 2",
          ),
          Item(
            id: "3",
            name: "Category 3",
            count: 10,
            description: "Explore comprehensive courses in Category 3",
          ),
          Item(
            id: "4",
            name: "Category 4",
            count: 10,
            description: "Explore comprehensive courses in Category 4",
          ),
          Item(
            id: "5",
            name: "Category 5",
            count: 10,
            description: "Explore comprehensive courses in Category 5",
          ),
          Item(
            id: "6",
            name: "Category 6",
            count: 10,
            description: "Explore comprehensive courses in Category 6",
          ),
          Item(
            id: "7",
            name: "Category 7",
            count: 10,
            description: "Explore comprehensive courses in Category 7",
          ),
          Item(
            id: "8",
            name: "Category 8",
            count: 10,
            description: "Explore comprehensive courses in Category 8",
          ),
        ],
        meta: Meta(
          itemCount: 8,
          totalItems: 8,
          page: 1,
          limit: 10,
          totalPages: 1,
        ),
      ),
    );
  }
}
