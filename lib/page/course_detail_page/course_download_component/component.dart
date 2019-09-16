import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class CourseDownloadComponent extends Component<CourseDownloadState> {
  CourseDownloadComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<CourseDownloadState>(
                adapter: null,
                slots: <String, Dependent<CourseDownloadState>>{
                }),);

}
