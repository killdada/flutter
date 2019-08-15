import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:myapp/page/course_detail_page/course_tab_component/component.dart';
import 'package:myapp/page/course_detail_page/practice_tab_component/component.dart';
import 'package:myapp/page/course_detail_page/vedio_operation_component/component.dart';
import 'package:myapp/widget/keep_alive_wrapper.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class CourseDetailStateKeepAliveStf extends ComponentState<CourseDetailState>
    with SingleTickerProviderStateMixin {}

class CourseDetailPage extends Page<CourseDetailState, Map<String, dynamic>> {
  @override
  CourseDetailStateKeepAliveStf createState() =>
      CourseDetailStateKeepAliveStf();

  @override
  CourseDetailPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          wrapper: keepAliveWrapper,
          view: buildView,
          dependencies: Dependencies<CourseDetailState>(
              adapter: null,
              slots: <String, Dependent<CourseDetailState>>{
                'vedioOperation':
                    VedioOperationConnector() + VedioOperationComponent(),
                'courseTab': CourseTabConnector() + CourseTabComponent(),
                'practiceTab': PracticeTabConnector() + PracticeTabComponent(),
              }),
          middleware: <Middleware<CourseDetailState>>[],
        );
}
