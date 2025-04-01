class ApiPath {
  // new API
  static String users = "/account/user/v1/users";
  static String userMe = "/account/user/v1/users/me";

  static String categories =
      "/course/category/v1/categories?limit=99&order_by=sequence:1";
  static String courses = "/course/course/v1/courses";
  static String coursesJoinings = "/course/course/v1/courses/joinings";

  static String exam = "/course/course/v1/courses/exams";

  static String orders = "/merchant/order/v1/orders";
  static String profile = "/account/user/v1/users/profile";
  static String courseFavorites = "/course/course/v1/courses/favorites";
//courses

  static String coursesTopHit = "/edupluz/course/v1/courses/home/top-hit";
  static const courseSearch = '/edupluz/course/v1/courses/search';

  static String saveCourses = '/edupluz/course/v1/courses/favorites';
  static const continueWatch =
      "/edupluz/course/v1/courses/home/continue-watching";
  static String examination = "/edupluz/course/v1/courses/examinations";
// examination
  static String examPath = "/course-exam";

  //auth
  static const String register = "/account/auth/v1/auth/register";
  static const String verifyOtp = "/account/auth/v1/auth/register/otp/verify";
  static const String resendOtp = "/account/auth/v1/auth/email/resend";
  static const String login = "/account/auth/v1/auth/login";
  static const String refreshToken = '/account/auth/v1/auth/refresh';

  static const String forgotPassword = '/account/auth/v1/auth/password/forgot';
  static const String forgotPasswordOtpVerify =
      '/account/auth/v1/auth/password/forgot/otp/verify';
  static const String resetPassword = '/account/auth/v1/auth/password/reset';
  static const String registerOtpVerify =
      '/account/auth/v1/auth/register/otp/verify';
  static const String resendEmail = '/account/auth/v1/auth/email/resend';

  //account

  static const String addresss = "/account/address/v1/addresses";
}
