import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/dao/search_dao.dart';
import 'action.dart';
import 'state.dart';

Effect<SearchState> buildEffect() {
  return combineEffects(<Object, Effect<SearchState>>{
    SearchAction.onChangeIndexedStack: _onchangeIndexedStack,
    SearchAction.fetchCourseList: _onfetchCourseList,
  });
}

void _onchangeIndexedStack(Action action, Context<SearchState> ctx) {
  ctx.dispatch(SearchActionCreator.changeIndexedStack(action.payload));
}

void _onfetchCourseList(Action action, Context<SearchState> ctx) async {
  await SearchDao.search(action.payload);
  ctx.dispatch(SearchActionCreator.fetchCourseList(action.payload));
}
