import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/model/course/category.dart';

class TabbarState implements Cloneable<TabbarState> {
  List<CategoryModel> tabbarList;
  @override
  TabbarState clone() {
    return TabbarState()..tabbarList = tabbarList;
  }
}

TabbarState initState(Map<String, dynamic> args) {
  return TabbarState();
}
