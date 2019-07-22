import 'dart:developer';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/model/course/category.dart';
import 'package:myapp/common/model/course/course.dart';
import 'package:myapp/page/course_page/course_list_component/state.dart';

class TabbarState implements Cloneable<TabbarState> {
  List<CategoryModel> tabbarList;
  Map<String, List> courseData; // 所有的课程列表state,用分类ID 区分
  int categoryId;
  ScrollController pageController;
  @override
  TabbarState clone() {
    return TabbarState()
      ..categoryId = categoryId
      ..courseData = courseData
      ..pageController = pageController
      ..tabbarList = tabbarList;
  }
}

TabbarState initState(Map<String, dynamic> args) {
  return TabbarState();
}

class CourseListConnector
    extends Reselect1<TabbarState, CourseListState, List> {
  @override
  CourseListState computed(List sub0) {
    return CourseListState()..courseList = sub0;
  }

  @override
  List getSub0(TabbarState state) {
    if (state.categoryId != null) {
      return state.courseData['${state.categoryId}'];
    }
    return List<CourseModel>();
  }

  @override
  void set(TabbarState state, CourseListState subState) {
    throw Exception('Unexcepted to set CourseListState from TabbarState');
  }
}
