// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'practice_overview_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PracticeOverviewModel _$PracticeOverviewModelFromJson(
    Map<String, dynamic> json) {
  return PracticeOverviewModel(
    topicId: json['topicId'] as int,
    relatedCategory: json['relatedCategory'] as String,
    relatedCourse: json['relatedCourse'] as String,
    publishDate: json['publishDate'] as String,
    topic: json['topic'] as String,
    publisher: json['publisher'] as String,
    replylist: json['replylist'] as List,
  );
}

Map<String, dynamic> _$PracticeOverviewModelToJson(
        PracticeOverviewModel instance) =>
    <String, dynamic>{
      'topicId': instance.topicId,
      'relatedCategory': instance.relatedCategory,
      'relatedCourse': instance.relatedCourse,
      'publishDate': instance.publishDate,
      'topic': instance.topic,
      'publisher': instance.publisher,
      'replylist': instance.replylist,
    };
