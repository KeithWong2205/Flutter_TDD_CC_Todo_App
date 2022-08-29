import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tcc_base_source/core/api/error/failures.dart';
import 'package:flutter_tcc_base_source/core/api/service/todo_crud/todo_crud_rest_service.dart';
import 'package:flutter_tcc_base_source/core/base/domain/model/response_base_model.dart';
import 'package:flutter_tcc_base_source/features/todo_management/domain/models/todo_model.dart';
import 'package:hive/hive.dart';

abstract class TodoManagementDataSource {
  Future<Either<Failure, ResponseBaseModel>> addTodo(TodoModel todoModel);

  Future<Either<Failure, ResponseBaseModel>> editTodo(TodoModel todoModel, int index);

  Future<Either<Failure, ResponseBaseModel>> completeTodo(TodoModel todoModel, int index);

  Future<Either<Failure, ResponseBaseModel>> deleteTodo(int index);
}

class TodoManagementDataSourceImpl implements TodoManagementDataSource {
  final TodoCrudRestService? todoCrudRestService;
  var todoBox = Hive.box('todos');

  TodoManagementDataSourceImpl({
    @required this.todoCrudRestService,
  });


  @override
  Future<Either<Failure, ResponseBaseModel>> addTodo(TodoModel todoModel) async {
    try {
      todoBox.add(todoModel);
      ResponseBaseModel? response = await todoCrudRestService!.addTodo();
      return Right(response);
    } on DioError catch (e) {
      if (e.response == null) {
        return Left(NoConnectionFailure(mess: 'No connection'));
      } else {
        return Left(
          ServerFailure(
            mess: e.response!.statusMessage,
            statusCode: e.response!.statusCode,
          ),
        );
      }
    }
  }

  @override
  Future<Either<Failure, ResponseBaseModel>> deleteTodo(int index) async {
    try {
      todoBox.deleteAt(index);
      ResponseBaseModel? response = await todoCrudRestService!.deleteTodo();
      return Right(response);
    } on DioError catch (e) {
      if (e.response == null) {
        return Left(NoConnectionFailure(mess: 'No connection'));
      } else {
        return Left(
          ServerFailure(
            mess: e.response!.statusMessage,
            statusCode: e.response!.statusCode,
          ),
        );
      }
    }
  }

  @override
  Future<Either<Failure, ResponseBaseModel>> editTodo(TodoModel todoModel, int index) async {
    try {
      todoBox.putAt(index, todoModel);
      ResponseBaseModel? response = await todoCrudRestService!.editTodo();
      return Right(response);
    } on DioError catch (e) {
      if (e.response == null) {
        return Left(NoConnectionFailure(mess: 'No connection'));
      } else {
        return Left(
          ServerFailure(
            mess: e.response!.statusMessage,
            statusCode: e.response!.statusCode,
          ),
        );
      }
    }
  }

  @override
  Future<Either<Failure, ResponseBaseModel>> completeTodo(TodoModel todoModel, int index) async {
    try {
      todoBox.putAt(index, todoModel);
      ResponseBaseModel? response = await todoCrudRestService!.completeTodo();
      return Right(response);
    } on DioError catch (e) {
      if (e.response == null) {
        return Left(NoConnectionFailure(mess: 'No connection'));
      } else {
        return Left(
          ServerFailure(
            mess: e.response!.statusMessage,
            statusCode: e.response!.statusCode,
          ),
        );
      }
    }
  }
}
