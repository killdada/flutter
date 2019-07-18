import 'package:fish_redux/fish_redux.dart';

import 'reducer.dart';
import 'state.dart';

class CourseListAdapter extends DynamicFlowAdapter<CourseListState> {
  CourseListAdapter()
      : super(
          pool: <String, Component<Object>>{},
          connector: _CourseListConnector(),
          reducer: buildReducer(),
        );
}

class _CourseListConnector extends ConnOp<CourseListState, List<ItemBean>> {
  @override
  List<ItemBean> get(CourseListState state) {
    return <ItemBean>[];
  }

  @override
  void set(CourseListState state, List<ItemBean> items) {}

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
