import 'package:fish_redux/fish_redux.dart';

class CourseDetailState implements Cloneable<CourseDetailState> {

  @override
  CourseDetailState clone() {
    return CourseDetailState();
  }
}

CourseDetailState initState(Map<String, dynamic> args) {
  return CourseDetailState();
}
