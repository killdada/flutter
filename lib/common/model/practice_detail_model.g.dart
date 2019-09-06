// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'practice_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PracticeDetailModel _$PracticeDetailModelFromJson(Map<String, dynamic> json) {
  return PracticeDetailModel(
    practice: json['pratice'] == null
        ? null
        : Practice.fromJson(json['pratice'] as Map<String, dynamic>),
    replies: (json['pratice_reply'] as List)
        ?.map(
            (e) => e == null ? null : Reply.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PracticeDetailModelToJson(
        PracticeDetailModel instance) =>
    <String, dynamic>{
      'pratice': instance.practice,
      'pratice_reply': instance.replies,
    };

Practice _$PracticeFromJson(Map<String, dynamic> json) {
  return Practice(
    courseId: json['course_id'] as int,
    fab: json['fab'] as int,
    practiceId: json['practice_id'] as int,
    createdAt: json['created_at'] as String,
    id: json['id'] as int,
    title: json['title'],
    modifiedAt: json['modified_at'] as String,
    deletedAt: json['deleted_at'],
    content: json['content'] as String,
    username: json['username'] as String,
    nickname: json['nickname'] as String,
    fabed: json['fabed'] as int,
  );
}

Map<String, dynamic> _$PracticeToJson(Practice instance) => <String, dynamic>{
      'course_id': instance.courseId,
      'fab': instance.fab,
      'practice_id': instance.practiceId,
      'created_at': instance.createdAt,
      'id': instance.id,
      'title': instance.title,
      'modified_at': instance.modifiedAt,
      'deleted_at': instance.deletedAt,
      'content': instance.content,
      'username': instance.username,
      'nickname': instance.nickname,
      'fabed': instance.fabed,
    };

Reply _$ReplyFromJson(Map<String, dynamic> json) {
  return Reply(
    replyId: json['reply_id'] as int,
    fab: json['fab'] as int,
    createdAt: json['created_at'] as String,
    id: json['id'] as int,
    modifiedAt: json['modified_at'] as String,
    deletedAt: json['deleted_at'],
    content: json['content'] as String,
    username: json['username'] as String,
    nickname: json['nickname'] as String,
    fabed: json['fabed'] as int,
  );
}

Map<String, dynamic> _$ReplyToJson(Reply instance) => <String, dynamic>{
      'reply_id': instance.replyId,
      'fab': instance.fab,
      'created_at': instance.createdAt,
      'id': instance.id,
      'modified_at': instance.modifiedAt,
      'deleted_at': instance.deletedAt,
      'content': instance.content,
      'username': instance.username,
      'nickname': instance.nickname,
      'fabed': instance.fabed,
    };
