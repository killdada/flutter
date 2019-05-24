// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userinfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo(
      id: json['id'] as num,
      account: json['account'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      avatar: json['avatar'] as String);
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'account': instance.account,
      'name': instance.name,
      'id': instance.id,
      'email': instance.email,
      'avatar': instance.avatar
    };
