import 'package:fish_redux/fish_redux.dart';

class HistoryState implements Cloneable<HistoryState> {
  List historyList = [];
  @override
  HistoryState clone() {
    return HistoryState()..historyList = historyList;
  }
}

HistoryState initState(Map<String, dynamic> args) {
  return HistoryState();
}
