import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/dao/course_detail_dao.dart';
import 'package:myapp/common/model/course-detail/course_detail_model.dart';
import 'action.dart';
import 'state.dart';

Effect<PracticeTabState> buildEffect() {
  return combineEffects(<Object, Effect<PracticeTabState>>{
    Lifecycle.initState: _init,
    PracticeTabAction.onChangeSortType: _onChangeSortType,
  });
}

Future _init(Action action, Context<PracticeTabState> ctx) async {
  CourseDetailModel detail = ctx.state.practiceData;
  if (detail.topicId != null) {
    await CourseDetailDao.getPracticeDetail(detail.topicId, ctx.state.sortType);
  }
}

void _onChangeSortType(Action action, Context<PracticeTabState> ctx) async {
  ctx.dispatch(PracticeTabActionCreator.changeSortType(action.payload));
  await _init(action, ctx);
}
