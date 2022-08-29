import 'package:flutter_tcc_base_source/features/authentication/presentation/view/login_screen.dart';
import 'package:flutter_tcc_base_source/features/home/presentation/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tcc_base_source/features/todo_management/presentation/view/add_edit_todo_screen.dart';
import 'package:flutter_tcc_base_source/features/todo_management/presentation/view/todo_list_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';

class NavigationCenter {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static const String homeScreen = '/home-screen';
  static const String todoListScreen = '/todo-list-screen';
  static const String addEditTodoScreen = '/add-edit-todo-screen';
  static const String loginScreen = '/login-screen';
  static const String introductionScreen = '/introduction-screen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case introductionScreen:
        return MaterialPageRoute(
          builder: (_) => IntroductionScreen(),
          settings: const RouteSettings(
            name: introductionScreen,
          ),
        );
      case homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: const RouteSettings(
            name: homeScreen,
          ),
        );
      case loginScreen:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: const RouteSettings(
            name: homeScreen,
          ),
        );
      case todoListScreen:
        return MaterialPageRoute(
          builder: (_) => const TodoListScreen(),
          settings: const RouteSettings(name: todoListScreen),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
