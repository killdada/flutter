import 'dart:developer';

import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

import 'package:myapp/common/dao/course_dao.dart';

Effect<CourseState> buildEffect() {
  return combineEffects(<Object, Effect<CourseState>>{
    Lifecycle.initState: _init,
  });
}

void _onAction(Action action, Context<CourseState> ctx) {}

void _init(Action action, Context<CourseState> ctx) async {
  try {
    List banners = await CourseDao.getBanners();
    ctx.dispatch(CourseActionCreator.fetchBanner(banners));
    List categories = await CourseDao.getCategories();
    ctx.dispatch(CourseActionCreator.fetchCategory(categories));
    List courses =
        await CourseDao.getCourseList(categoryId: ctx.state.categoryId);
    ctx.dispatch(CourseActionCreator.fetchCourseList(courses));
  } catch (e) {}
}
