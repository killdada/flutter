import 'package:json_annotation/json_annotation.dart';

//  将在我们运行生成命令后自动生成
part 'userinfo.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class UserInfo {
  String account;
  String name;
  num id;
  String email;
  String avatar;
  UserInfo({this.id, this.account, this.name, this.email, this.avatar});

  //不同的类使用不同的mixin即可
  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
