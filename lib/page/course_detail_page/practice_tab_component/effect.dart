import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<PracticeTabState> buildEffect() {
  return combineEffects(<Object, Effect<PracticeTabState>>{
    PracticeTabAction.action: _onAction,
  });
}

void _onAction(Action action, Context<PracticeTabState> ctx) {
}
