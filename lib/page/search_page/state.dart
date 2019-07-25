import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/model/course/course.dart';
import 'package:myapp/page/search_page/history_component/state.dart';
import 'package:myapp/page/search_page/search_header_component/state.dart';

class SearchState implements Cloneable<SearchState> {
  String keyword = '';
  List historyList = [];
  List<CourseModel> courseList;
  int index = 0;
  TextEditingController editingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  SearchState clone() {
    return SearchState()
      ..keyword = keyword
      ..historyList = historyList
      ..editingController = editingController
      ..focusNode = focusNode
      ..courseList = courseList
      ..index = index;
  }
}

SearchState initState(Map<String, dynamic> args) {
  return SearchState();
}

class SearchHeaderConnector
    extends Reselect1<SearchState, SearchHeaderState, String> {
  @override
  SearchHeaderState computed(String sub0) {
    return SearchHeaderState()..keyword = sub0;
  }

  @override
  String getSub0(SearchState state) {
    return state.keyword;
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
    throw Exception('Unexcepted to set SearchState from HistoryState');
  }
}
