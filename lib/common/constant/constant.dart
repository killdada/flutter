class Constants {}

enum ActionType {
  share,
  download,
  collection,
  feedback,
}


enum PlayType {
  video,
  audio,
}

enum VideoModel {
  simple,
  complex,
}


class Operations {
  String name;
  String img;
  ActionType type;
  Operations(this.name, this.img, this.type);
}
