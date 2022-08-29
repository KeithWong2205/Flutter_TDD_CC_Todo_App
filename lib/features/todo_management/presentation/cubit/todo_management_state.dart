part of 'todo_management_cubit.dart';

abstract class TodoManagementState {}

class TodoInitial extends TodoManagementState {}

class AddTodoSuccess extends TodoManagementState {
  AddTodoSuccess();

  List<Object> get props => [];
}

class EditTodoSuccess extends TodoManagementState {
  EditTodoSuccess();

  List<Object> get props => [];
}

class DeleteTodoSuccess extends TodoManagementState {
  DeleteTodoSuccess();

  List<Object> get props => [];
}

class CompleteTodoSuccess extends TodoManagementState {
  CompleteTodoSuccess();

  List<Object> get props => [];
}

class AddTodoFailed extends TodoManagementState {
  AddTodoFailed();

  List<Object> get props => [];
}

class EditTodoFailed extends TodoManagementState {
  EditTodoFailed();

  List<Object> get props => [];
}

class DeleteTodoFailed extends TodoManagementState {
  DeleteTodoFailed();

  List<Object> get props => [];
}

class CompleteTodoFailed extends TodoManagementState {
  CompleteTodoFailed();

  List<Object> get props => [];
}
