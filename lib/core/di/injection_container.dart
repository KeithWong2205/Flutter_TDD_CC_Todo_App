import 'package:flutter_tcc_base_source/core/api/service/base/base_rest_service.dart';
import 'package:flutter_tcc_base_source/core/api/service/payment/payment_rest_service.dart';
import 'package:flutter_tcc_base_source/core/api/service/todo_crud/todo_crud_rest_service.dart';
import 'package:flutter_tcc_base_source/core/base/presentation/cubit/device_info_cubit.dart';
import 'package:flutter_tcc_base_source/core/di/module/network_module.dart';
import 'package:flutter_tcc_base_source/core/helpers/secure_storage.dart';
import 'package:flutter_tcc_base_source/features/authentication/data/authentication_data_source.dart';
import 'package:flutter_tcc_base_source/features/authentication/domain/repository/authentication_repository.dart';
import 'package:flutter_tcc_base_source/features/authentication/domain/usecase/apple_login_case.dart';
import 'package:flutter_tcc_base_source/features/authentication/domain/usecase/facebook_login_case.dart';
import 'package:flutter_tcc_base_source/features/authentication/domain/usecase/google_login_case.dart';
import 'package:flutter_tcc_base_source/features/authentication/domain/usecase/login_case.dart';
import 'package:flutter_tcc_base_source/features/authentication/presentation/cubit/login_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter_tcc_base_source/features/todo_management/data/todo_management_data_source.dart';
import 'package:flutter_tcc_base_source/features/todo_management/domain/repositories/todo_management_repository.dart';
import 'package:flutter_tcc_base_source/features/todo_management/domain/usecases/add_todo_case.dart';
import 'package:flutter_tcc_base_source/features/todo_management/domain/usecases/complete_todo_case.dart';
import 'package:flutter_tcc_base_source/features/todo_management/domain/usecases/delete_todo_case.dart';
import 'package:flutter_tcc_base_source/features/todo_management/domain/usecases/edit_todo_case.dart';
import 'package:flutter_tcc_base_source/features/todo_management/presentation/cubit/todo_management_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Data source
  sl.registerLazySingleton<AuthenticationDataSource>(
    () => AuthenticationDataSourceImpl(
      baseRestService: sl(),
    ),
  );

  sl.registerLazySingleton<TodoManagementDataSource>(
    () => TodoManagementDataSourceImpl(
      todoCrudRestService: sl(),
    ),
  );

  // Repository
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      authenticationDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<TodoManagementRepository>(
    () => TodoManagementRepositoryImpl(
      todoManagementDataSource: sl(),
    ),
  );

  // Use case
  sl.registerLazySingleton<LoginCase>(
    () => LoginCase(
      authenticationRepository: sl(),
    ),
  );

  sl.registerLazySingleton<GoogleLoginCase>(
    () => GoogleLoginCase(
      authenticationRepository: sl(),
    ),
  );

  sl.registerLazySingleton<FacebookLoginCase>(
    () => FacebookLoginCase(
      authenticationRepository: sl(),
    ),
  );

  sl.registerLazySingleton<AppleLoginCase>(
    () => AppleLoginCase(
      authenticationRepository: sl(),
    ),
  );

  sl.registerLazySingleton<AddTodoCase>(
    () => AddTodoCase(
      todoManagementRepository: sl(),
    ),
  );

  sl.registerLazySingleton<EditTodoCase>(
    () => EditTodoCase(
      todoManagementRepository: sl(),
    ),
  );

  sl.registerLazySingleton<DeleteTodoCase>(
    () => DeleteTodoCase(
      todoManagementRepository: sl(),
    ),
  );

  sl.registerLazySingleton<CompleteTodoCase>(
    () => CompleteTodoCase(
      todoManagementRepository: sl(),
    ),
  );

  // Cubit
  sl.registerLazySingleton<LoginCubit>(
    () => LoginCubit(
      loginCase: sl(),
      googleLoginCase: sl(),
      facebookLoginCase: sl(),
      appleLoginCase: sl(),
    ),
  );

  sl.registerLazySingleton<TodoManagementCubit>(
    () => TodoManagementCubit(
      addTodoCase: sl(),
      editTodoCase: sl(),
      deleteTodoCase: sl(),
      completeTodoCase: sl(),
    ),
  );

  sl.registerLazySingleton<DeviceInfoCubit>(
    () => DeviceInfoCubit(),
  );

  // Services
  sl.registerLazySingleton<BaseRestService>(() => BaseRestService(sl()));
  sl.registerLazySingleton<PaymentRestService>(() => PaymentRestService());
  sl.registerLazySingleton<TodoCrudRestService>(() => TodoCrudRestService(sl()));

  // Other
  sl.registerLazySingleton<SecureStorage>(() => SecureStorage());
  sl.registerLazySingleton<Dio>(() => NetworkModule.provideDio());
}
