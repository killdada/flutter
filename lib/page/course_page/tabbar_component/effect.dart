import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<TabbarState> buildEffect() {
  return combineEffects(<Object, Effect<TabbarState>>{
    Lifecycle.initState: _init,
  });
}

void _init(Action action, Context<TabbarState> ctx) {}
