import 'package:dartz/dartz.dart';
import 'package:flutter_tcc_base_source/core/api/error/failures.dart';
import 'package:flutter_tcc_base_source/core/base/domain/model/response_base_model.dart';
import 'package:flutter_tcc_base_source/features/todo_management/domain/models/todo_model.dart';
import 'package:flutter_tcc_base_source/features/todo_management/domain/repositories/todo_management_repository.dart';

class EditTodoCase {
  final TodoManagementRepository? todoManagementRepository;

  EditTodoCase({
    this.todoManagementRepository,
  });

  Future<Either<Failure, ResponseBaseModel>> editTodo(TodoModel todoModel, int index) async =>
      todoManagementRepository!.editTodo(todoModel, index);
}
