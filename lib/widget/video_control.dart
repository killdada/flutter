import 'dart:async';
import 'dart:ui' as ui;

import 'package:chewie/chewie.dart' hide ChewieProgressColors;
import 'chewie_progress_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/constant/constant.dart';
import 'package:myapp/common/event/event_bus.dart';
import 'package:myapp/common/event/video_event.dart';
import 'package:myapp/common/model/course-detail/index.dart';
import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/common/utils/date_utils.dart';
import 'package:myapp/widget/cupertino_progress_bar.dart';
import 'package:open_iconic_flutter/open_iconic_flutter.dart';
import 'package:video_player/video_player.dart';

class CupertinoControls extends StatefulWidget {
  const CupertinoControls({
    @required this.backgroundColor,
    @required this.iconColor,
  });

  final Color backgroundColor;
  final Color iconColor;

  @override
  State<StatefulWidget> createState() {
    return _CupertinoControlsState();
  }
}

class _CupertinoControlsState extends State<CupertinoControls> {
  VideoPlayerValue _latestValue;
  double _latestVolume;
  bool _hideStuff = true;
  Timer _hideTimer;
  final marginSize = 5.0;
  Timer _expandCollapseTimer;
  Timer _initTimer;

  PlayType playType = PlayType.video;
  VideoModel videoModel = VideoModel.complex;

  @override
  void initState() {
    super.initState();

    // 精简模式下，ppt切视频
    MyEventBus.event.on<ChangePptIndex>().listen((event) {
       if (videoModel == VideoModel.simple && event.neewSeekTo) {
          PptModel ppt = event.ppt;
           print('简洁模式下ppk开始时间 :${ppt.timeStart}');
        if ( ppt.timeStart != null) {
          int start = ppt.timeStart==0?1:ppt.timeStart;
          print('简洁模式下pp,seek video time to :$start');
          controller.seekTo(Duration(seconds:start ));
        } else {
          print('ppt时间不合法,请检查接口和对应后台');
        }
      
       }
    });
  }

  void changeModel() {
  if (mounted) {
     setState(() {
      VideoModel model = videoModel == VideoModel.complex
          ? VideoModel.simple
          : VideoModel.complex;
      videoModel = model;
      MyEventBus.event.fire(VideoEvent(
        videoModel: model,
        playType: playType,
      ));
    });
  }
  }

  void changePlayType() {
  if (mounted) {

    setState(() {
      PlayType type =
          playType == PlayType.video ? PlayType.audio : PlayType.video;
      playType = type;
      MyEventBus.event.fire(VideoEvent(playType: type, videoModel: videoModel));
    });
  }
  }

  VideoPlayerController controller;
  ChewieController chewieController;

  @override
  Widget build(BuildContext context) {
    chewieController = ChewieController.of(context);

    if (_latestValue.hasError) {
      return chewieController.errorBuilder != null
          ? chewieController.errorBuilder(
              context,
              chewieController.videoPlayerController.value.errorDescription,
            )
          : Center(
              child: Icon(
                OpenIconicIcons.ban,
                color: Colors.white,
                size: 42,
              ),
            );
    }

    final backgroundColor = widget.backgroundColor;
    final iconColor = widget.iconColor;
    chewieController = ChewieController.of(context);
    controller = chewieController.videoPlayerController;
    final orientation = MediaQuery.of(context).orientation;
    final barHeight = orientation == Orientation.portrait ? 30.0 : 47.0;
    final buttonPadding = orientation == Orientation.portrait ? 16.0 : 24.0;

    return GestureDetector(
      onTap: () {
        _cancelAndRestartTimer();
      },
      child: AbsorbPointer(
        absorbing: _hideStuff,
        child: Column(
          children: <Widget>[
            _buildTopBar(backgroundColor, iconColor, barHeight, buttonPadding),
            _buildHitArea(),
            _buildBottomBar(backgroundColor, iconColor, barHeight),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  void _dispose() {
    controller.removeListener(_updateState);
    _hideTimer?.cancel();
    _expandCollapseTimer?.cancel();
    _initTimer?.cancel();
  }

  @override
  void didChangeDependencies() {
    final _oldController = chewieController;
    chewieController = ChewieController.of(context);
    controller = chewieController.videoPlayerController;

    if (_oldController != chewieController) {
      _dispose();
      _initialize();
    }
    super.didChangeDependencies();
  }

  AnimatedOpacity _buildBottomBar(
    Color backgroundColor,
    Color iconColor,
    double barHeight,
  ) {
    return AnimatedOpacity(
      opacity: _hideStuff ? 0.0 : 1.0,
      duration: Duration(milliseconds: 300),
      child: Container(
        color: Colors.transparent,
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.all(marginSize),
        child: ClipRect(
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(
              sigmaX: 10.0,
              sigmaY: 10.0,
            ),
            child: Container(
              height: barHeight,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: chewieController.isLive
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _buildPlayPause(controller, iconColor, barHeight),
                        _buildLive(iconColor),
                      ],
                    )
                  : Row(
                      children: <Widget>[
                        // _buildSkipBack(iconColor, barHeight),
                        _buildPlayPause(controller, iconColor, barHeight),
                        // _buildSkipForward(iconColor, barHeight),
                        _buildPosition(iconColor),
                        _buildProgressBar(),
                        _buildRemaining(iconColor),
                        _buildFullScreenBtn(controller, iconColor, barHeight),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFullScreenBtn(
    VideoPlayerController controller,
    Color iconColor,
    double barHeight,
  ) {
    return GestureDetector(
      onTap: _onExpandCollapse,
      child: Container(
        height: barHeight,
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Center(
          child: Icon(
            chewieController.isFullScreen
                ? Icons.fullscreen_exit
                : Icons.fullscreen,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildLive(Color iconColor) {
    return Padding(
      padding: EdgeInsets.only(right: 12.0),
      child: Text(
        'LIVE',
        style: TextStyle(color: iconColor, fontSize: 12.0),
      ),
    );
  }

  Expanded _buildHitArea() {
    return Expanded(
      child: GestureDetector(
        onTap: _latestValue != null && _latestValue.isPlaying
            ? _cancelAndRestartTimer
            : () {
                _hideTimer?.cancel();

                setState(() {
                  _hideStuff = false;
                });
              },
        child: Container(
          color: Colors.transparent,
        ),
      ),
    );
  }

  GestureDetector _buildMuteButton(
    VideoPlayerController controller,
    Color backgroundColor,
    Color iconColor,
    double barHeight,
    double buttonPadding,
  ) {
    return GestureDetector(
      onTap: () {
        _cancelAndRestartTimer();

        if (_latestValue.volume == 0) {
          controller.setVolume(_latestVolume ?? 0.5);
        } else {
          _latestVolume = controller.value.volume;
          controller.setVolume(0.0);
        }
      },
      child: AnimatedOpacity(
        opacity: _hideStuff ? 0.0 : 1.0,
        duration: Duration(milliseconds: 300),
        child: ClipRect(
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 10.0),
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: Container(
                height: barHeight,
                padding: EdgeInsets.only(
                  left: buttonPadding,
                  right: buttonPadding,
                ),
                child: Icon(
                  (_latestValue != null && _latestValue.volume > 0)
                      ? Icons.volume_up
                      : Icons.volume_off,
                  color: iconColor,
                  size: 16.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector _buildPlayPause(
    VideoPlayerController controller,
    Color iconColor,
    double barHeight,
  ) {
    return GestureDetector(
      onTap: _playPause,
      child: Container(
        height: barHeight,
        color: Colors.transparent,
        padding: EdgeInsets.only(
          left: 6.0,
          right: 6.0,
        ),
        child: Icon(
          controller.value.isPlaying
              ? OpenIconicIcons.mediaPause
              : OpenIconicIcons.mediaPlay,
          color: iconColor,
          size: 16.0,
        ),
      ),
    );
  }

  Widget _buildPosition(Color iconColor) {
    final position =
        _latestValue != null ? _latestValue.position : Duration(seconds: 0);

    return Padding(
      padding: EdgeInsets.only(right: 12.0),
      child: Text(
        DateUtil.formatDuration(position),
        style: TextStyle(
          color: iconColor,
          fontSize: 12.0,
        ),
      ),
    );
  }

  Widget _buildRemaining(Color iconColor) {
    final position = _latestValue != null && _latestValue.duration != null
        ? _latestValue.duration
        : Duration(seconds: 0);

    return Padding(
      padding: EdgeInsets.only(right: 12.0),
      child: Text(
        '${DateUtil.formatDuration(position)}',
        style: TextStyle(color: iconColor, fontSize: 12.0),
      ),
    );
  }


  GestureDetector _topBtnWrapper(Function onTap, String img,
      {double width, Color color, Color bgColor}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        opacity: _hideStuff ? 0.0 : 1.0,
        duration: Duration(milliseconds: 300),
        child: Container(
          color: bgColor ?? Colors.transparent,
          child: Image.asset(
            img,
            width: AppSize.width(40.0),
            color: color ?? Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildBackBtnChild() {
    return Container(
      color: Colors.transparent,
      child: Image.asset(
        'assets/images/icn_nav_back.png',
        width: AppSize.width(50.0),
        color: Colors.white,
      ),
    );
  }

  Widget _buildBackBtn(double barHeight) {
    return GestureDetector(
      onTap: () {
        if (chewieController.isFullScreen) {
          chewieController.exitFullScreen();
        } else {
          Navigator.pop(context);
        }
      },
      child: chewieController.isFullScreen
          ? AnimatedOpacity(
              opacity: _hideStuff ? 0.0 : 1.0,
              duration: Duration(milliseconds: 300),
              child: _buildBackBtnChild())
          : _buildBackBtnChild(),
    );
  }

  GestureDetector _frequencyBtn(
    Color backgroundColor,
    Color iconColor,
    double barHeight,
    double buttonPadding,
  ) {
    return _topBtnWrapper(
      changePlayType,
      'assets/images/icn_frequency.png',
      color: playType == PlayType.audio ? Colors.pinkAccent : Colors.white,
    );
  }

  GestureDetector _transformBtn(
    Color backgroundColor,
    Color iconColor,
    double barHeight,
    double buttonPadding,
  ) {
    return _topBtnWrapper(
      changeModel,
      'assets/images/icn_transform.png',
      color: videoModel == VideoModel.simple ? Colors.pinkAccent : Colors.white,
    );
  }

  Widget _buildTopBar(
    Color backgroundColor,
    Color iconColor,
    double barHeight,
    double buttonPadding,
  ) {
    return Container(
      height: barHeight,
      margin: EdgeInsets.only(
        top: marginSize,
        right: marginSize,
        left: marginSize,
      ),
      child: Row(
        children: <Widget>[
          _buildBackBtn(barHeight),
          // chewieController.allowFullScreen
          //     ? _buildExpandButton(
          //         backgroundColor, iconColor, barHeight, buttonPadding)
          //     : Container(),
          Expanded(child: Container()),
          Offstage(
            offstage: chewieController.isFullScreen,
            child: _frequencyBtn(
                backgroundColor, iconColor, barHeight, buttonPadding),
          ),
          Offstage(
            offstage: chewieController.isFullScreen,
            child: _transformBtn(
                backgroundColor, iconColor, barHeight, buttonPadding),
          ),
          // _buildTitleWidget(),
          chewieController.allowMuting
              ? _buildMuteButton(controller, backgroundColor, iconColor,
                  barHeight, buttonPadding)
              : Container(),
        ],
      ),
    );
  }

  void _cancelAndRestartTimer() {
    _hideTimer?.cancel();

    setState(() {
      _hideStuff = false;
      _startHideTimer();
    });
  }

  Future<Null> _initialize() async {
    controller.addListener(_updateState);

    _updateState();

    if ((controller.value != null && controller.value.isPlaying) ||
        chewieController.autoPlay) {
      _startHideTimer();
    }

    _initTimer = Timer(Duration(milliseconds: 200), () {
      setState(() {
        _hideStuff = false;
      });
    });
  }

  void _onExpandCollapse() {
    setState(() {
      _hideStuff = true;

      chewieController.toggleFullScreen();
      _expandCollapseTimer = Timer(Duration(milliseconds: 300), () {
        setState(() {
          _cancelAndRestartTimer();
        });
      });
    });
  }

  Widget _buildProgressBar() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: 12.0),
        child: CupertinoVideoProgressBar(
          controller,
          onDragStart: () {
            _hideTimer?.cancel();
          },
          onDragEnd: () {
            _startHideTimer();
          },
          colors: chewieController.cupertinoProgressColors ??
              ChewieProgressColors(
                playedColor: Color.fromARGB(
                  120,
                  255,
                  255,
                  255,
                ),
                handleColor: Color.fromARGB(
                  255,
                  255,
                  255,
                  255,
                ),
                bufferedColor: Color.fromARGB(
                  60,
                  255,
                  255,
                  255,
                ),
                backgroundColor: Color.fromARGB(
                  20,
                  255,
                  255,
                  255,
                ),
              ),
        ),
      ),
    );
  }

  bool isFished() {
    return controller.value.position == controller.value.duration;
  }


  void _playPause() {
    setState(() {
      if (controller.value.isPlaying) {
        _hideStuff = false;
        _hideTimer?.cancel();
        controller.pause();
      } else {
        _cancelAndRestartTimer();

        if (!controller.value.initialized) {
          controller.initialize().then((_) {
            if (isFished()) {
              controller.seekTo(Duration(seconds:0 ));
            }
           controller.play();
          });
        } else {
          if (isFished()) {
              controller.seekTo(Duration(seconds:0 ));
            }
           controller.play();
        }
      }
    });
  }


  void _startHideTimer() {
    _hideTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _hideStuff = true;
      });
    });
  }

  void _updateState() {
    // 精简模式下，随着视频播放，PPT自动翻页
    if (videoModel == VideoModel.simple) {
       var time =  controller.value.position.inSeconds;
     print('当前播放时间:$time');
      MyEventBus.event.fire(JumpPPtWithTime(time));
    }
    setState(() {
      _latestValue = controller.value;
    });
  }
}