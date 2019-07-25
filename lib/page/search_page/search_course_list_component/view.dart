import 'dart:developer';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:myapp/widget/course_list_item.dart';

import 'state.dart';

Widget buildView(
    SearchCourseListState state, Dispatch dispatch, ViewService viewService) {
  debugger();
  return CourseListItem(state.course);
}
