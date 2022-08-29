import 'package:flutter_tcc_base_source/core/api/service/base/base_rest_service.dart';
import 'package:flutter_tcc_base_source/core/api/service/payment/payment_rest_client.dart';
import 'package:flutter_tcc_base_source/core/helpers/app_config.dart';
import 'package:flutter_tcc_base_source/core/helpers/app_utils.dart';
import 'package:flutter_tcc_base_source/core/helpers/global_configs.dart';
import 'package:dio/dio.dart';

class PaymentRestService extends BaseRestService {
  PaymentRestClient? _paymentRestClient;

  PaymentRestService() : super(Dio()) {
    _paymentRestClient = PaymentRestClient(
      dio!,
      baseUrl: AppConfig.of(AppUtils.contextMain)
          .configUrl![GlobalConfig.paymentService]!,
    );
  }
}
