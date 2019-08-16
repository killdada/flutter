import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';
import 'adapter.dart';

class CourseTabComponent extends Component<CourseTabState> {
  CourseTabComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<CourseTabState>(
              adapter: NoneConn<CourseTabState>() + CourseTabAdapter(),
              slots: <String, Dependent<CourseTabState>>{}),
        );
}
