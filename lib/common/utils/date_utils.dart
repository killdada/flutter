class DateUtil {
  DateUtil._();

  static String formatTime(int time) {
    time ??= 0;
    int hour = time ~/ 3600;
    int minute = time ~/ 60 % 60;
    int second = time % 60;
    StringBuffer date = new StringBuffer();
    if (hour > 0) {
      date.write('$hour小时');
    }
    if (minute > 0) {
      date.write('$minute分');
    }
    if (second > 0) {
      date.write('$second秒');
    }
    return date.toString();
  }
  static String formatDuration(Duration position) {
    final ms = position.inMilliseconds;

    int seconds = ms ~/ 1000;
    final int hours = seconds ~/ 3600;
    seconds = seconds % 3600;
    var minutes = seconds ~/ 60;
    seconds = seconds % 60;

    final hoursString = hours >= 10 ? '$hours' : hours == 0 ? '00' : '0$hours';

    final minutesString =
        minutes >= 10 ? '$minutes' : minutes == 0 ? '00' : '0$minutes';

    final secondsString =
        seconds >= 10 ? '$seconds' : seconds == 0 ? '00' : '0$seconds';

    final formattedTime =
        '${hoursString == '00' ? '' : hoursString + ':'}$minutesString:$secondsString';

    return formattedTime;
  }

}
