import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class SearchHeaderState implements Cloneable<SearchHeaderState> {
  String keyword = '';
  int index = 0;
  TextEditingController editingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  @override
  SearchHeaderState clone() {
    return SearchHeaderState()
      ..keyword = keyword
      ..editingController = editingController
      ..focusNode = focusNode
      ..index = index;
  }
}

SearchHeaderState initState(Map<String, dynamic> args) {
  return SearchHeaderState();
}
