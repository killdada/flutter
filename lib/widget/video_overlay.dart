import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoOverlay extends StatefulWidget {
  VideoOverlay({Key key}) : super(key: key);

  _VideoOverlayState createState() => _VideoOverlayState();
}

class _VideoOverlayState extends State<VideoOverlay> {

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  void _dispose() {}

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
