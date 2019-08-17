import 'package:fish_redux/fish_redux.dart';

enum HistoryAction { onClearHistory, clearHistory, loadHistory }

class HistoryActionCreator {
  static Action onClearHistory() {
    return const Action(HistoryAction.onClearHistory);
  }

  static Action clearHistory() {
    return const Action(HistoryAction.clearHistory);
  }

  static Action loadHistory(List list) {
    return Action(HistoryAction.loadHistory, payload: list);
  }
}
