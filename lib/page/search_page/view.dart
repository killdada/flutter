import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/widget/list_placeholder.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    SearchState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    resizeToAvoidBottomInset: false,
    body: WillPopScope(
      child: SafeArea(
        top: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            viewService.buildComponent('search'),
            Flexible(
              child: IndexedStack(
                index: state.index,
                children: <Widget>[
                  viewService.buildComponent('history'),
                  _searchResult(state, dispatch, viewService),
                ],
              ),
            ),
          ],
        ),
      ),
      onWillPop: () {
        if (state.index != 0) {
          dispatch(SearchActionCreator.changeIndexedStack(0));
          return Future.value(false);
        }
        return Future.value(true);
      },
    ),
  );
}

Widget _searchResult(
    SearchState state, Dispatch dispatch, ViewService viewService) {
  final data = state.courseList;
  if (data == null) {
    return Center(
      child: CupertinoActivityIndicator(),
    );
  }
  if (data.isEmpty) {
    return ListPlaceholder.empty(
      hint: '没有搜索到任何结果',
    );
  }
  final ListAdapter adapter = viewService.buildAdapter();

  return ListView.builder(
      itemBuilder: adapter.itemBuilder, itemCount: adapter.itemCount);
}
