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
}
