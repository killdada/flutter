import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

class SearchCourseListComponent extends Component<SearchCourseListState> {
  SearchCourseListComponent()
      : super(
          view: buildView,
        );
}
