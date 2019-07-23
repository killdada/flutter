import 'dart:developer';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/model/course/category.dart';
import 'package:myapp/common/model/course/course.dart';

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
