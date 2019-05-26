import 'package:json_annotation/json_annotation.dart';

//  将在我们运行生成命令后自动生成
part 'userinfo.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class UserInfo {
  int exerciseCountTotal;
  String userAvater;
  int rankStudyTimeInWeek;
  String userShowName;
  int exerciseCountWeek;
  int studyTimeWeek;
  int rankStudyTimeInTotal;
  int rankExerciseInWeek;
  String username;
  int studyTimeTotal;
  int studyTimeNum;
  UserInfo(
      {this.exerciseCountTotal,
      this.userAvater,
      this.rankStudyTimeInWeek,
      this.userShowName,
      this.exerciseCountWeek,
      this.studyTimeWeek,
      this.rankStudyTimeInTotal,
      this.rankExerciseInWeek,
      this.username,
      this.studyTimeTotal,
      this.studyTimeNum});

  //不同的类使用不同的mixin即可
  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
