import 'package:json_annotation/json_annotation.dart';

//  将在我们运行生成命令后自动生成
part 'practice_detail_model.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class PractiveDetailModel {
  Practice practice;
  List<Reply> replies;

  PractiveDetailModel({
    this.practice,
    this.replies,
  });

  //不同的类使用不同的mixin即可
  factory PractiveDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PractiveDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$PractiveDetailModelToJson(this);
}

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class Practice {
  @JsonKey(name: 'course_id')
  int courseId;
  int fab;
  @JsonKey(name: 'practice_id')
  int practiceId;
  @JsonKey(name: 'created_at')
  String createdAt;
  int id;
  dynamic title;
  @JsonKey(name: 'modified_at')
  String modifiedAt;
  @JsonKey(name: 'deleted_at')
  dynamic deletedAt;
  String content;
  String username;
  String nickname;
  int fabed;

  Practice(
      {this.courseId,
      this.fab,
      this.practiceId,
      this.createdAt,
      this.id,
      this.title,
      this.modifiedAt,
      this.deletedAt,
      this.content,
      this.username,
      this.nickname,
      this.fabed});

  //不同的类使用不同的mixin即可
  factory Practice.fromJson(Map<String, dynamic> json) =>
      _$PracticeFromJson(json);
  Map<String, dynamic> toJson() => _$PracticeToJson(this);
}

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class Reply {
  @JsonKey(name: 'reply_id')
  int replyId;
  int fab;
  @JsonKey(name: 'created_at')
  String createdAt;
  int id;
  @JsonKey(name: 'modified_at')
  String modifiedAt;
  @JsonKey(name: 'deleted_at')
  dynamic deletedAt;
  String content;
  String username;
  String nickname;
  int fabed;

  Reply(
      {this.replyId,
      this.fab,
      this.createdAt,
      this.id,
      this.modifiedAt,
      this.deletedAt,
      this.content,
      this.username,
      this.nickname,
      this.fabed});

  //不同的类使用不同的mixin即可
  factory Reply.fromJson(Map<String, dynamic> json) => _$ReplyFromJson(json);
  Map<String, dynamic> toJson() => _$ReplyToJson(this);
}
