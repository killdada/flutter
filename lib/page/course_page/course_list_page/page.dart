import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class CourseListPage extends Page<CourseListState, Map<String, dynamic>> {
  CourseListPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<CourseListState>(
                adapter: null,
                slots: <String, Dependent<CourseListState>>{
                }),
            middleware: <Middleware<CourseListState>>[
            ],);

}
