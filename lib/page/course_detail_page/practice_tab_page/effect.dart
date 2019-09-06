import 'dart:developer';

import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/dao/course_detail_dao.dart';
import 'package:myapp/common/model/course-detail/course_detail_model.dart';
import 'package:myapp/common/model/course-detail/course_detail_topic_model.dart';
import 'action.dart';
import 'state.dart';

Effect<PracticeTabState> buildEffect() {
  return combineEffects(<Object, Effect<PracticeTabState>>{
    Lifecycle.initState: _init,
    PracticeTabAction.onChangeSortType: _onChangeSortType,
    PracticeTabAction.onFetchData: _init,
  });
}

Future fetchData(Context<PracticeTabState> ctx, String sort) async {
  CourseDetailModel detail = ctx.state.practiceData;
  if (detail.topicId != null) {
    CourseDetailTopicModel topicDetail =
        await CourseDetailDao.getPracticeDetail(detail.topicId, sort);
    ctx.dispatch(PracticeTabActionCreator.initTopicDetail(topicDetail));
  }
}

Future _init(Action action, Context<PracticeTabState> ctx) async {
  CourseDetailModel detail = ctx.state.practiceData;
  if (detail.topicId != null) {
    fetchData(ctx, ctx.state.sortType);
  }
}

void _onChangeSortType(Action action, Context<PracticeTabState> ctx) async {
  await fetchData(ctx, action.payload);
  ctx.dispatch(PracticeTabActionCreator.changeSortType(action.payload));
}
