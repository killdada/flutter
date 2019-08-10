import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<VedioOperationState> buildEffect() {
  return combineEffects(<Object, Effect<VedioOperationState>>{
    VedioOperationAction.action: _onAction,
  });
}

void _onAction(Action action, Context<VedioOperationState> ctx) {
}
