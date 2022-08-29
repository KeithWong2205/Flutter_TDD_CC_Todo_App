import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'payment_rest_client.g.dart';

@RestApi()
abstract class PaymentRestClient {
  factory PaymentRestClient(Dio dio, {String baseUrl}) = _PaymentRestClient;
}
