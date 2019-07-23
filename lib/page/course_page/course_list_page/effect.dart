import 'dart:developer';

import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/model/course/course.dart';
import 'action.dart';
import 'state.dart';

import 'package:myapp/common/dao/course_dao.dart';

Effect<CourseListState> buildEffect() {
  return combineEffects(<Object, Effect<CourseListState>>{
    Lifecycle.initState: _init,
  });
}

void _init(Action action, Context<CourseListState> ctx) async {
  if (ctx.state.categoryId != null) {
    try {
      List<CourseModel> courses =
          await CourseDao.getCourseList(categoryId: ctx.state.categoryId);
      ctx.dispatch(CourseListActionCreator.loadData(courses));
    } catch (e) {}
  }
}
