import 'package:fish_redux/fish_redux.dart';

class CourseListState implements Cloneable<CourseListState> {

  @override
  CourseListState clone() {
    return CourseListState();
  }
}

CourseListState initState(Map<String, dynamic> args) {
  return CourseListState();
}
