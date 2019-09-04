import 'package:audioplayers/audioplayers.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/constant/constant.dart';
import 'package:myapp/common/event/video_event.dart';
import 'package:myapp/common/model/course-detail/course_detail_model.dart';
import 'package:myapp/page/course_detail_page/state.dart';
import 'package:myapp/page/course_detail_page/vedio_operation_component/state.dart';

class AudioState implements Cloneable<AudioState> {
  CourseDetailModel courseDetail;
  CatalogsModel currentCatalog;
  AudioPlayer audioPlayer = AudioPlayer();
  AudioPlayerState audioPlayerState = AudioPlayerState.PLAYING;
  VideoEvent videoEventData;
  Duration duration;
  bool collected = false;
  PlayType pageType = PlayType.audio; // 传递给操作组件使用

  @override
  AudioState clone() {
    return AudioState()
      ..courseDetail = courseDetail
      ..videoEventData = videoEventData
      ..currentCatalog = currentCatalog
      ..audioPlayer = audioPlayer
      ..pageType = pageType
      ..duration = duration
      ..audioPlayerState = audioPlayerState
      ..collected = collected;
  }
}

AudioState initState(Map<String, dynamic> args) {
  CourseDetailState state = args['courseDetailState'];
  return AudioState()
    ..collected = state.collected
    ..courseDetail = state.courseDetail
    ..currentCatalog = state.currentCatalog
    ..videoEventData = state.videoEventData;
}

class VedioOperationConnector extends Reselect3<AudioState, VedioOperationState,
    CourseDetailModel, bool, PlayType> {
  @override
  VedioOperationState computed(
      CourseDetailModel sub0, bool sub1, PlayType sub2) {
    return VedioOperationState()
      ..vedioOperationData = sub0
      ..collected = sub1
      ..pageType = sub2;
  }

  @override
  CourseDetailModel getSub0(AudioState state) {
    return state.courseDetail;
  }

  @override
  bool getSub1(AudioState state) {
    return state.collected;
  }

  @override
  PlayType getSub2(AudioState state) {
    return state.pageType;
  }

  @override
  void set(AudioState state, VedioOperationState subState) {
    // throw Exception(
    //     'Unexcepted to set AudioState from VedioOperationState');
  }
}
