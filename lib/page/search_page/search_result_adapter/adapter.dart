import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/page/search_page/search_course_list_component/component.dart';

import '../reducer.dart';
import '../state.dart';

class SearchResultAdapter extends DynamicFlowAdapter<SearchState> {
  SearchResultAdapter()
      : super(
          pool: <String, Component<Object>>{
            'courselist': SearchCourseListComponent()
          },
          connector: _SearchResultConnector(),
          reducer: buildReducer(),
        );
}

class _SearchResultConnector extends ConnOp<SearchState, List<ItemBean>> {
  @override
  List<ItemBean> get(SearchState state) {
    List<ItemBean> items = [];
    items.add(ItemBean("courselist", state.courseList));
    return <ItemBean>[];
  }

  @override
  void set(SearchState state, List<ItemBean> items) {}

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
