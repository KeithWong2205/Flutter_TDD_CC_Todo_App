import 'package:dartz/dartz.dart';
import 'package:flutter_tcc_base_source/core/api/error/failures.dart';
import 'package:flutter_tcc_base_source/features/authentication/data/authentication_data_source.dart';
import 'package:flutter_tcc_base_source/features/authentication/domain/model/response_login_model.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, ResponseLoginModel>> login();

  Future<Either<Failure, ResponseLoginModel>> googleLogin();

  Future<Either<Failure, ResponseLoginModel>> facebookLogin();

  Future<Either<Failure, ResponseLoginModel>> appleLogin();
}

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationDataSource? authenticationDataSource;

  AuthenticationRepositoryImpl({
    this.authenticationDataSource,
  });

  @override
  Future<Either<Failure, ResponseLoginModel>> appleLogin() async {
    return await authenticationDataSource!.appleLogin();
  }

  @override
  Future<Either<Failure, ResponseLoginModel>> facebookLogin() async {
    return await authenticationDataSource!.facebookLogin();
  }

  @override
  Future<Either<Failure, ResponseLoginModel>> googleLogin() async {
    return await authenticationDataSource!.googleLogin();
  }

  @override
  Future<Either<Failure, ResponseLoginModel>> login() async {
    return await authenticationDataSource!.login();
  }
}
