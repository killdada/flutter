import 'package:fish_redux/fish_redux.dart';

class PptState implements Cloneable<PptState> {

  @override
  PptState clone() {
    return PptState();
  }
}

PptState initState(Map<String, dynamic> args) {
  return PptState();
}
