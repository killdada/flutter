import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

import 'dart:developer';
import 'package:myapp/common/dao/course_dao.dart';

Effect<TabbarState> buildEffect() {
  return combineEffects(<Object, Effect<TabbarState>>{
    Lifecycle.initState: _init,
  });
}

void _init(Action action, Context<TabbarState> ctx) async {
  if (ctx.state.categoryId != null) {
    List courses = await CourseDao.getCourseList();
    ctx.dispatch(TabbarActionCreator.loadData(courses));
  }
}
