import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<CourseCatalogState> buildEffect() {
  return combineEffects(<Object, Effect<CourseCatalogState>>{
    CourseCatalogAction.action: _onAction,
  });
}

void _onAction(Action action, Context<CourseCatalogState> ctx) {
}
