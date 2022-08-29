import 'package:json_annotation/json_annotation.dart';

part 'response_base_model.g.dart';

@JsonSerializable()
class ResponseBaseModel {
  ResponseBaseModel();

  factory ResponseBaseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseBaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseBaseModelToJson(this);
}
