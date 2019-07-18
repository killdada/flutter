import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TabbarComponent extends Component<TabbarState> {
  TabbarComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<TabbarState>(
              adapter: null, slots: <String, Dependent<TabbarState>>{}),
        );
}
