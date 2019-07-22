import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/model/course/course.dart';
import 'dart:developer';

//TODO replace with your own action
enum TabbarAction { loadData }

class TabbarActionCreator {
  static Action loadData(List<CourseModel> courseList) {
    return Action(TabbarAction.loadData, payload: courseList);
  }
}
