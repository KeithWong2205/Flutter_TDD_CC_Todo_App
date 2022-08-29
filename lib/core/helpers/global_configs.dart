class GlobalConfig {
  // Locale
  static const String languageKo = 'ko';
  static const String languageEn = 'en';

  // Dio
  static const int connectTimeOut = 30000;
  static const int receiveTimeout = 30000;

  // Service name
  static const String baseService = 'base';
  static const String paymentService = 'payment';

  // Service URL
  static const Map<String, String> configUrlDebug = {
    baseService: '',
    paymentService: '',
  };

  static const Map<String, String> configUrlRelease = {
    baseService: '',
    paymentService: ''
  };

  // Build type
  static const String dev = 'dev';
  static const String prod = 'prod';
}
