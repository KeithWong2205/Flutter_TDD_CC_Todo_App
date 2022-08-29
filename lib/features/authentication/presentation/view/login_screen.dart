import 'dart:io';
import 'package:flutter_tcc_base_source/core/base/presentation/cubit/device_info_cubit.dart';
import 'package:flutter_tcc_base_source/core/di/injection_container.dart';
import 'package:flutter_tcc_base_source/core/helpers/app_constants.dart';
import 'package:flutter_tcc_base_source/core/helpers/app_navigator.dart';
import 'package:flutter_tcc_base_source/core/helpers/app_utils.dart';
import 'package:flutter_tcc_base_source/core/helpers/base_state.dart';
import 'package:flutter_tcc_base_source/core/helpers/secure_storage.dart';
import 'package:flutter_tcc_base_source/core/navigation/navigation_center.dart';
import 'package:flutter_tcc_base_source/features/authentication/presentation/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tcc_base_source/features/todo_management/presentation/view/todo_list_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DeviceInfoCubit>().getVersionBuildInfo();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginInitial) {
          debugPrint('====> login init state');
        } else if (state is LoginSuccess) {
          AppUtils.showToastMessage(loc!.login.loginSuccess);
          AppNavigator.goToScreen(this, const TodoListScreen(), NavigationCenter.todoListScreen);
          await sl<SecureStorage>().saveCustomString(SecureStorage.isLoggedIn, 'true');
        } else if (state is LoginFailed) {
          AppUtils.showToastMessage(loc!.login.loginFailed);
        }
      },
      child: Scaffold(
        backgroundColor: AppConstants.color828796,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => context.read<LoginCubit>().login(),
                child: Text(
                  loc!.login.login,
                  style: AppConstants.textDefault.apply(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => context.read<LoginCubit>().loginGoogle(),
                child: Text(
                  loc!.login.loginGoogle,
                  style: AppConstants.textDefault.apply(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => context.read<LoginCubit>().loginFacebook(),
                child: Text(
                  loc!.login.loginFacebook,
                  style: AppConstants.textDefault.apply(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Visibility(
                visible: Platform.isIOS,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => context.read<LoginCubit>().loginApple(),
                  child: Text(
                    loc!.login.loginApple,
                    style: AppConstants.textDefault.apply(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              BlocBuilder<DeviceInfoCubit, DeviceInfoState>(
                builder: (context, state) {
                  String versionName = '';
                  String buildNumber = '';
                  if (state is DeviceInfoSuccess) {
                    versionName = state.versionName;
                    buildNumber = state.buildNumber;
                  }
                  return Text(
                    '${loc!.common.versionName}: $versionName ${loc!.common.buildNumber}: $buildNumber',
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
