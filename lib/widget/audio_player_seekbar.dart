import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/utils/date_utils.dart';
import 'package:myapp/page/course_detail_page/audio_page/state.dart';

class SeekBarPainter extends CustomPainter {
  SeekBarPainter(this.state);

  final AudioState state;

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
  void paint(Canvas canvas, Size size) async {
    if (state.videoEventData == null || state.duration == null) {
      return;
    }

    Duration position = state.videoEventData.position;
    Duration duration = state.duration;

    final double playedValuePercent =
        position.inMilliseconds / duration.inMilliseconds;
    final String playerTextPercent =
        '${DateUtil.formatDuration(position)}/${DateUtil.formatDuration(duration)}';

    _textPainter
      ..text = TextSpan(
        text: playerTextPercent,
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      )
      ..layout();

    var textWidth = _textPainter.width;
    var textHeight = _textPainter.height;

    double offsetX = playedValuePercent *
        (size.width - textWidth - thumbHorizontalPadding * 2);

    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(offsetX + textWidth / 2 + thumbHorizontalPadding, size.height / 2),
      _paint..color = Colors.blue,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          offsetX,
          size.height / 2 - textHeight / 2 - thumbVerticalPadding,
          textWidth + thumbHorizontalPadding * 2,
          textHeight + thumbVerticalPadding * 2,
        ),
        Radius.circular(size.height),
      ),
      _paint..color = const Color(0xFF4A4A4A),
    );

    _textPainter.paint(
      canvas,
      Offset(
        offsetX + thumbHorizontalPadding,
        size.height / 2 - textHeight / 2,
      ),
    );
  }
}
