import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tcc_base_source/core/base/presentation/widget/base_text_field.dart';
import 'package:flutter_tcc_base_source/core/helpers/app_navigator.dart';
import 'package:flutter_tcc_base_source/core/helpers/app_utils.dart';
import 'package:flutter_tcc_base_source/core/helpers/base_state.dart';
import 'package:flutter_tcc_base_source/features/todo_management/domain/models/todo_model.dart';
import 'package:flutter_tcc_base_source/features/todo_management/presentation/cubit/todo_management_cubit.dart';

class AddEditTodoScreen extends StatefulWidget {
  final int? todoIndex;
  final TodoModel? todoModel;
  final bool isEdit;

  const AddEditTodoScreen({Key? key, required this.isEdit, this.todoIndex, this.todoModel}) : super(key: key);

  @override
  _AddEditTodoScreenState createState() => _AddEditTodoScreenState();
}

class _AddEditTodoScreenState extends BaseState<AddEditTodoScreen> {
  late TodoModel todoModel;
  final _formKey = GlobalKey<FormState>();

  //region InitState
  @override
  void initState() {
    super.initState();
    todoModel = widget.todoModel ?? TodoModel();
  }

  //endregion

  //region Main build Method
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<TodoManagementCubit, TodoManagementState>(
      listener: (context, state) async {
        if (state is TodoInitial) {
          debugPrint('===> Todo Initial State');
        } else if (state is AddTodoSuccess) {
          AppUtils.showToastMessage("Todo added successfully");
          AppNavigator.close(context);
        } else if (state is EditTodoSuccess) {
          AppUtils.showToastMessage("Todo edited successfully");
          AppNavigator.close(context);
        } else if (state is DeleteTodoSuccess) {
          AppUtils.showToastMessage("Todo deleted successfully");
          AppNavigator.close(context);
        } else if (state is AddTodoFailed || state is EditTodoFailed || state is DeleteTodoFailed) {
          AppUtils.showToastMessage("Failed to do action");
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: _buildBody(context),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              FocusScope.of(context).unfocus();
              if (widget.isEdit) {
                if (_formKey.currentState!.validate()) {
                  todoModel.completed = 0;
                  debugPrint("=====> Catch validation true");
                  context.read<TodoManagementCubit>().editTodo(todoModel, widget.todoIndex!);
                }
              } else {
                if (_formKey.currentState!.validate()) {
                  todoModel.completed = 0;
                  debugPrint("=====> Catch validation true");
                  context.read<TodoManagementCubit>().addTodo(todoModel);
                }
              }
            },
            label: const Text('Save'),
            icon: const Icon(Icons.save),
          ),
        ),
      ),
    );
  }

  //endregion

  //region Widget Building methods

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Add Todo'),
      actions: [
        widget.isEdit
            ? IconButton(
                onPressed: () {
                  context.read<TodoManagementCubit>().deleteTodo(widget.todoIndex!);
                },
                icon: const Icon(Icons.delete))
            : SizedBox.shrink(),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text("Todo title"),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "What do you want to do",
                ),
                initialValue: todoModel.title,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field is required";
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  setState(() {
                    todoModel.title = value;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text("Todo description"),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: "What is it really about?",
                ),
                initialValue: todoModel.description,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field is required";
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  setState(() {
                    todoModel.description = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
//endregion
}
