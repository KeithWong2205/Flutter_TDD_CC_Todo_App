import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'todo_crud_rest_client.g.dart';

@RestApi()
abstract class TodoCrudRestClient {
  factory TodoCrudRestClient(Dio dio, {String baseUrl}) = _TodoCrudRestClient;
}