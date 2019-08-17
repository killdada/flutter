
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/model/course/course.dart';
import 'package:myapp/widget/course_list_item.dart';

Widget buildView(
    CourseModel state, Dispatch dispatch, ViewService viewService) {
  return CourseListItem(state);
}
