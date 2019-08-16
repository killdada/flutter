import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/common/constant/constant.dart';
import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/page/course_detail_page/vedio_page/page.dart';
import 'package:myapp/widget/list_placeholder.dart';
import 'package:myapp/widget/video_player_gather.dart';

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
  bool isSimple = state.videoEventData.videoModel == VideoModel.simple;
  if (state.tabController == null) {
    return Container();
  }
  if (isSimple) {
    return viewService.buildComponent('courseTab');
  }
  return TabBarView(
    controller: state.tabController,
    children: tabs.map((item) {
      if (item == '开始上课') {
        if (state.courseDetail == null || state.courseDetail.catalogs.isEmpty) {
          return ListPlaceholder.empty();
        }
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
  if (state.courseDetail == null) {
    return Container(
      color: Colors.white,
      child: CupertinoActivityIndicator(),
    );
  }
  return Scaffold(
    body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: NestedScrollView(
        physics: NeverScrollableScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          List<Widget> child = [];
          bool isSimple = state.videoEventData.videoModel == VideoModel.simple;
          if (state.courseDetail != null) {
            child.add(
              VedioPage().buildPage({
                'courseId': state.courseDetail.courseId,
                'catalog': state.currentCatalog,
                'coverUrl': state.courseDetail.imgUrl
              }),
            );
          }
          if (!isSimple) {
            child.add(viewService.buildComponent('vedioOperation'));
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
          }
          return child;
        },
        body: _body(state, dispatch, viewService, tabs),
      ),
    ),
  );
}
