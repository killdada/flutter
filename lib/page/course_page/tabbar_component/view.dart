import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/common/constant/style.dart';

Widget buildView(
    TabbarState state, Dispatch dispatch, ViewService viewService) {
  final List categories = state.tabbarList == null ? [] : state.tabbarList;
  return DefaultTabController(
    length: categories.length,
    child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(
            AppSize.width(52.0),
            AppSize.width(32.0),
            AppSize.width(52.0),
            AppSize.width(12.0),
          ),
          height: AppSize.height(127.0),
          child: TabBar(
            isScrollable: true,
            indicatorColor: Colours.blue,
            indicatorWeight: AppSize.height(6.0),
            indicatorSize: TabBarIndicatorSize.label,
            labelPadding: EdgeInsets.symmetric(horizontal: AppSize.width(20.0)),
            labelColor: Colours.textFirst,
            labelStyle: TextStyle(fontSize: Dimens.sp_45),
            unselectedLabelColor: Colours.textSecond,
            unselectedLabelStyle: TextStyle(fontSize: Dimens.sp_40),
            tabs: categories
                .map((category) => Text(category.categoryName ?? '空'))
                .toList(),
          ),
        ),
        Expanded(
          flex: 1,
          child: TabBarView(
            children: categories.map((item) {
              return viewService.buildComponent('courseList');
            }).toList(),
          ),
        ),
      ],
    ),
  );
}
