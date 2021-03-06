import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class VedioPage extends Page<VedioState, Map<String, dynamic>> {
  VedioPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<VedioState>(
              adapter: null, slots: <String, Dependent<VedioState>>{}),
          middleware: <Middleware<VedioState>>[],
        );
}
