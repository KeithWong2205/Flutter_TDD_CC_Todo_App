import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tcc_base_source/core/api/error/failures.dart';
import 'package:flutter_tcc_base_source/core/base/domain/model/response_base_model.dart';
import 'package:flutter_tcc_base_source/features/todo_management/domain/models/todo_model.dart';
import 'package:flutter_tcc_base_source/features/todo_management/domain/usecases/add_todo_case.dart';
import 'package:flutter_tcc_base_source/features/todo_management/domain/usecases/complete_todo_case.dart';
import 'package:flutter_tcc_base_source/features/todo_management/domain/usecases/delete_todo_case.dart';
import 'package:flutter_tcc_base_source/features/todo_management/domain/usecases/edit_todo_case.dart';

part 'todo_management_state.dart';

class TodoManagementCubit extends Cubit<TodoManagementState> {
  final AddTodoCase? addTodoCase;

  final EditTodoCase? editTodoCase;

  final DeleteTodoCase? deleteTodoCase;

  final CompleteTodoCase? completeTodoCase;

  TodoManagementCubit({
    this.addTodoCase,
    this.editTodoCase,
    this.deleteTodoCase,
    this.completeTodoCase,
  }) : super(TodoInitial());

  addTodo(TodoModel todoModel) async {
    Either<Failure, ResponseBaseModel> result = await addTodoCase!.addTodo(todoModel);
    result.fold(
      (l) => emit(AddTodoFailed()),
      (r) => emit(AddTodoSuccess()),
    );
  }

  editTodo(TodoModel todoModel, int index) async {
    Either<Failure, ResponseBaseModel> result = await editTodoCase!.editTodo(todoModel, index);
    result.fold(
      (l) => emit(EditTodoFailed()),
      (r) => emit(EditTodoSuccess()),
    );
  }

  deleteTodo(int index) async {
    Either<Failure, ResponseBaseModel> result = await deleteTodoCase!.deleteTodo(index);
    result.fold(
      (l) => emit(DeleteTodoFailed()),
      (r) => emit(DeleteTodoSuccess()),
    );
  }

  completeTodo(TodoModel todoModel, int index) async {
    Either<Failure, ResponseBaseModel> result = await completeTodoCase!.completeTodo(todoModel, index);
    result.fold(
      (l) => emit(CompleteTodoFailed()),
      (r) => emit(CompleteTodoSuccess()),
    );
  }
}
