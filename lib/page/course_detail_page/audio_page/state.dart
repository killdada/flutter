import 'package:audioplayers/audioplayers.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/event/video_event.dart';
import 'package:myapp/common/model/course-detail/course_detail_model.dart';
import 'package:myapp/page/course_detail_page/state.dart';

class AudioState implements Cloneable<AudioState> {
  CourseDetailModel courseDetail;
  CatalogsModel currentCatalog;
  AudioPlayer audioPlayer = AudioPlayer();
  VideoEvent videoEventData;
  @override
  AudioState clone() {
    return AudioState()
      ..courseDetail = courseDetail
      ..videoEventData = videoEventData
      ..currentCatalog = currentCatalog
      ..audioPlayer = audioPlayer;
  }
}

AudioState initState(Map<String, dynamic> args) {
  CourseDetailState state = args['courseDetailState'];

  return AudioState()
    ..courseDetail = state.courseDetail
    ..currentCatalog = state.currentCatalog
    ..videoEventData = state.videoEventData;
}
