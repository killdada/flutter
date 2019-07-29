import 'dart:developer';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/model/course/course.dart';
import 'package:myapp/page/search_page/history_component/state.dart';
import 'package:myapp/page/search_page/search_header_component/state.dart';

class SearchState implements Cloneable<SearchState> {
  List<CourseModel> courseList;
  int index = 0;
  List<Map> historyList = [];

  @override
  SearchState clone() {
    return SearchState()
      ..courseList = courseList
      ..historyList = historyList
      ..index = index;
  }
}

SearchState initState(Map<String, dynamic> args) {
  return SearchState();
}

class SearchHeaderConnector
    extends Reselect1<SearchState, SearchHeaderState, int> {
  @override
  SearchHeaderState computed(int sub0) {
    return SearchHeaderState()..index = sub0;
  }

  @override
  int getSub0(SearchState state) {
    return state.index;
  }

  @override
  void set(SearchState state, SearchHeaderState subState) {
    throw Exception('Unexcepted to set SearchState from SearchHeaderState');
  }
}

class HistoryConnector extends Reselect1<SearchState, HistoryState, List> {
  @override
  HistoryState computed(List sub0) {
    return HistoryState()..historyList = sub0;
  }

  @override
  List getSub0(SearchState state) {
    return state.historyList;
  }

  @override
  void set(SearchState state, HistoryState subState) {
    state.historyList = subState.historyList;
  }
}
