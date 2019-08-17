
import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/model/course/course.dart';
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
    if (state.courseList?.isNotEmpty == true) {
      return state.courseList
          .map<ItemBean>((CourseModel data) => ItemBean('courselist', data))
          .toList(growable: true);
    } else {
      return <ItemBean>[];
    }
  }

  @override
  void set(SearchState state, List<ItemBean> items) {}

  @override
  subReducer(reducer) {
    return super.subReducer(reducer);
  }
}
