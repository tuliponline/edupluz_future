import 'package:edupluz_future/core/models/courses/course_model.dart';

bool checkIsFree({CourseModel? course}) {
  if (course?.data.isFree == true || course?.data.joined == true) {
    return true;
  }
  return false;
}
