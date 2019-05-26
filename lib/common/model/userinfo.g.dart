// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userinfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo(
      exerciseCountTotal: json['exerciseCountTotal'] as int,
      userAvater: json['userAvater'] as String,
      rankStudyTimeInWeek: json['rankStudyTimeInWeek'] as int,
      userShowName: json['userShowName'] as String,
      exerciseCountWeek: json['exerciseCountWeek'] as int,
      studyTimeWeek: json['studyTimeWeek'] as int,
      rankStudyTimeInTotal: json['rankStudyTimeInTotal'] as int,
      rankExerciseInWeek: json['rankExerciseInWeek'] as int,
      username: json['username'] as String,
      studyTimeTotal: json['studyTimeTotal'] as int,
      studyTimeNum: json['studyTimeNum'] as int);
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'exerciseCountTotal': instance.exerciseCountTotal,
      'userAvater': instance.userAvater,
      'rankStudyTimeInWeek': instance.rankStudyTimeInWeek,
      'userShowName': instance.userShowName,
      'exerciseCountWeek': instance.exerciseCountWeek,
      'studyTimeWeek': instance.studyTimeWeek,
      'rankStudyTimeInTotal': instance.rankStudyTimeInTotal,
      'rankExerciseInWeek': instance.rankExerciseInWeek,
      'username': instance.username,
      'studyTimeTotal': instance.studyTimeTotal,
      'studyTimeNum': instance.studyTimeNum
    };
