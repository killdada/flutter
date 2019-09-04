import 'package:rxdart/rxdart.dart';
import 'bloc_provider.dart';

class ApplicationBloc extends BlocBase {
  BehaviorSubject<int> _appEvent = BehaviorSubject<int>();

  Sink<int> get _appEventSink => _appEvent.sink;

  Stream<int> get appEventStream => _appEvent.stream;

  @override
  void dispose() {
    super.dispose();
    _appEvent.close();
  }

  void sendAppEvent(int type) {
    _appEventSink.add(type);
  }
}
