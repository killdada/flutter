import 'dart:developer';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/common/constant/style.dart';
import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/widget/video_player_gather.dart';

import 'action.dart';
import 'state.dart';

Widget _tabBarWiget(List tabs, CourseDetailState state) {
  return TabBar(
    controller: state.tabController,
    indicatorColor: Color(0xFF1D9DFF),
    indicatorWeight: 2,
    indicatorSize: TabBarIndicatorSize.label,
    labelColor: Color(0xFF4A4A4A),
    labelStyle: TextStyle(fontSize: 16),
    unselectedLabelColor: Color(0xFFA4A4A4),
    unselectedLabelStyle: TextStyle(fontSize: 16),
    tabs: tabs.map((tab) => Tab(text: tab)).toList(),
  );
}

Widget _bodyWidget(
  List tabs,
  CourseDetailState state,
  Dispatch dispatch,
  ViewService viewService,
) {
  if (state.tabController == null) {
    return Container();
  }
  return TabBarView(
    controller: state.tabController,
    children: tabs.map((item) {
      if (item == '开始上课') {
        return viewService.buildComponent('courseTab');
      } else if (item == '课后练习') {
        return viewService.buildComponent('practiceTab');
      }
      return Container();
    }).toList(),
  );
}

Widget _downloadWidget() {
  return Text('正在开发');
}

Widget _body(CourseDetailState state, Dispatch dispatch,
    ViewService viewService, List tabs) {
  return Container(
    color: Colors.white,
    child: IndexedStack(
      index: state.index,
      children: <Widget>[
        _bodyWidget(
          tabs,
          state,
          dispatch,
          viewService,
        ),
        _downloadWidget(),
      ],
    ),
  );
}

Widget buildView(
    CourseDetailState state, Dispatch dispatch, ViewService viewService) {
  List<String> tabs = state.index == 0 ? ["开始上课", "课后练习"] : ['视频', '音频'];

  return Scaffold(
    body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          List<Widget> child = [
            viewService.buildComponent('vedio'),
            viewService.buildComponent('vedioOperation'),
          ];
          if (state.tabController != null) {
            child.add(SliverPersistentHeader(
              key: Key(state.index.toString()),
              delegate: SliverTabBarDelegate(
                _tabBarWiget(tabs, state),
                color: Colors.white,
              ),
              pinned: true,
            ));
          }
          return child;
        },
        body: _body(state, dispatch, viewService, tabs),
      ),
    ),
  );
}
