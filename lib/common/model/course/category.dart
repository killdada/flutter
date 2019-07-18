import 'package:json_annotation/json_annotation.dart';

//  将在我们运行生成命令后自动生成
part 'category.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class CategoryModel {
  String categoryName;
  int categoryId;

  CategoryModel({this.categoryName, this.categoryId});

  //不同的类使用不同的mixin即可
  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
