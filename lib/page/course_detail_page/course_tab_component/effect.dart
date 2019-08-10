import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<CourseTabState> buildEffect() {
  return combineEffects(<Object, Effect<CourseTabState>>{
    CourseTabAction.action: _onAction,
  });
}

void _onAction(Action action, Context<CourseTabState> ctx) {
}
