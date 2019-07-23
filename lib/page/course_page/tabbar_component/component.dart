import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

class TabbarComponent extends Component<TabbarState> {
  TabbarComponent()
      : super(
          view: buildView,
          dependencies: Dependencies<TabbarState>(
              adapter: null, slots: <String, Dependent<TabbarState>>{}),
        );
}
