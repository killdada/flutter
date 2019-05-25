import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:myapp/common/utils/appsize.dart';

import './course.dart';
import './my.dart';

class PageContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PageContainerState();
}

class _NavItem {
  String title, tabImageActive, tabImage;
  _NavItem(this.title, this.tabImage, this.tabImageActive);
}

class PageContainerState extends State<PageContainer> {
  int _tabIndex = 0;

  var _body;
  var pages;

  final tabItems = [
    _NavItem('上课', 'assets/images/tab_class_nor.png',
        'assets/images/tab_class_sel.png'),
    _NavItem('我的', 'assets/images/tab_personal_nor.png',
        'assets/images/tab_personal_sel.png'),
  ];

  Image getTabImage(path) {
    return Image.asset(
      path,
      width: AppSize.width(75.0),
      height: AppSize.width(75.0),
    );
  }

  @override
  void initState() {
    super.initState();
    pages = <Widget>[Course(), My()];
  }

  BottomNavigationBarItem _getBarItem(_NavItem item, int index) {
    return BottomNavigationBarItem(
      icon: index == _tabIndex
          ? getTabImage(item.tabImageActive)
          : getTabImage(item.tabImage),
      title: Text(
        item.title,
        style: TextStyle(fontSize: AppSize.sp(20)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppSize.initDesignSize(context: context);
    _body = IndexedStack(
      children: pages,
      index: _tabIndex,
    );
    List<BottomNavigationBarItem> navitems = [];

    for (int i = 0; i < tabItems.length; i++) {
      navitems.add(_getBarItem(tabItems[i], i));
    }

    return Scaffold(
      body: _body,
      bottomNavigationBar: CupertinoTabBar(
        items: navitems,
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
