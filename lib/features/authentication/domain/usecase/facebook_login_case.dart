import 'package:dartz/dartz.dart';
import 'package:flutter_tcc_base_source/core/api/error/failures.dart';
import 'package:flutter_tcc_base_source/features/authentication/domain/model/response_login_model.dart';
import 'package:flutter_tcc_base_source/features/authentication/domain/repository/authentication_repository.dart';

class FacebookLoginCase {
  final AuthenticationRepository? authenticationRepository;

  FacebookLoginCase({
    this.authenticationRepository,
  });

  Future<Either<Failure, ResponseLoginModel>> facebookLogin() async =>
      authenticationRepository!.facebookLogin();
}
