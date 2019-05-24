import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:myapp/common/utils/appsize.dart';

import './course.dart';
import './my.dart';

class PageContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageContainerState();
}

class PageContainerState extends State<PageContainer> {
  final appBarTitles = ['课程', '我的'];
  final tabTextStyleSelected = TextStyle(color: const Color(0xff63ca6c));
  final tabTextStyleNormal = TextStyle(color: const Color(0xff969696));

  int _tabIndex = 0;

  var tabImages;
  var _body;
  var pages;

  Image getTabImage(path) {
    return Image.asset(path, width: 20.0, height: 20.0);
  }

  @override
  void initState() {
    super.initState();
    pages = <Widget>[Course(), My()];
    if (tabImages == null) {
      tabImages = [
        [
          getTabImage('assets/images/nav/ic_nav_news_normal.png'),
          getTabImage('assets/images/nav/ic_nav_news_actived.png')
        ],
        [
          getTabImage('assets/images/nav/ic_nav_my_normal.png'),
          getTabImage('assets/images/nav/ic_nav_my_pressed.png')
        ]
      ];
    }
  }

  TextStyle getTabTextStyle(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabTextStyleSelected;
    }
    return tabTextStyleNormal;
  }

  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }

  Text getTabTitle(int curIndex) {
    return Text(appBarTitles[curIndex], style: getTabTextStyle(curIndex));
  }

  @override
  Widget build(BuildContext context) {
    AppSize.initDesignSize(context: context);
    _body = IndexedStack(
      children: pages,
      index: _tabIndex,
    );
    return Scaffold(
      body: _body,
      bottomNavigationBar: CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: getTabIcon(0), title: getTabTitle(0)),
          BottomNavigationBarItem(icon: getTabIcon(1), title: getTabTitle(1)),
        ],
        currentIndex: _tabIndex,
        onTap: (int index) {
          setState(() {
            _tabIndex = index;
          });
        },
      ),
    );
  }
}
