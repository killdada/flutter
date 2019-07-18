import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class CourseListComponent extends Component<CourseListState> {
  CourseListComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<CourseListState>(
                adapter: null,
                slots: <String, Dependent<CourseListState>>{
                }),);

}
