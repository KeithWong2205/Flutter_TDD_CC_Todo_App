import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tcc_base_source/core/di/injection_container.dart';
import 'package:flutter_tcc_base_source/core/helpers/app_navigator.dart';
import 'package:flutter_tcc_base_source/core/helpers/app_utils.dart';
import 'package:flutter_tcc_base_source/core/helpers/base_state.dart';
import 'package:flutter_tcc_base_source/core/helpers/secure_storage.dart';
import 'package:flutter_tcc_base_source/core/navigation/navigation_center.dart';
import 'package:flutter_tcc_base_source/features/todo_management/domain/models/todo_model.dart';
import 'package:flutter_tcc_base_source/features/todo_management/presentation/cubit/todo_management_cubit.dart';
import 'package:flutter_tcc_base_source/features/todo_management/presentation/view/add_edit_todo_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends BaseState<TodoListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoManagementCubit, TodoManagementState>(
      listener: (context, state) async {
        if (state is TodoInitial) {
          debugPrint('===> Todo Initial State');
        } else if (state is CompleteTodoSuccess) {
          AppUtils.showToastMessage("Todo finished successfully");
        } else if (state is CompleteTodoFailed) {
          AppUtils.showToastMessage("Failed to finish todo");
        }
      },
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(context),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            AppNavigator.goToScreen(
                this,
                const AddEditTodoScreen(
                  isEdit: false,
                ),
                NavigationCenter.addEditTodoScreen);
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text('Todo List'),
      actions: [
        IconButton(
            onPressed: () async {
              await sl<SecureStorage>().saveCustomString(SecureStorage.isLoggedIn, "");
              Navigator.of(context).pushNamedAndRemoveUntil(NavigationCenter.loginScreen, (route) => false);
              // AppNavigator.goToScreen(this, const LoginScreen(), NavigationCenter.loginScreen);
            },
            icon: const Icon(Icons.power_settings_new))
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return WatchBoxBuilder(
        box: Hive.box('todos'),
        builder: (context, todoBox) {
          return ListView.builder(
            itemCount: todoBox.length,
            itemBuilder: (BuildContext context, int index) {
              final todo = todoBox.getAt(index) as TodoModel;
              return ListTile(
                leading: Checkbox(
                  value: todo.completed == 1,
                  onChanged: (value) {
                    setState(() {
                      todo.completed == 0 ? todo.completed = 1 : todo.completed = 0;
                    });
                    context.read<TodoManagementCubit>().completeTodo(todo, index);
                  },
                ),
                onTap: () {
                  AppNavigator.goToScreen(
                      this,
                      AddEditTodoScreen(
                        isEdit: true,
                        todoModel: todo,
                        todoIndex: index,
                      ),
                      NavigationCenter.addEditTodoScreen);
                },
                title: Text(todo.title ?? "a"),
                subtitle: Text(todo.description ?? "b"),
                trailing: IconButton(
                  onPressed: () {
                    AppNavigator.goToScreen(
                        this,
                        AddEditTodoScreen(
                          isEdit: true,
                          todoModel: todo,
                          todoIndex: index,
                        ),
                        NavigationCenter.addEditTodoScreen);
                  },
                  icon: const Icon(Icons.info),
                ),
              );
            },
          );
        });
  }
}
