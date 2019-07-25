import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class SearchHeaderState implements Cloneable<SearchHeaderState> {
  String keyword = '';
  TextEditingController editingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  @override
  SearchHeaderState clone() {
    return SearchHeaderState()
      ..keyword = keyword
      ..editingController = editingController
      ..focusNode = focusNode;
  }
}

SearchHeaderState initState(Map<String, dynamic> args) {
  return SearchHeaderState();
}
