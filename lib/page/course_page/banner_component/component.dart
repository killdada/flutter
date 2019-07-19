import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

class BannerComponent extends Component<BannerState> {
  BannerComponent()
      : super(
          view: buildView,
          dependencies: Dependencies<BannerState>(
              adapter: null, slots: <String, Dependent<BannerState>>{}),
        );
}
