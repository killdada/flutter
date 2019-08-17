
import 'package:fish_redux/fish_redux.dart';

enum SearchHeaderAction { onCancel, onDoSearch }

class SearchHeaderActionCreator {
  static Action onCancel() {
    return const Action(SearchHeaderAction.onCancel);
  }

  static Action onDoSearch(String key) {
    return Action(SearchHeaderAction.onDoSearch, payload: key);
  }
}
