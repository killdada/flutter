import 'package:fish_redux/fish_redux.dart';
import 'view.dart';

class CourseCatalogComponent extends Component<Map<String, dynamic>> {
  CourseCatalogComponent()
      : super(
          view: buildView,
        );
}
