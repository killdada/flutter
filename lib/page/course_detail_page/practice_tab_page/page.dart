import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PracticeTabPage extends Page<PracticeTabState, Map<String, dynamic>> {
  PracticeTabPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<PracticeTabState>(
                adapter: null,
                slots: <String, Dependent<PracticeTabState>>{
                }),
            middleware: <Middleware<PracticeTabState>>[
            ],);

}
