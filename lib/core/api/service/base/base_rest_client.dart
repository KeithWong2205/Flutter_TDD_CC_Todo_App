import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'base_rest_client.g.dart';

@RestApi()
abstract class BaseRestClient {
  factory BaseRestClient(Dio dio, {String baseUrl}) = _BaseRestClient;
}
