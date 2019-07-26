import 'dart:developer';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/common/dao/search_dao.dart';
import 'package:myapp/common/db/search_history_db.dart';
import 'package:myapp/common/utils/appsize.dart';
import 'action.dart';
import 'state.dart';

import '../action.dart';

Effect<SearchHeaderState> buildEffect() {
  return combineEffects(<Object, Effect<SearchHeaderState>>{
    SearchHeaderAction.onCancel: _onCancel,
    SearchHeaderAction.onDoSearch: _onDoSearch,
  });
}

showToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: Color(0xFF999999),
      textColor: Colors.white,
      fontSize: AppSize.sp(30));
}

void _onCancel(Action action, Context<SearchHeaderState> ctx) {}

void _onDoSearch(Action action, Context<SearchHeaderState> ctx) async {
  String text = action.payload;
  String tmpStr = text.replaceAll(" ", "");
  if (tmpStr == null || tmpStr.isEmpty) {
    showToast('请输入有效关键词');
    return;
  }
  SearchHistoryDb provider = new SearchHistoryDb();
  provider.addHistory(text);
  List data = await SearchDao.search(text);
  ctx.dispatch(SearchActionCreator.changeIndexedStack(1));
  ctx.dispatch(SearchActionCreator.loadSearchResult(data));
}
