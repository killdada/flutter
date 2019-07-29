import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/constant/style.dart';
import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/page/search_page/search_header_component/action.dart';

import 'action.dart';
import 'state.dart';

Widget _historyItem(String text, Dispatch dispatch) {
  return GestureDetector(
    onTap: () {
      dispatch(SearchHeaderActionCreator.onDoSearch(text));
    },
    child: Container(
      height: AppSize.height(55.0),
      //   alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.width(20.0),
        vertical: AppSize.height(10.0),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppSize.height(50.0),
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colours.textFirst,
          fontSize: Dimens.sp_28,
        ),
      ),
    ),
  );
}

Widget buildView(
    HistoryState state, Dispatch dispatch, ViewService viewService) {
  List<Map> data = state.historyList;
  if (data == null || data.isEmpty) {
    return SizedBox(height: 0);
  }
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSize.height(15.0),
            horizontal: AppSize.width(36.0),
          ),
          child: Row(
            children: <Widget>[
              Text(
                '搜索历史',
                style: TextStyle(
                  fontSize: AppSize.sp(32.0),
                  color: Colours.textFirst,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Spacer(
                flex: 1,
              ),
              InkWell(
                child: Icon(
                  CupertinoIcons.delete,
                  color: Colours.textFirst,
                  size: AppSize.sp(45.0),
                ),
                onTap: () {
                  dispatch(HistoryActionCreator.onClearHistory());
                },
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: AppSize.height(10.0),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppSize.width(36.0),
          ),
          child: Wrap(
            spacing: AppSize.width(15.0),
            runSpacing: AppSize.width(20.0),
            children: data.map((item) {
              return _historyItem(item['value'], dispatch);
            }).toList(),
          ),
        ),
      ],
    ),
  );
}
