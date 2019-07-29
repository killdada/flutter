import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/model/course/course.dart';

import 'view.dart';

class SearchCourseListComponent extends Component<CourseModel> {
  SearchCourseListComponent()
      : super(
          view: buildView,
        );
}
