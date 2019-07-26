import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SearchAction {
  onChangeIndexedStack,
  changeIndexedStack,
  fetchCourseList,
  loadSearchResult
}

class SearchActionCreator {
  static Action onChangeIndexedStack(int index) {
    return Action(SearchAction.onChangeIndexedStack, payload: index);
  }

  static Action changeIndexedStack(int index) {
    return Action(SearchAction.changeIndexedStack, payload: index);
  }

  static Action fetchCourseList(String key) {
    return Action(SearchAction.fetchCourseList, payload: key);
  }

  static Action loadSearchResult(List courses) {
    return Action(SearchAction.loadSearchResult, payload: courses);
  }
}
