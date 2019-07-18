import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<CourseState> buildEffect() {
  return combineEffects(<Object, Effect<CourseState>>{
    CourseAction.action: _onAction,
  });
}

void _onAction(Action action, Context<CourseState> ctx) {
}
