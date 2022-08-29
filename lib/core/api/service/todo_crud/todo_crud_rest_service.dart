import 'package:dio/dio.dart';
import 'package:flutter_tcc_base_source/core/api/service/todo_crud/todo_crud_rest_client.dart';
import 'package:flutter_tcc_base_source/core/base/domain/model/response_base_model.dart';
import 'package:flutter_tcc_base_source/core/helpers/app_config.dart';
import 'package:flutter_tcc_base_source/core/helpers/app_utils.dart';
import 'package:flutter_tcc_base_source/core/helpers/global_configs.dart';

class TodoCrudRestService {
  Dio? dio;
  TodoCrudRestClient? _todoCrudRestClient;

  TodoCrudRestService(this.dio) {
    _todoCrudRestClient = TodoCrudRestClient(
      dio!,
      baseUrl: AppConfig.of(AppUtils.contextMain).configUrl![GlobalConfig.baseService]!,
    );
  }

  Future<ResponseBaseModel> addTodo() async {
    return ResponseBaseModel();
  }

  Future<ResponseBaseModel> editTodo() async {
    return ResponseBaseModel();
  }

  Future<ResponseBaseModel> deleteTodo() async {
    return ResponseBaseModel();
  }

  Future<ResponseBaseModel> completeTodo() async {
    return ResponseBaseModel();
  }
}
