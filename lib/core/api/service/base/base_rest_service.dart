import 'package:flutter_tcc_base_source/core/api/service/base/base_rest_client.dart';
import 'package:flutter_tcc_base_source/core/helpers/app_config.dart';
import 'package:flutter_tcc_base_source/core/helpers/app_utils.dart';
import 'package:flutter_tcc_base_source/core/helpers/global_configs.dart';
import 'package:dio/dio.dart';
import 'package:flutter_tcc_base_source/features/authentication/domain/model/response_login_model.dart';

class BaseRestService {
  Dio? dio;

  BaseRestClient? _baseRestClient;

  BaseRestService(this.dio) {
    _baseRestClient = BaseRestClient(
      dio!,
      baseUrl: AppConfig.of(AppUtils.contextMain)
          .configUrl![GlobalConfig.baseService]!,
    );
  }

  Future<ResponseLoginModel> login() async {
    return ResponseLoginModel();
  }
}
