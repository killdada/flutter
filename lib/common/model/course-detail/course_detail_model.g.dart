// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseDetailModel _$CourseDetailModelFromJson(Map<String, dynamic> json) {
  return CourseDetailModel(
    courseId: json['courseId'] as int,
    courseName: json['courseName'] as String,
    imgUrl: json['imgUrl'] as String,
    categoryName: json['categoryName'] as String,
    catalogs: (json['catalogs'] as List)
        ?.map((e) => e == null
            ? null
            : CatalogsModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    topicId: json['topicId'] as int,
    collected: json['collected'] as int,
    author: json['author'] as String,
  );
}

Map<String, dynamic> _$CourseDetailModelToJson(CourseDetailModel instance) =>
    <String, dynamic>{
      'courseId': instance.courseId,
      'courseName': instance.courseName,
      'imgUrl': instance.imgUrl,
      'categoryName': instance.categoryName,
      'catalogs': instance.catalogs,
      'topicId': instance.topicId,
      'collected': instance.collected,
      'author': instance.author,
    };

CatalogsModel _$CatalogsModelFromJson(Map<String, dynamic> json) {
  return CatalogsModel(
    catalogId: json['catalogId'] as int,
    catalogName: json['catalogName'] as String,
    catalogAlias: json['catalogAlias'] as String,
    videoUrl: json['videoUrl'] as String,
    catalogDesc: json['catalogDesc'] as String,
    playTime: json['playTime'] as String,
    ppt: (json['ppt'] as List)
        ?.map((e) =>
            e == null ? null : PptModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    curPptIndex: json['curPptIndex'] as int,
    pptTitle: json['pptTitle'] as String,
    totalPptCount: json['totalPptCount'] as int,
  );
}

Map<String, dynamic> _$CatalogsModelToJson(CatalogsModel instance) =>
    <String, dynamic>{
      'catalogId': instance.catalogId,
      'catalogName': instance.catalogName,
      'catalogAlias': instance.catalogAlias,
      'videoUrl': instance.videoUrl,
      'catalogDesc': instance.catalogDesc,
      'playTime': instance.playTime,
      'ppt': instance.ppt,
      'curPptIndex': instance.curPptIndex,
      'totalPptCount': instance.totalPptCount,
      'pptTitle': instance.pptTitle,
    };

PptModel _$PptModelFromJson(Map<String, dynamic> json) {
  return PptModel(
    url: json['url'] as String,
    timeStart: json['start_time'] as int,
    timeEnd: json['end_time'] as int,
  );
}

Map<String, dynamic> _$PptModelToJson(PptModel instance) => <String, dynamic>{
      'url': instance.url,
      'start_time': instance.timeStart,
      'end_time': instance.timeEnd,
    };
