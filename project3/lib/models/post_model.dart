import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class PostModel {
  @HiveField(1)
  @JsonKey(name: "userId")
  int userId;
  @HiveField(3)
  @JsonKey(name: "id")
  int id;
  @HiveField(5)
  @JsonKey(name: "title")
  String title;
  @HiveField(7)
  @JsonKey(name: "body")
  String body;

  PostModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
