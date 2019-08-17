import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter/material.dart' hide Action;
import 'package:myapp/common/db/search_history_db.dart';
import 'action.dart';
import 'state.dart';

Effect<HistoryState> buildEffect() {
  return combineEffects(<Object, Effect<HistoryState>>{
    HistoryAction.onClearHistory: _onclearHistory,
  });
}

void _onclearHistory(Action action, Context<HistoryState> ctx) {
  showDialog(
    context: ctx.context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text('提示'),
        content: Text('确定清空历史记录？'),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text('取消'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            child: Text('确定'),
            onPressed: () async {
              SearchHistoryDb provider = new SearchHistoryDb();
              await provider.deleteHistory();
              ctx.dispatch(HistoryActionCreator.clearHistory());
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
