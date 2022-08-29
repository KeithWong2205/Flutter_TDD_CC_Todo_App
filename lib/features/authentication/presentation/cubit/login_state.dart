part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {
  final ResponseLoginModel responseLoginModel;

  LoginSuccess({
    required this.responseLoginModel,
  });

  List<Object> get props => [responseLoginModel];
}

class LoginGoogleSuccess extends LoginState {
  final ResponseLoginModel responseLoginModel;

  LoginGoogleSuccess({
    required this.responseLoginModel,
  });

  List<Object> get props => [responseLoginModel];
}

class LoginFacebookSuccess extends LoginState {
  final ResponseLoginModel responseLoginModel;

  LoginFacebookSuccess({
    required this.responseLoginModel,
  });

  List<Object> get props => [responseLoginModel];
}

class LoginAppleSuccess extends LoginState {
  final ResponseLoginModel responseLoginModel;

  LoginAppleSuccess({
    required this.responseLoginModel,
  });

  List<Object> get props => [responseLoginModel];
}

class LoginFailed extends LoginState {
  LoginFailed();

  List<Object> get props => [];
}
