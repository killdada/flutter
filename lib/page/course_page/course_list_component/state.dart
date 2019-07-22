import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/model/course/course.dart';

class CourseListState implements Cloneable<CourseListState> {
  List<CourseModel> courseList;
  @override
  CourseListState clone() {
    return CourseListState()..courseList = courseList;
  }
}

CourseListState initState(Map<String, dynamic> args) {
  return CourseListState();
}
