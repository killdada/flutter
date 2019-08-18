import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class AudioPage extends Page<AudioState, Map<String, dynamic>> {
  AudioPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<AudioState>(
                adapter: null,
                slots: <String, Dependent<AudioState>>{
                }),
            middleware: <Middleware<AudioState>>[
            ],);

}
