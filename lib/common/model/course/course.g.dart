// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseModel _$CourseModelFromJson(Map<String, dynamic> json) {
  return CourseModel(
    imgUrl: json['imgUrl'] as String,
    totalVedioTime: json['totalVedioTime'] as int,
    courseName: json['courseName'] as String,
    author: json['author'] as String,
    cateoryName: json['cateoryName'] as String,
    courseId: json['courseId'] as int,
    desc: json['desc'] as String,
  );
}

Map<String, dynamic> _$CourseModelToJson(CourseModel instance) =>
    <String, dynamic>{
      'imgUrl': instance.imgUrl,
      'totalVedioTime': instance.totalVedioTime,
      'courseName': instance.courseName,
      'author': instance.author,
      'cateoryName': instance.cateoryName,
      'courseId': instance.courseId,
      'desc': instance.desc,
    };

CourseRecordEntity _$CourseRecordEntityFromJson(Map<String, dynamic> json) {
  return CourseRecordEntity(
    imgUrl: json['imgUrl'] as String,
    totalVedioTime: json['totalVedioTime'] as String,
    courseName: json['courseName'] as String,
    author: json['author'] as String,
    cateoryName: json['cateoryName'] as String,
    courseId: json['courseId'] as String,
    desc: json['desc'] as String,
    id: json['id'] as String,
    fileSize: json['fileSize'] as String,
  );
}

Map<String, dynamic> _$CourseRecordEntityToJson(CourseRecordEntity instance) =>
    <String, dynamic>{
      'imgUrl': instance.imgUrl,
      'totalVedioTime': instance.totalVedioTime,
      'courseName': instance.courseName,
      'author': instance.author,
      'cateoryName': instance.cateoryName,
      'courseId': instance.courseId,
      'desc': instance.desc,
      'id': instance.id,
      'fileSize': instance.fileSize,
    };
