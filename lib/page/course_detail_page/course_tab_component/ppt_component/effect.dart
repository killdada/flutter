import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<PptState> buildEffect() {
  return combineEffects(<Object, Effect<PptState>>{
    PptAction.action: _onAction,
  });
}

void _onAction(Action action, Context<PptState> ctx) {
}
