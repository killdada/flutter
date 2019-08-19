import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/widget/video_control.dart';
import 'package:myapp/widget/video_overlay.dart';
import 'package:myapp/widget/video_scaffold.dart';
import 'package:video_player/video_player.dart';

class ChewiePlay {
  static Map<String, dynamic> init(String url, {Duration position}) {
    VideoPlayerController videoController = VideoPlayerController.network(url);
    CupertinoControls myController = CupertinoControls(
      backgroundColor: Color.fromRGBO(41, 41, 41, 0.7),
      iconColor: Color.fromARGB(255, 200, 200, 200),
      position: position,
    );
    ChewieController chewieController = ChewieController(
        videoPlayerController: videoController,
        aspectRatio: 16 / 9,
        autoPlay: true,
        fullScreenByDefault: false,
        looping: false,
        allowMuting: false,
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight
        ],
        overlay: VideoOverlay(),
        customControls: myController,
        placeholder: new Center(
          child: CupertinoActivityIndicator(),
        ),
        routePageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondAnimation, provider) {
          return AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget child) {
              return VideoScaffold(
                child: Scaffold(
                  resizeToAvoidBottomPadding: false,
                  body: Container(
                    alignment: Alignment.center,
                    color: Colors.black,
                    child: provider,
                  ),
                ),
              );
            },
          );
        });
    return {
      'videoController': videoController,
      'chewieController': chewieController,
    };
  }
}
