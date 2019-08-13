import 'package:fish_redux/fish_redux.dart';

import 'view.dart';

class PptComponent extends Component<Map<String, dynamic>> {
  PptComponent()
      : super(
          view: buildView,
        );
}
