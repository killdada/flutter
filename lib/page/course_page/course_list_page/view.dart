import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:myapp/widget/course_list_item.dart';
import 'package:myapp/widget/list_placeholder.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    CourseListState state, Dispatch dispatch, ViewService viewService) {
  if (state.courseList == null) {
    return CupertinoActivityIndicator();
  }
  if (state.courseList.isEmpty) {
    return ListPlaceholder.empty();
  }
  return ListView.builder(
    itemCount: state.courseList.length,
    itemBuilder: (BuildContext context, int index) {
      return CourseListItem(state.courseList[index]);
    },
  );
}
