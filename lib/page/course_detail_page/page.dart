import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/page/course_detail_page/course_tab_component/component.dart';
import 'package:myapp/page/course_detail_page/practice_tab_component/component.dart';
import 'package:myapp/page/course_detail_page/vedio_component/component.dart';
import 'package:myapp/page/course_detail_page/vedio_operation_component/component.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class CourseDetailPage extends Page<CourseDetailState, Map<String, dynamic>> {
  CourseDetailPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<CourseDetailState>(
              adapter: null,
              slots: <String, Dependent<CourseDetailState>>{
                'vedio': VedioConnector() + VedioComponent(),
                'vedioOperation':
                    VedioOperationConnector() + VedioOperationComponent(),
                'courseTab': CourseTabConnector() + CourseTabComponent(),
                'practiceTab': PracticeTabConnector() + PracticeTabComponent(),
              }),
          middleware: <Middleware<CourseDetailState>>[],
        );
}
