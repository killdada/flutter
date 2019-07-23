import 'package:fish_redux/fish_redux.dart';
import 'dart:developer';

import 'package:myapp/common/model/course/course.dart';

class CourseListState implements Cloneable<CourseListState> {
  int categoryId;
  List<CourseModel> courseList;
  @override
  CourseListState clone() {
    return CourseListState()
      ..categoryId = categoryId
      ..courseList = courseList;
  }
}

CourseListState initState(Map<String, dynamic> args) {
  return CourseListState()..categoryId = args['id'];
}
