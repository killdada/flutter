import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SearchAction { changeIndexedStack }

class SearchActionCreator {
  static Action changeIndexedStack(int index) {
    return Action(SearchAction.changeIndexedStack, payload: index);
  }
}
