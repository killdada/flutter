class Constants {}

enum ActionType {
  share,
  download,
  collection,
  feedback,
}

class Operations {
  String name;
  String img;
  ActionType type;
  Operations(this.name, this.img, this.type);
}
