import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tcc_base_source/core/api/error/failures.dart';
import 'package:flutter_tcc_base_source/features/authentication/domain/model/response_login_model.dart';
import 'package:flutter_tcc_base_source/features/authentication/domain/usecase/apple_login_case.dart';
import 'package:flutter_tcc_base_source/features/authentication/domain/usecase/facebook_login_case.dart';
import 'package:flutter_tcc_base_source/features/authentication/domain/usecase/google_login_case.dart';
import 'package:flutter_tcc_base_source/features/authentication/domain/usecase/login_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginCase? loginCase;

  final GoogleLoginCase? googleLoginCase;

  final FacebookLoginCase? facebookLoginCase;

  final AppleLoginCase? appleLoginCase;

  LoginCubit({
    this.loginCase,
    this.googleLoginCase,
    this.facebookLoginCase,
    this.appleLoginCase,
  }) : super(LoginInitial());

  login() async {
    Either<Failure, ResponseLoginModel> result = await loginCase!.login();
    result.fold(
      (l) => emit(LoginFailed()),
      (r) => emit(LoginSuccess(responseLoginModel: r)),
    );
  }

  loginGoogle() async {
    Either<Failure, ResponseLoginModel> result =
        await googleLoginCase!.googleLogin();
    result.fold(
      (l) => emit(LoginFailed()),
      (r) => emit(LoginSuccess(responseLoginModel: r)),
    );
  }

  loginFacebook() async {
    Either<Failure, ResponseLoginModel> result =
        await facebookLoginCase!.facebookLogin();
    result.fold(
      (l) => emit(LoginFailed()),
      (r) => emit(LoginSuccess(responseLoginModel: r)),
    );
  }

  loginApple() async {
    Either<Failure, ResponseLoginModel> result =
        await appleLoginCase!.appleLogin();
    result.fold(
      (l) => emit(LoginFailed()),
      (r) => emit(LoginSuccess(responseLoginModel: r)),
    );
  }
}
