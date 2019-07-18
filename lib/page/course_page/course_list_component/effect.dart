import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<CourseListState> buildEffect() {
  return combineEffects(<Object, Effect<CourseListState>>{
    CourseListAction.action: _onAction,
  });
}

void _onAction(Action action, Context<CourseListState> ctx) {
}
