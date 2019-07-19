import 'package:flutter/cupertino.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/page/course_page/banner_component/state.dart';
import 'package:myapp/page/course_page/search_component/state.dart';
import 'package:myapp/page/course_page/tabbar_component/state.dart';

import 'package:myapp/common/model/course/banner.dart';
import 'package:myapp/common/model/course/category.dart';

class CourseState implements Cloneable<CourseState> {
  int categoryId;
  String keyword;
  List<BannerModel> bannerList;
  List<CategoryModel> tabbarList;

  @override
  CourseState clone() {
    return CourseState()
      ..keyword = keyword
      ..bannerList = bannerList
      ..tabbarList = tabbarList
      ..categoryId = categoryId;
  }
}

CourseState initState(Map<String, dynamic> args) {
  return CourseState();
}

class SearchConnector extends Reselect1<CourseState, SearchState, String> {
  @override
  SearchState computed(String sub0) {
    return SearchState()..keyword = sub0;
  }

  @override
  String getSub0(CourseState state) {
    return state.keyword;
  }

  @override
  void set(CourseState state, SearchState subState) {
    throw Exception('Unexcepted to set CourseState from SearchState');
  }
}

class BannerConnector extends Reselect1<CourseState, BannerState, List> {
  @override
  BannerState computed(List sub0) {
    return BannerState()..bannerList = sub0;
  }

  @override
  List getSub0(CourseState state) {
    return state.bannerList;
  }

  @override
  void set(CourseState state, BannerState subState) {
    throw Exception('Unexcepted to set CourseState from BannerState');
  }
}

class TabbarConnector extends Reselect2<CourseState, TabbarState, List, int> {
  @override
  TabbarState computed(List sub0, int sub1) {
    return TabbarState()
      ..tabbarList = sub0
      ..categoryId;
  }

  @override
  List getSub0(CourseState state) {
    return state.tabbarList;
  }

  @override
  void set(CourseState state, TabbarState subState) {
    throw Exception('Unexcepted to set CourseState from TabbarState');
  }
}
