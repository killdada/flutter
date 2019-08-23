import 'package:flutter/material.dart';
// import 'package:flutter_video_player/flutter_video_player.dart';

class AudioPlayerSeekBar extends StatefulWidget {
  final dynamic controller;
  final Function() onDragStart;
  final Function() onDragEnd;
  final Function() onDragUpdate;

  AudioPlayerSeekBar({
    @required this.controller,
    this.onDragStart,
    this.onDragEnd,
    this.onDragUpdate,
  });

  @override
  _AudioPlayerSeekBarState createState() {
    return _AudioPlayerSeekBarState();
  }
}

class _AudioPlayerSeekBarState extends State<AudioPlayerSeekBar> {
  _AudioPlayerSeekBarState() {
    listener = () {
      setState(() {});
    };
  }

  VoidCallback listener;
  bool _controllerWasPlaying = false;

//   VideoPlayerController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    // controller.addListener(listener);
  }

  @override
  void deactivate() {
    // controller.removeListener(listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
    // void seekToRelativePosition(Offset globalPosition) {
    //   final box = context.findRenderObject() as RenderBox;
    //   final Offset tapPos = box.globalToLocal(globalPosition);
    //   final double relative = tapPos.dx / box.size.width;
    //   final Duration position = controller.value.duration * relative;
    //   controller.seekTo(position);
    // }

    // return GestureDetector(
    //   child: CustomPaint(
    //     painter: _SeekBarPainter(controller.value),
    //   ),
    //   onHorizontalDragStart: (DragStartDetails details) {
    //     if (!controller.value.initialized) {
    //       return;
    //     }
    //     _controllerWasPlaying = controller.value.isPlaying;
    //     if (_controllerWasPlaying) {
    //       controller.pause();
    //     }

    //     if (widget.onDragStart != null) {
    //       widget.onDragStart();
    //     }
    //   },
    //   onHorizontalDragUpdate: (DragUpdateDetails details) {
    //     if (!controller.value.initialized) {
    //       return;
    //     }
    //     seekToRelativePosition(details.globalPosition);

    //     if (widget.onDragUpdate != null) {
    //       widget.onDragUpdate();
    //     }
    //   },
    //   onHorizontalDragEnd: (DragEndDetails details) {
    //     if (_controllerWasPlaying) {
    //       controller.play();
    //     }

    //     if (widget.onDragEnd != null) {
    //       widget.onDragEnd();
    //     }

    //     controller.onSeekFinish();
    //   },
    //   onTapDown: (TapDownDetails details) {
    //     if (!controller.value.initialized) {
    //       return;
    //     }
    //     seekToRelativePosition(details.globalPosition);

    //     controller.onSeekFinish();
    //   },
    // );
  }
}

class _SeekBarPainter extends CustomPainter {
  _SeekBarPainter(this.value);

  final String value;

//   final VideoPlayerValue value;

  final Paint _paint = new Paint()
    ..isAntiAlias = true
    ..strokeWidth = 2
    ..style = PaintingStyle.fill;

  final TextPainter _textPainter = TextPainter()
    ..textDirection = TextDirection.ltr;

  final double thumbHorizontalPadding = 6;
  final double thumbVerticalPadding = 2;

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // return Container();
    // if (!value.initialized) {
    //   return;
    // }

    // final double playedValuePercent =
    //     value.position.inMilliseconds / value.duration.inMilliseconds;
    // final String playerTextPercent =
    //     '${formatDuration(value.position)}/${formatDuration(value.duration)}';

    // _textPainter
    //   ..text = TextSpan(
    //     text: playerTextPercent,
    //     style: TextStyle(
    //       color: Colors.white,
    //       fontSize: 12,
    //     ),
    //   )
    //   ..layout();

    // var textWidth = _textPainter.width;
    // var textHeight = _textPainter.height;

    // double offsetX = playedValuePercent *
    //     (size.width - textWidth - thumbHorizontalPadding * 2);

    // canvas.drawLine(
    //   Offset(0, size.height / 2),
    //   Offset(offsetX + textWidth / 2 + thumbHorizontalPadding, size.height / 2),
    //   _paint..color = Colors.blue,
    // );

    // canvas.drawRRect(
    //   RRect.fromRectAndRadius(
    //     Rect.fromLTWH(
    //       offsetX,
    //       size.height / 2 - textHeight / 2 - thumbVerticalPadding,
    //       textWidth + thumbHorizontalPadding * 2,
    //       textHeight + thumbVerticalPadding * 2,
    //     ),
    //     Radius.circular(size.height),
    //   ),
    //   _paint..color = const Color(0xFF4A4A4A),
    // );

    // _textPainter.paint(
    //   canvas,
    //   Offset(
    //     offsetX + thumbHorizontalPadding,
    //     size.height / 2 - textHeight / 2,
    //   ),
    // );
  }
}
