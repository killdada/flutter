import 'package:fish_redux/fish_redux.dart';

class CourseCatalogState implements Cloneable<CourseCatalogState> {

  @override
  CourseCatalogState clone() {
    return CourseCatalogState();
  }
}

CourseCatalogState initState(Map<String, dynamic> args) {
  return CourseCatalogState();
}
