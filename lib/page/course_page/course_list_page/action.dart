import 'dart:developer';

import 'package:fish_redux/fish_redux.dart';

import 'package:myapp/common/model/course/course.dart';

//TODO replace with your own action
enum CourseListAction { loadData }

class CourseListActionCreator {
  static Action loadData(List<CourseModel> courseList) {
    return Action(CourseListAction.loadData, payload: courseList);
  }
}
