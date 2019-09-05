import 'package:json_annotation/json_annotation.dart';

//  将在我们运行生成命令后自动生成
part 'practice_overview_model.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class PracticeOverviewModel {
  int topicId;
  String relatedCategory;
  String relatedCourse;
  String publishDate;
  String topic;
  String publisher;
  List replylist;

  PracticeOverviewModel(
      {this.topicId,
      this.relatedCategory,
      this.relatedCourse,
      this.publishDate,
      this.topic,
      this.publisher,
      this.replylist});

  //不同的类使用不同的mixin即可
  factory PracticeOverviewModel.fromJson(Map<String, dynamic> json) =>
      _$PracticeOverviewModelFromJson(json);
  Map<String, dynamic> toJson() => _$PracticeOverviewModelToJson(this);
}
