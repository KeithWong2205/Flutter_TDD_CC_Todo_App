import 'package:flutter_tcc_base_source/core/helpers/app_utils.dart';
import 'package:flutter_tcc_base_source/core/helpers/base_state.dart';
import 'package:flutter/material.dart';

class AppNavigator {
  static goToScreen(
    BaseState base,
    StatefulWidget screen,
    String name,
  ) =>
      base.push(
        AppUtils.contextMain,
        MaterialPageRoute(
          settings: RouteSettings(
            name: name,
          ),
          builder: (_) => screen,
          fullscreenDialog: true,
        ),
      );

  static close(BuildContext context) => Navigator.pop(context);
}
