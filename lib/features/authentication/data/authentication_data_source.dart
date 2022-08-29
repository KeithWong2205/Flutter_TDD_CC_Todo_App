import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_tcc_base_source/core/api/error/failures.dart';
import 'package:flutter_tcc_base_source/core/api/service/base/base_rest_service.dart';
import 'package:flutter_tcc_base_source/features/authentication/domain/model/response_login_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

abstract class AuthenticationDataSource {
  Future<Either<Failure, ResponseLoginModel>> login();

  Future<Either<Failure, ResponseLoginModel>> googleLogin();

  Future<Either<Failure, ResponseLoginModel>> facebookLogin();

  Future<Either<Failure, ResponseLoginModel>> appleLogin();
}

class AuthenticationDataSourceImpl implements AuthenticationDataSource {
  final BaseRestService? baseRestService;

  AuthenticationDataSourceImpl({
    @required this.baseRestService,
  });

  @override
  Future<Either<Failure, ResponseLoginModel>> login() async {
    try {
      ResponseLoginModel? responseLoginModel = await baseRestService!.login();
      return Right(responseLoginModel);
    } on DioError catch (e) {
      if (e.response == null) {
        return Left(NoConnectionFailure(mess: 'No connection'));
      } else {
        return Left(
          ServerFailure(
            mess: e.response!.statusMessage,
            statusCode: e.response!.statusCode,
          ),
        );
      }
    }
  }

  @override
  Future<Either<Failure, ResponseLoginModel>> appleLogin() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      debugPrint(credential.authorizationCode);
      return await login();
    } catch (e) {
      return Left(
        AppleLoginFailure(
          mess: 'Error: $e',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ResponseLoginModel>> facebookLogin() async {
    final fb = FacebookLogin();
    try {
      final res = await fb.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);

      switch (res.status) {
        case FacebookLoginStatus.success:
          final FacebookAccessToken accessToken = res.accessToken!;
          debugPrint('Access token: ${accessToken.token}');

          final profile = await fb.getUserProfile();
          debugPrint('Hello, ${profile!.name}! You ID: ${profile.userId}');

          final imageUrl = await fb.getProfileImageUrl(width: 100);
          debugPrint('Your profile image: $imageUrl');

          final email = await fb.getUserEmail();

          if (email != null) {
            debugPrint('And your email is $email');
          }
          return await login();
        case FacebookLoginStatus.cancel:
          return Left(
            FacebookLoginFailure(
              mess: 'User cancel',
            ),
          );
        case FacebookLoginStatus.error:
          return Left(
            FacebookLoginFailure(
              mess: 'Error: ${res.error}',
            ),
          );
      }
    } catch (e) {
      return Left(
        FacebookLoginFailure(
          mess: 'Error: $e',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, ResponseLoginModel>> googleLogin() async {
    try {
      GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      );
      var account = await _googleSignIn.signIn();
      if (account != null) {
        debugPrint('======> google account ${account.email}');
        return login();
      } else {
        return Left(
          GoogleLoginFailure(
            mess: 'Can not get google account',
          ),
        );
      }
    } catch (e) {
      return Left(
        GoogleLoginFailure(
          mess: 'Error: $e',
        ),
      );
    }
  }
}
