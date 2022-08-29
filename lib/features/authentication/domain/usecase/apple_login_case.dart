import 'package:dartz/dartz.dart';
import 'package:flutter_tcc_base_source/core/api/error/failures.dart';
import 'package:flutter_tcc_base_source/features/authentication/domain/model/response_login_model.dart';
import 'package:flutter_tcc_base_source/features/authentication/domain/repository/authentication_repository.dart';

class AppleLoginCase {
  final AuthenticationRepository? authenticationRepository;

  AppleLoginCase({
    this.authenticationRepository,
  });

  Future<Either<Failure, ResponseLoginModel>> appleLogin() async =>
      authenticationRepository!.appleLogin();
}
