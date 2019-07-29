import 'dart:developer';

import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<HistoryState> buildReducer() {
  return asReducer(
    <Object, Reducer<HistoryState>>{
      HistoryAction.clearHistory: _clearHistory,
      HistoryAction.loadHistory: _loadHistory,
    },
  );
}

HistoryState _clearHistory(HistoryState state, Action action) {
  final HistoryState newState = state.clone();
  List<Map> historyList = [];
  newState.historyList = historyList;
  return newState;
}

HistoryState _loadHistory(HistoryState state, Action action) {
  final HistoryState newState = state.clone();
  newState.historyList = action.payload;
  return newState;
}
