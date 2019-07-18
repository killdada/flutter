import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/common/utils/date_utils.dart';
import 'package:myapp/common/constant/style.dart';

import 'package:fluro/fluro.dart';
import 'package:myapp/router/application.dart';

Widget buildView(
    SearchState state, Dispatch dispatch, ViewService viewService) {
  GestureTapCallback toSearch = () {
    // Application.router.navigateTo(
    //   context,
    //   '/search',
    //   transition: TransitionType.native,
    // );
  };
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: AppSize.width(52.0),
      vertical: AppSize.height(17.0),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSize.width(32.0),
            ),
            margin: EdgeInsets.only(right: AppSize.width(40.0)),
            height: AppSize.height(92.0),
            decoration: BoxDecoration(
              color: Color(0xFFF4F5F7),
              borderRadius: BorderRadius.all(Dimens.radius_12),
            ),
            child: InkWell(
              onTap: toSearch,
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'assets/images/icn_search.png',
                    width: AppSize.width(38.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: AppSize.width(32.0)),
                    child: Text(
                      '课程、老师、关键词',
                      style: TextStyle(
                        fontSize: AppSize.sp(37.0),
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
            width: AppSize.width(58.0),
          ),
        ),
      ],
    ),
  );
}
