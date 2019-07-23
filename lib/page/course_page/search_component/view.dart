import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/common/constant/style.dart';

Widget buildView(
    SearchState state, Dispatch dispatch, ViewService viewService) {
  GestureTapCallback toSearch =
      () => dispatch(SearchActionCreator.gotoSearchPage());

  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: AppSize.width(36.0),
      vertical: AppSize.height(20.0),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSize.width(20.0),
            ),
            margin: EdgeInsets.only(right: AppSize.width(28.0)),
            height: AppSize.height(64.0),
            decoration: BoxDecoration(
              color: Color(0xFFF4F5F7),
              borderRadius: BorderRadius.all(Dimens.radius_8),
            ),
            child: InkWell(
              onTap: toSearch,
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'assets/images/icn_search.png',
                    width: AppSize.width(26.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: AppSize.width(10.0)),
                    child: Text(
                      '课程、老师、关键词',
                      style: TextStyle(
                        fontSize: AppSize.sp(26.0),
                        color: Colours.textSecond,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          flex: 1,
        ),
        InkWell(
          onTap: toSearch,
          child: Image.asset(
            'assets/images/icn_history.png',
            width: AppSize.width(40.0),
          ),
        ),
      ],
    ),
  );
}
