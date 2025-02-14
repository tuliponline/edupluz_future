class ApiPath {
  static String users = "/users";
  static String userMe = "/account/user/v1/users/me";

  static String categories =
      "/edupluz/category/v1/categories?limit=99&order_by=sequence:1";

  static String orders = "/merchant/order/v1/orders";

  static String profile = "/account/user/v1/users/profile";
//courses
  static String courses = "/edupluz/course/v1/courses";
  static String coursesTopHit = "/edupluz/course/v1/courses/home/top-hit";
  static const courseSearch = '/edupluz/course/v1/courses/search';
  static String coursesJoinings = "/edupluz/course/v1/courses/joinings";
  static String coursesfavorites = "/edupluz/course/v1/courses/favorites";
  static String saveCourses = '/edupluz/course/v1/courses/favorites';
  static const continueWatch =
      "/edupluz/course/v1/courses/home/continue-watching";
  static String examination = "/edupluz/course/v1/courses/examinations";
// examination
  static String examPath = "/course-exam";
}
