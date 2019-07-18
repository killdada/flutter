import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<CourseDetailState> buildEffect() {
  return combineEffects(<Object, Effect<CourseDetailState>>{
    CourseDetailAction.action: _onAction,
  });
}

void _onAction(Action action, Context<CourseDetailState> ctx) {
}
