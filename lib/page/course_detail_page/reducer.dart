import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/model/course-detail/course_detail_model.dart';

import 'action.dart';
import 'state.dart';

Reducer<CourseDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<CourseDetailState>>{
      CourseDetailAction.detailDataLoaded: _detailDataLoaded,
    },
  );
}

CourseDetailState _detailDataLoaded(CourseDetailState state, Action action) {
  final CourseDetailState newState = state.clone();
  CourseDetailModel detail = action.payload;
  newState.courseDetail = action.payload;
  if (detail.catalogs.isNotEmpty) {
    newState.currentCatalog = detail.catalogs[0];
  }
  return newState;
}
