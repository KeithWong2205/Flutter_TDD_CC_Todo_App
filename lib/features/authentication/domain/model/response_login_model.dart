import 'package:flutter_tcc_base_source/core/base/domain/model/response_base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_login_model.g.dart';

@JsonSerializable()
class ResponseLoginModel extends ResponseBaseModel {
  ResponseLoginModel();

  factory ResponseLoginModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseLoginModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ResponseLoginModelToJson(this);
}
