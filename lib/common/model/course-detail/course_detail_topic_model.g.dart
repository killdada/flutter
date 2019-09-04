// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_detail_topic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseDetailTopicModel _$CourseDetailTopicModelFromJson(
    Map<String, dynamic> json) {
  return CourseDetailTopicModel(
    topic: json['topic'] == null
        ? null
        : TopicModel.fromJson(json['topic'] as Map<String, dynamic>),
    practice: (json['practice'] as List)
        ?.map((e) => e == null
            ? null
            : TopicPracticeModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CourseDetailTopicModelToJson(
        CourseDetailTopicModel instance) =>
    <String, dynamic>{
      'topic': instance.topic,
      'practice': instance.practice,
    };

TopicModel _$TopicModelFromJson(Map<String, dynamic> json) {
  return TopicModel(
    id: json['id'] as int,
    courseId: json['course_id'] as int,
    fab: json['fab'] as int,
    topic: json['topic'] as String,
    publisher: json['publisher'] as String,
    practiceNum: json['practice_num'] as int,
    lastestPracticeReply: json['lastest_practice_reply'] as String,
    lastestPracticeDatetime: json['lastest_practice_datetime'] as String,
    createdAt: json['created_at'] as String,
    modifiedAt: json['modified_at'] as String,
    deletedAt: json['deleted_at'],
  );
}

Map<String, dynamic> _$TopicModelToJson(TopicModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'course_id': instance.courseId,
      'fab': instance.fab,
      'topic': instance.topic,
      'publisher': instance.publisher,
      'practice_num': instance.practiceNum,
      'lastest_practice_reply': instance.lastestPracticeReply,
      'lastest_practice_datetime': instance.lastestPracticeDatetime,
      'created_at': instance.createdAt,
      'modified_at': instance.modifiedAt,
      'deleted_at': instance.deletedAt,
    };

TopicPracticeModel _$TopicPracticeModelFromJson(Map<String, dynamic> json) {
  return TopicPracticeModel(
    id: json['id'] as int,
    courseId: json['course_id'] as int,
    practiceId: json['practice_id'] as int,
    username: json['username'] as String,
    fab: json['fab'] as int,
    commentNum: json['comment_num'] as int,
    title: json['title'],
    content: json['content'] as String,
    createdAt: json['created_at'] as String,
    modifiedAt: json['modified_at'] as String,
    deletedAt: json['deleted_at'],
    userShowName: json['user_show_name'] as String,
  );
}

Map<String, dynamic> _$TopicPracticeModelToJson(TopicPracticeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'course_id': instance.courseId,
      'practice_id': instance.practiceId,
      'username': instance.username,
      'fab': instance.fab,
      'comment_num': instance.commentNum,
      'title': instance.title,
      'content': instance.content,
      'created_at': instance.createdAt,
      'modified_at': instance.modifiedAt,
      'deleted_at': instance.deletedAt,
      'user_show_name': instance.userShowName,
    };
