import 'dart:async';

import 'package:flutter_tcc_base_source/core/di/injection_container.dart' as di;
import 'package:flutter_tcc_base_source/core/navigation/navigation_center.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppUtils {
  static const platform = MethodChannel('flutter.native/helper');

  static BuildContext get contextMain =>
      NavigationCenter.navigatorKey.currentState!.overlay!.context;

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await di.init();
  }

  static showToastMessage(String message, {BuildContext? context}) {
    if (message.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 500), () {
        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black.withOpacity(0.6),
          textColor: Colors.white,
        );
      });
    }
  }

  static double resizeHeightUtil(BuildContext context, double value) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenDesignHeight = 1280;
    return (screenHeight * value) / screenDesignHeight;
  }

  static double resizeWidthUtil(BuildContext context, double value) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenDesignWidth = 1280;
    return (screenWidth * value) / screenDesignWidth;
  }
}
