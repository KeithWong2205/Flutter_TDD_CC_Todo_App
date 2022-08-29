import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  final String? mess;
  final int? statusCode;

  ServerFailure({
    this.mess,
    this.statusCode,
  });

  @override
  List<Object> get props => [mess!];
}

class CacheFailure extends Failure {}

class NoConnectionFailure extends Failure {
  final String? mess;

  NoConnectionFailure({
    @required this.mess,
  });
}

class PermissionFailure extends Failure {}

class GoogleLoginFailure extends Failure {
  final String? mess;

  GoogleLoginFailure({
    @required this.mess,
  });
}

class FacebookLoginFailure extends Failure {
  final String? mess;

  FacebookLoginFailure({
    @required this.mess,
  });
}

class AppleLoginFailure extends Failure {
  final String? mess;

  AppleLoginFailure({
    @required this.mess,
  });
}
