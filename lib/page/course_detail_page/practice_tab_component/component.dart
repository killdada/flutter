import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PracticeTabComponent extends Component<PracticeTabState> {
  PracticeTabComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<PracticeTabState>(
                adapter: null,
                slots: <String, Dependent<PracticeTabState>>{
                }),);

}
