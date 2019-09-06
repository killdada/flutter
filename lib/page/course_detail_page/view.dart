import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/common/constant/constant.dart';
import 'package:myapp/page/course_detail_page/vedio_page/page.dart';
import 'package:myapp/widget/custom_widget.dart';
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

Widget _operationHeader(ViewService viewService) {
  Size headSize = Size.fromHeight(66);
  return SliverPersistentHeader(
    pinned: true,
    delegate: SliverStickerHeader(
      height: headSize.height,
      child: PreferredSize(
        child: Container(
          child: Column(
            children: <Widget>[
              //下载、分享、反馈、收藏界面
              Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: viewService.buildComponent('vedioOperation'),
              ),
              Container(
                height: 8,
                color: Color(0xFFF7F7FA),
              ),
            ],
          ),
        ),
        preferredSize: headSize,
      ),
    ),
  );
}

Widget buildView(
    CourseDetailState state, Dispatch dispatch, ViewService viewService) {
  List<String> tabs = state.index == 0 ? ["开始上课", "课后练习"] : ['视频', '音频'];
  bool isSimple = state.videoEventData.videoModel == VideoModel.simple;
  bool isAudio = state.videoEventData.playType == PlayType.audio;

  print('当前是音频么是不是啊$isAudio');

  if (state.courseDetail == null) {
    return Container(
      color: Colors.white,
      child: CupertinoActivityIndicator(),
    );
  }
  if (state.currentCatalog == null) {
    return CommonScaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: state.courseDetail.courseName,
      ),
      body: ListPlaceholder.empty(),
    );
  }
  if (isAudio) {
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
          if (state.courseDetail != null) {
            child.add(
              VedioPage().buildPage({
                'courseId': state.courseDetail.courseId,
                'catalog': state.currentCatalog,
                'videEventData': state.videoEventData,
                'coverUrl': state.courseDetail.imgUrl
              }),
            );
          }
          if (!isSimple) {
            child.add(_operationHeader(viewService));
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
