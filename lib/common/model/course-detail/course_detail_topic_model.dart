import 'package:json_annotation/json_annotation.dart';
part 'course_detail_topic_model.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class CourseDetailTopicModel {
  TopicModel topic;
  List<TopicPracticeModel> practice;

  CourseDetailTopicModel({
    this.topic,
    this.practice,
  });

  //不同的类使用不同的mixin即可
  factory CourseDetailTopicModel.fromJson(Map<String, dynamic> json) =>
      _$CourseDetailTopicModelFromJson(json);
  Map<String, dynamic> toJson() => _$CourseDetailTopicModelToJson(this);
}

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class TopicModel {
  int id;
  @JsonKey(name: 'course_id')
  int courseId;
  int fab;
  String topic;
  String publisher;
  @JsonKey(name: 'practice_num')
  int practiceNum;
  @JsonKey(name: 'lastest_practice_reply')
  String lastestPracticeReply;
  @JsonKey(name: 'lastest_practice_datetime')
  String lastestPracticeDatetime;
  @JsonKey(name: 'created_at')
  String createdAt;
  @JsonKey(name: 'modified_at')
  String modifiedAt;
  @JsonKey(name: 'deleted_at')
  dynamic deletedAt;

  TopicModel({
    this.id,
    this.courseId,
    this.fab,
    this.topic,
    this.publisher,
    this.practiceNum,
    this.lastestPracticeReply,
    this.lastestPracticeDatetime,
    this.createdAt,
    this.modifiedAt,
    this.deletedAt,
  });

  //不同的类使用不同的mixin即可
  factory TopicModel.fromJson(Map<String, dynamic> json) =>
      _$TopicModelFromJson(json);
  Map<String, dynamic> toJson() => _$TopicModelToJson(this);
}

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class TopicPracticeModel {
  int id;
  @JsonKey(name: 'course_id')
  int courseId;
  @JsonKey(name: 'practice_id')
  int practiceId;
  String username;
  int fab;
  @JsonKey(name: 'comment_num')
  int commentNum;
  dynamic title;
  String content;
  @JsonKey(name: 'created_at')
  String createdAt;
  @JsonKey(name: 'modified_at')
  String modifiedAt;
  @JsonKey(name: 'deleted_at')
  dynamic deletedAt;
  @JsonKey(name: 'user_show_name')
  String userShowName;

  TopicPracticeModel({
    this.id,
    this.courseId,
    this.practiceId,
    this.username,
    this.fab,
    this.commentNum,
    this.title,
    this.content,
    this.createdAt,
    this.modifiedAt,
    this.deletedAt,
    this.userShowName,
  });

  //不同的类使用不同的mixin即可
  factory TopicPracticeModel.fromJson(Map<String, dynamic> json) =>
      _$TopicPracticeModelFromJson(json);
  Map<String, dynamic> toJson() => _$TopicPracticeModelToJson(this);
}
