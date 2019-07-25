import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/model/course/course.dart';

class SearchCourseListState implements Cloneable<SearchCourseListState> {
  CourseModel course;
  @override
  SearchCourseListState clone() {
    return SearchCourseListState()..course = course;
  }
}
