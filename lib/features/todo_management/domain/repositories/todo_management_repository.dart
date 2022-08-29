import 'package:dartz/dartz.dart';
import 'package:flutter_tcc_base_source/core/api/error/failures.dart';
import 'package:flutter_tcc_base_source/core/base/domain/model/response_base_model.dart';
import 'package:flutter_tcc_base_source/features/todo_management/data/todo_management_data_source.dart';
import 'package:flutter_tcc_base_source/features/todo_management/domain/models/todo_model.dart';

abstract class TodoManagementRepository {
  Future<Either<Failure, ResponseBaseModel>> addTodo(TodoModel todoModel);

  Future<Either<Failure, ResponseBaseModel>> editTodo(TodoModel todoModel, int index);

  Future<Either<Failure, ResponseBaseModel>> completeTodo(TodoModel todoModel, int index);

  Future<Either<Failure, ResponseBaseModel>> deleteTodo(int index);
}

class TodoManagementRepositoryImpl implements TodoManagementRepository {
  final TodoManagementDataSource? todoManagementDataSource;

  TodoManagementRepositoryImpl({
    this.todoManagementDataSource,
  });

  @override
  Future<Either<Failure, ResponseBaseModel>> addTodo(TodoModel todoModel) async {
    return await todoManagementDataSource!.addTodo(todoModel);
  }

  @override
  Future<Either<Failure, ResponseBaseModel>> deleteTodo(int index) async {
    return await todoManagementDataSource!.deleteTodo(index);
  }

  @override
  Future<Either<Failure, ResponseBaseModel>> editTodo(TodoModel todoModel, int index) async {
    return await todoManagementDataSource!.editTodo(todoModel, index);
  }

  @override
  Future<Either<Failure, ResponseBaseModel>> completeTodo(TodoModel todoModel, int index) async {
    return await todoManagementDataSource!.completeTodo(todoModel, index);
  }
}
