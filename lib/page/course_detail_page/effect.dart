import 'dart:developer';

import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/dao/course_detail_dao.dart';
import 'package:myapp/common/model/course-detail/course_detail_model.dart';
import 'action.dart';
import 'state.dart';

Effect<CourseDetailState> buildEffect() {
  return combineEffects(<Object, Effect<CourseDetailState>>{
    Lifecycle.initState: _onFetchDetail,
    CourseDetailAction.onFetchDetail: _onFetchDetail,
  });
}

void _onFetchDetail(Action action, Context<CourseDetailState> ctx) async {
  CourseDetailModel detail =
      await CourseDetailDao.getCourseDetail(ctx.state.courseId);
  ctx.dispatch(CourseDetailActionCreator.detailDataLoaded(detail));
}
