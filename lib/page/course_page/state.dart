import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/page/course_page/banner_component/state.dart';
import 'package:myapp/page/course_page/search_component/state.dart';
import 'package:myapp/page/course_page/tabbar_component/state.dart';

class CourseState implements Cloneable<CourseState> {
  String keyword;
  List<BannerState> bannerList;
  List<TabbarState> tabbarList;

  @override
  CourseState clone() {
    return CourseState()..keyword = keyword;
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

class TabbarConnector extends Reselect1<CourseState, TabbarState, List> {
  @override
  TabbarState computed(List sub0) {
    return TabbarState()..tabbarList = sub0;
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
