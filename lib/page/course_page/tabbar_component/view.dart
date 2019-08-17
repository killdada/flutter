

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/common/constant/style.dart';

import 'package:myapp/page/course_page/course_list_page/page.dart';

Widget buildView(
    TabbarState state, Dispatch dispatch, ViewService viewService) {
  final List categories = state.tabbarList == null ? [] : state.tabbarList;
  if (categories.isEmpty) {
    return Container();
  }
  return DefaultTabController(
    length: categories.length,
    child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(
            AppSize.width(40.0),
            AppSize.height(22.0),
            AppSize.width(40.0),
            AppSize.height(8.0),
          ),
          height: AppSize.height(88.0),
          child: TabBar(
            isScrollable: true,
            indicatorColor: Colours.blue,
            indicatorWeight: AppSize.height(6.0),
            indicatorSize: TabBarIndicatorSize.label,
            labelPadding: EdgeInsets.symmetric(horizontal: AppSize.width(20.0)),
            labelColor: Colours.textFirst,
            labelStyle: TextStyle(fontSize: Dimens.sp_32),
            unselectedLabelColor: Colours.textSecond,
            unselectedLabelStyle: TextStyle(fontSize: Dimens.sp_28),
            tabs: categories
                .map((category) => Text(category.categoryName ?? '空'))
                .toList(),
          ),
        ),
        Expanded(
          flex: 1,
          child: TabBarView(
            children: categories.map((item) {
              return CourseListPage().buildPage({'id': item.categoryId});
              //   return viewService.buildComponent('courseList');
            }).toList(),
          ),
        ),
      ],
    ),
  );
}
