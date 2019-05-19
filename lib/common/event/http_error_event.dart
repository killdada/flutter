class HttpErrorEvent {
  final int code; // http错误码

  final String message; // http错误信息

  HttpErrorEvent(this.code, this.message);
}
