import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/model/course/category.dart';

class TabbarState implements Cloneable<TabbarState> {
  List<CategoryModel> tabbarList;
  Map<int, List> courseData; // 所有的课程列表state,用分类ID 区分
  @override
  TabbarState clone() {
    return TabbarState()
      ..courseData = courseData
      ..tabbarList = tabbarList;
  }
}

TabbarState initState(Map<String, dynamic> args) {
  return TabbarState();
}
