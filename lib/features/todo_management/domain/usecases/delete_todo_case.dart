import 'package:dartz/dartz.dart';
import 'package:flutter_tcc_base_source/core/api/error/failures.dart';
import 'package:flutter_tcc_base_source/core/base/domain/model/response_base_model.dart';
import 'package:flutter_tcc_base_source/features/todo_management/domain/repositories/todo_management_repository.dart';

class DeleteTodoCase {
  final TodoManagementRepository? todoManagementRepository;

  DeleteTodoCase({
    this.todoManagementRepository,
  });

  Future<Either<Failure, ResponseBaseModel>> deleteTodo(int index) async => todoManagementRepository!.deleteTodo(index);
}
