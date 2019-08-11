import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';
import '../action.dart';

Effect<CourseTabState> buildEffect() {
  return combineEffects(<Object, Effect<CourseTabState>>{
    CourseTabAction.onChangeCurrentTab: _onChangeCurrentTab,
  });
}

void _onChangeCurrentTab(Action action, Context<CourseTabState> ctx) {
  ctx.dispatch(CourseDetailActionCreator.changeCurrentTab(action.payload));
}
