import 'dart:developer';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/model/course/course.dart';

import 'action.dart';
import 'state.dart';

import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/common/constant/style.dart';

import 'package:myapp/page/course_page/course_list_adapter/adapter.dart';
import 'package:myapp/common/model/course/category.dart';

Widget buildView(
    TabbarState state, Dispatch dispatch, ViewService viewService) {
  final List categories = state.tabbarList == null ? [] : state.tabbarList;
  if (categories.isEmpty) {
    return Container();
  }
  return TabBarViewWidget(categories, viewService);
}

/**
 * 如何在fish_redux中使用tabbarView:其实就是把tabbarview封装在一个StatefulWidget就行了
 * https://github.com/alibaba/fish-redux/issues/58
 */
class TabBarViewWidget extends StatefulWidget {
  final List<CategoryModel> tabs;
  final ViewService viewService;

  TabBarViewWidget(this.tabs, this.viewService);

  @override
  _TabBarViewWidgetState createState() => _TabBarViewWidgetState();
}

class _TabBarViewWidgetState extends State<TabBarViewWidget>
    with TickerProviderStateMixin {
  List<Widget> tabs;

  TabController tabController;
  PageController pageController;

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    tabController = new TabController(length: widget.tabs.length, vsync: this);
    pageController = new PageController();

    tabs = new List();
    for (CategoryModel model in widget.tabs) {
      tabs.add(new Tab(
        text: model.categoryName ?? '空',
      ));
    }

    debugger();

    if (tabs.isEmpty || tabs.length == 0) {
      return Container();
    }

    return DefaultTabController(
      length: tabs.length,
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
              controller: tabController,
              onTap: (index) {
                pageController.animateToPage(index,
                    duration: Duration(milliseconds: 500), curve: Curves.ease);
              },
              isScrollable: true,
              indicatorColor: Colours.blue,
              indicatorWeight: AppSize.height(6.0),
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding:
                  EdgeInsets.symmetric(horizontal: AppSize.width(20.0)),
              labelColor: Colours.textFirst,
              labelStyle: TextStyle(fontSize: Dimens.sp_45),
              unselectedLabelColor: Colours.textSecond,
              unselectedLabelStyle: TextStyle(fontSize: Dimens.sp_40),
              tabs: tabs,
            ),
          ),
          Expanded(
            flex: 1,
            child: PageView.builder(
                itemCount: tabs.length,
                controller: pageController,
                onPageChanged: (index) {
                  print(index);
                  tabController.animateTo(index);
                },
                itemBuilder: (context, position) {
                  Map<String, dynamic> map = {
                    "cid": widget.tabs[position].categoryId
                  };
                  return widget.viewService.buildComponent('courseList');
                }),
            //   child: TabBarView(
            //     children: categories.map((item) {
            //       return viewService.buildComponent('courseList');
            //     }).toList(),
            //   ),
          ),
        ],
      ),
    );
  }
}
